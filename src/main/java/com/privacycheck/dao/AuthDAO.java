
package com.privacycheck.dao;

import com.privacycheck.util.DBConnection;
import com.privacycheck.util.PasswordUtil;
import java.sql.*;

public class AuthDAO {

    public boolean register(String name, String email, String password)
            throws SQLException {

        String sql = """
            INSERT INTO APP_USER (FULL_NAME, EMAIL, PASSWORD_HASH)
            VALUES (?, ?, ?)
            """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name.trim());
            ps.setString(2, email.trim().toLowerCase());
            ps.setString(3, PasswordUtil.hash(password));
            return ps.executeUpdate() == 1;
        }
    }

    public User authenticate(String email, String password)
            throws SQLException {

        String sql = """
            SELECT USER_ID, FULL_NAME, EMAIL, PASSWORD_HASH
            FROM APP_USER
            WHERE LOWER(EMAIL) = LOWER(?)
            """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                String hash = rs.getString("PASSWORD_HASH");
                if (!PasswordUtil.verify(password, hash)) return null;

                return new User(
                    rs.getLong("USER_ID"),
                    rs.getString("FULL_NAME"),
                    rs.getString("EMAIL")
                );
            }
        }
    }

    public static class User {
        private final long id;
        private final String name;
        private final String email;

        public User(long id, String name, String email) {
            this.id = id;
            this.name = name;
            this.email = email;
        }

        public long getId() { return id; }
        public String getName() { return name; }
        public String getEmail() { return email; }
    }
}
