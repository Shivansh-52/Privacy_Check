
package com.privacycheck.servlet;

import com.privacycheck.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String sql =
                "SELECT d.total_services, "
                + "d.high_risk_services, "
                + "d.medium_risk_services, "
                + "d.low_risk_services, "
                + "d.overdue_reviews, "
                + "d.reviews_next_7_days "
                + "FROM VW_DASHBOARD_STATS d "
                + "JOIN APP_USER u ON u.user_id = d.user_id "
                + "WHERE u.email = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            // Demo account from the sample database.
            statement.setString(1, "shivansh@example.com");

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    request.setAttribute(
                            "totalServices",
                            rs.getInt("total_services"));

                    request.setAttribute(
                            "highRisk",
                            rs.getInt("high_risk_services"));

                    request.setAttribute(
                            "mediumRisk",
                            rs.getInt("medium_risk_services"));

                    request.setAttribute(
                            "lowRisk",
                            rs.getInt("low_risk_services"));

                    request.setAttribute(
                            "overdueReviews",
                            rs.getInt("overdue_reviews"));

                    request.setAttribute(
                            "upcomingReviews",
                            rs.getInt("reviews_next_7_days"));
                } else {
                    request.setAttribute("totalServices", 0);
                    request.setAttribute("highRisk", 0);
                    request.setAttribute("mediumRisk", 0);
                    request.setAttribute("lowRisk", 0);
                    request.setAttribute("overdueReviews", 0);
                    request.setAttribute("upcomingReviews", 0);
                }
            }

            request.getRequestDispatcher("/dashboard.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to load the PrivacyCheck dashboard. "
                    + "Check the database driver, connection, and tables.",
                    e);
        }
    }
}
