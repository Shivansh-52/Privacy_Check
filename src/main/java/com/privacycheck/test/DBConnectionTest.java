package com.privacycheck.test;

import com.privacycheck.util.DBConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBConnectionTest {

    public static void main(String[] args) {

        String sql = "SELECT USER, "
                + "SYS_CONTEXT('USERENV', 'CON_NAME') "
                + "FROM DUAL";

        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                System.out.println("Database connection successful!");
                System.out.println("User: " + rs.getString(1));
                System.out.println("Container: " + rs.getString(2));
            }

        } catch (Exception e) {
            System.err.println("Database connection failed.");
            e.printStackTrace();
        }
    }
}