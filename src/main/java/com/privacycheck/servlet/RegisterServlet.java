
package com.privacycheck.servlet;

import com.privacycheck.dao.AuthDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final AuthDAO dao = new AuthDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirmPassword");

        if (name == null || name.isBlank()
                || email == null || email.isBlank()
                || password == null || password.length() < 12
                || !password.equals(confirm)) {
            req.setAttribute("error",
                "Enter your name and email, use a password of at least "
                + "12 characters, and ensure both passwords match.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        try {
            dao.register(name, email, password);
            resp.sendRedirect(req.getContextPath() + "/login?registered=1");
        } catch (SQLException e) {
            if (e.getErrorCode() == 1) {
                req.setAttribute("error",
                    "That email is already registered. Please log in.");
            } else {
                throw new ServletException("Registration failed.", e);
            }
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
