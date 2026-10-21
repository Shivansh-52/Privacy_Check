
package com.privacycheck.servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/google/login")
public class GoogleLoginServlet extends HttpServlet {

    private static final SecureRandom RANDOM = new SecureRandom();

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

        try {
            String clientId = requiredEnv("GOOGLE_CLIENT_ID");
            String redirectUri = requiredEnv("GOOGLE_REDIRECT_URI");

            byte[] randomBytes = new byte[32];
            RANDOM.nextBytes(randomBytes);
            String state = Base64.getUrlEncoder()
                    .withoutPadding()
                    .encodeToString(randomBytes);

            HttpSession session = request.getSession(true);
            session.setAttribute("GOOGLE_OAUTH_STATE", state);

            String authUrl =
                    "https://accounts.google.com/o/oauth2/v2/auth"
                    + "?client_id=" + encode(clientId)
                    + "&redirect_uri=" + encode(redirectUri)
                    + "&response_type=code"
                    + "&scope=" + encode("openid email profile")
                    + "&state=" + encode(state)
                    + "&prompt=select_account";

            response.sendRedirect(authUrl);

        } catch (IllegalStateException ex) {
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Google Sign-In is not configured. Check the server environment variables.");
        }
    }

    private String encode(String value) {
        return URLEncoder.encode(value, StandardCharsets.UTF_8);
    }
}
