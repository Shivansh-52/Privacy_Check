
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
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/reminders")
public class ReviewRemindersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<ReviewRecord> reminders = new ArrayList<>();

        String sql = """
            SELECT service_id, service_name, category,
                   risk_level, next_review_date,
                   CASE
                       WHEN next_review_date < TRUNC(SYSDATE)
                           THEN 'OVERDUE'
                       ELSE 'UPCOMING'
                   END AS review_status
            FROM VW_SERVICE_INVENTORY
            WHERE email = ?
              AND next_review_date IS NOT NULL
              AND next_review_date < TRUNC(SYSDATE) + 7
            ORDER BY next_review_date
            """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Temporary demo account; replace after login is implemented.
            ps.setString(1, "shivansh@example.com");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReviewRecord record = new ReviewRecord();

                    record.setId(rs.getInt("service_id"));
                    record.setServiceName(
                            rs.getString("service_name"));
                    record.setCategory(rs.getString("category"));
                    record.setRisk(rs.getString("risk_level"));

                    Date date = rs.getDate("next_review_date");
                    record.setReviewDate(
                            date == null
                            ? "Not scheduled"
                            : date.toString());

                    record.setStatus(
                            rs.getString("review_status"));

                    reminders.add(record);
                }
            }

            long overdue = reminders.stream()
                    .filter(r -> "OVERDUE".equals(r.getStatus()))
                    .count();

            request.setAttribute("reminders", reminders);
            request.setAttribute("reminderCount", reminders.size());
            request.setAttribute("overdueCount", overdue);
            request.setAttribute(
                    "upcomingCount", reminders.size() - overdue);

            request.getRequestDispatcher("/reminders.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to load review reminders from Oracle.", e);
        }
    }

    public static class ReviewRecord {
        private int id;
        private String serviceName;
        private String category;
        private String risk;
        private String reviewDate;
        private String status;

        public int getId() { return id; }
        public void setId(int id) { this.id = id; }

        public String getServiceName() { return serviceName; }
        public void setServiceName(String value) {
            this.serviceName = value;
        }

        public String getCategory() { return category; }
        public void setCategory(String value) {
            this.category = value;
        }

        public String getRisk() { return risk; }
        public void setRisk(String value) { this.risk = value; }

        public String getReviewDate() { return reviewDate; }
        public void setReviewDate(String value) {
            this.reviewDate = value;
        }

        public String getStatus() { return status; }
        public void setStatus(String value) {
            this.status = value;
        }
    }
}
