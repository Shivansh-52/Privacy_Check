
package com.privacycheck.servlet;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

import com.privacycheck.dao.GoogleAuthDAO;
import com.privacycheck.dao.GoogleAuthDAO.GoogleUser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Collections;

@WebServlet("/google/callback")
public class GoogleCallbackServlet extends HttpServlet {

    private String requiredEnv(String name) {
        String value = System.getenv(name);

        if (value == null || value.isBlank()) {
            throw new IllegalStateException(
                    "Missing environment variable: " + name);
        }

        return value;
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Handle cancellation or denial from Google.
        if (request.getParameter("error") != null) {
            response.sendRedirect(
                    request.getContextPath() + "/login?google=cancelled");
            return;
        }

        HttpSession existingSession = request.getSession(false);

        if (existingSession == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login?google=session-expired");
            return;
        }

        // Validate OAuth state to protect against CSRF.
        String expectedState = (String) existingSession.getAttribute(
                "GOOGLE_OAUTH_STATE");
        String returnedState = request.getParameter("state");

        // State must not be reusable.
        existingSession.removeAttribute("GOOGLE_OAUTH_STATE");

        if (expectedState == null || returnedState == null
                || !MessageDigest.isEqual(
                        expectedState.getBytes(StandardCharsets.UTF_8),
                        returnedState.getBytes(StandardCharsets.UTF_8))) {

            response.sendRedirect(
                    request.getContextPath() + "/login?google=invalid-state");
            return;
        }

        String code = request.getParameter("code");

        if (code == null || code.isBlank()) {
            response.sendRedirect(
                    request.getContextPath() + "/login?google=no-code");
            return;
        }

        try {
            String clientId = requiredEnv("GOOGLE_CLIENT_ID");
            String clientSecret = requiredEnv("GOOGLE_CLIENT_SECRET");
            String redirectUri = requiredEnv("GOOGLE_REDIRECT_URI");

            NetHttpTransport transport = new NetHttpTransport();
            JacksonFactory jsonFactory =
                    JacksonFactory.getDefaultInstance();

            // Exchange the authorization code for tokens.
            GoogleTokenResponse tokenResponse =
                    new GoogleAuthorizationCodeTokenRequest(
                            transport,
                            jsonFactory,
                            clientId,
                            clientSecret,
                            code,
                            redirectUri
                    ).execute();

            String idTokenString = tokenResponse.getIdToken();

            if (idTokenString == null || idTokenString.isBlank()) {
                throw new IllegalStateException(
                        "Google did not return an ID token.");
            }

            // Verify the ID token and its audience.
            GoogleIdTokenVerifier verifier =
                    new GoogleIdTokenVerifier.Builder(
                            transport, jsonFactory)
                            .setAudience(Collections.singletonList(clientId))
                            .build();

            GoogleIdToken idToken = verifier.verify(idTokenString);

            if (idToken == null) {
                throw new SecurityException(
                        "Google ID token verification failed.");
            }

            GoogleIdToken.Payload payload = idToken.getPayload();

            String googleSubject = payload.getSubject();
            String email = payload.getEmail();
            Boolean emailVerified = payload.getEmailVerified();
            String name = (String) payload.get("name");

            if (googleSubject == null || googleSubject.isBlank()
                    || email == null || email.isBlank()
                    || !Boolean.TRUE.equals(emailVerified)) {
                throw new SecurityException(
                        "Google identity or verified email is missing.");
            }

            // Find or create the Oracle account.
            GoogleAuthDAO dao = new GoogleAuthDAO();
            GoogleUser user;

            try {
                user = dao.findOrCreate(
                        googleSubject, email, name);

            } catch (GoogleAuthDAO.ExistingAccountException ex) {
                // An existing account requires a separate,
                // authenticated account-linking process.
                response.sendRedirect(
                        request.getContextPath()
                        + "/login?google=existing");
                return;
            }

            // Prevent session fixation after successful authentication.
            existingSession.invalidate();

            HttpSession session = request.getSession(true);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            session.setMaxInactiveInterval(30 * 60);

            response.setHeader(
                    "Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            response.sendRedirect(
                    request.getContextPath() + "/dashboard");

        } catch (Exception ex) {
            getServletContext().log(
                    "Google OAuth callback failed: "
                    + ex.getClass().getSimpleName()
                    + ": " + ex.getMessage(),
                    ex);

            if (!response.isCommitted()) {
                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Google Sign-In failed. Check the Tomcat server log.");
            }
        }
    }
}
