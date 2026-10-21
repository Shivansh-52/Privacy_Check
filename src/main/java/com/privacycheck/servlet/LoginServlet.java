
package com.privacycheck.servlet;

import com.privacycheck.dao.AuthDAO;
import com.privacycheck.dao.AuthDAO.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AuthDAO dao = new AuthDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            User user = (email == null || password == null)
                    ? null : dao.authenticate(email, password);

            if (user == null) {
                req.setAttribute("error",
                    "Invalid email or password. If you registered with "
                    + "Google, use Google sign-in.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }

            HttpSession old = req.getSession(false);
            if (old != null) old.invalidate();

            HttpSession session = req.getSession(true);
            req.changeSessionId();
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());

            resp.sendRedirect(req.getContextPath() + "/dashboard");

        } catch (SQLException e) {
            throw new ServletException("Login failed.", e);
        }
    }
}
