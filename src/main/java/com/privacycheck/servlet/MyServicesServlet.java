
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/services")
public class MyServicesServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<ServiceRecord> services = new ArrayList<>();

        String sql = """
            SELECT service_id, service_name, category,
                   risk_level, next_review_date, shared_data_count
            FROM VW_SERVICE_INVENTORY
            WHERE email = ?
            ORDER BY service_name
            """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Demo account used by the sample database.
            ps.setString(1, "shivansh@example.com");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ServiceRecord service = new ServiceRecord();

                    service.id = rs.getInt("service_id");
                    service.name = rs.getString("service_name");
                    service.category = rs.getString("category");
                    service.risk = rs.getString("risk_level");
                    service.sharedDataCount =
                            rs.getInt("shared_data_count");

                    java.sql.Date date =
                            rs.getDate("next_review_date");

                    service.nextReviewDate =
                            date == null ? "Not scheduled" : date.toString();

                    services.add(service);
                }
            }

            request.setAttribute("services", services);
            request.setAttribute("serviceCount", services.size());

            request.getRequestDispatcher("/services.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to load online services from Oracle.", e);
        }
    }

    
public static class ServiceRecord {
    private int id;
    private String name;
    private String category;
    private String risk;
    private String nextReviewDate;
    private int sharedDataCount;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getRisk() {
        return risk;
    }

    public void setRisk(String risk) {
        this.risk = risk;
    }

    public String getNextReviewDate() {
        return nextReviewDate;
    }

    public void setNextReviewDate(String nextReviewDate) {
        this.nextReviewDate = nextReviewDate;
    }

    public int getSharedDataCount() {
        return sharedDataCount;
    }

    public void setSharedDataCount(int sharedDataCount) {
        this.sharedDataCount = sharedDataCount;
    }
}

}
