
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

@WebServlet("/shared-data")
public class SharedDataServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<SharedDataRecord> records = new ArrayList<>();

        String sql = """
            SELECT sd.shared_data_id,
                   sd.service_id,
                   os.service_name,
                   os.category AS data_category,
                   sd.notes,
                   sd.shared_since
            FROM SHARED_DATA sd
            JOIN ONLINE_SERVICE os
                ON sd.service_id = os.service_id
            JOIN APP_USER u
                ON os.user_id = u.user_id
            WHERE LOWER(u.email) = LOWER(?)
            ORDER BY sd.shared_data_id
            """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "shivansh@example.com");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SharedDataRecord record = new SharedDataRecord();

                    record.setId(rs.getInt("shared_data_id"));
                    record.setServiceId(rs.getInt("service_id"));
                    record.setServiceName(rs.getString("service_name"));
                    record.setCategory(rs.getString("data_category"));
                    record.setNotes(rs.getString("notes"));

                    Date date = rs.getDate("shared_since");
                    record.setSharedSince(
                        date == null ? "Not specified" : date.toString()
                    );

                    records.add(record);
                }
            }

            request.setAttribute("sharedDataRecords", records);
            request.setAttribute("recordCount", records.size());

            request.getRequestDispatcher("/shared-data.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to load shared data from Oracle.", e
            );
        }
    }

    public static class SharedDataRecord {
        private int id;
        private int serviceId;
        private String serviceName;
        private String category;
        private String notes;
        private String sharedSince;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getServiceId() {
            return serviceId;
        }

        public void setServiceId(int serviceId) {
            this.serviceId = serviceId;
        }

        public String getServiceName() {
            return serviceName;
        }

        public void setServiceName(String serviceName) {
            this.serviceName = serviceName;
        }

        public String getCategory() {
            return category;
        }

        public void setCategory(String category) {
            this.category = category;
        }

        public String getNotes() {
            return notes;
        }

        public void setNotes(String notes) {
            this.notes = notes;
        }

        public String getSharedSince() {
            return sharedSince;
        }

        public void setSharedSince(String sharedSince) {
            this.sharedSince = sharedSince;
        }
    }
}
