
package com.privacycheck.dao;

import com.privacycheck.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Locale;

public class GoogleAuthDAO {

    public GoogleUser findOrCreate(
            String googleSubject,
            String email,
            String fullName) throws SQLException {

        if (googleSubject == null || googleSubject.isBlank()
                || email == null || email.isBlank()) {
            throw new SQLException(
                    "Google account information is incomplete.");
        }

        String normalizedEmail =
                email.trim().toLowerCase(Locale.ROOT);

        try (Connection con = DBConnection.getConnection()) {

            // 1. Find an account already linked to this Google identity.
            String findGoogle =
                    "SELECT USER_ID, FULL_NAME, EMAIL "
                    + "FROM APP_USER WHERE GOOGLE_SUBJECT = ?";

            try (PreparedStatement ps =
                    con.prepareStatement(findGoogle)) {

                ps.setString(1, googleSubject);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return new GoogleUser(
                                rs.getLong("USER_ID"),
                                rs.getString("FULL_NAME"),
                                rs.getString("EMAIL")
                        );
                    }
                }
            }

            // 2. Check for an existing account with this email.
            String findEmail =
                    "SELECT USER_ID FROM APP_USER "
                    + "WHERE LOWER(EMAIL) = ?";

            try (PreparedStatement ps =
                    con.prepareStatement(findEmail)) {

                ps.setString(1, normalizedEmail);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        throw new ExistingAccountException(
                                "An account already exists with this email. "
                                + "Sign in to your existing PrivacyCheck "
                                + "account before linking Google.");
                    }
                }
            }

            // 3. Create a new account for this Google identity.
            String insert =
                    "INSERT INTO APP_USER "
                    + "(FULL_NAME, EMAIL, GOOGLE_SUBJECT) "
                    + "VALUES (?, ?, ?)";

            try (PreparedStatement ps =
                    con.prepareStatement(insert)) {

                String safeName =
                        (fullName == null || fullName.isBlank())
                                ? normalizedEmail
                                : fullName.trim();

                ps.setString(1, safeName);
                ps.setString(2, normalizedEmail);
                ps.setString(3, googleSubject);

                if (ps.executeUpdate() != 1) {
                    throw new SQLException(
                            "Could not create the Google account.");
                }
            } catch (SQLException ex) {
                // Handle concurrent sign-ups or a unique constraint
                // violation without exposing database details.
                if (ex.getErrorCode() == 1) {
                    throw new ExistingAccountException(
                            "An account with this email or Google identity "
                            + "already exists. Please sign in again.");
                }
                throw ex;
            }

            // 4. Retrieve the newly created account.
            try (PreparedStatement ps =
                    con.prepareStatement(findGoogle)) {

                ps.setString(1, googleSubject);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return new GoogleUser(
                                rs.getLong("USER_ID"),
                                rs.getString("FULL_NAME"),
                                rs.getString("EMAIL")
                        );
                    }
                }
            }

            throw new SQLException(
                    "The Google account was created but could not be retrieved.");
        }
    }

    /**
     * Indicates that Google sign-in matched an existing account.
     */
    public static class ExistingAccountException
            extends SQLException {

        public ExistingAccountException(String message) {
            super(message);
        }
    }

    /**
     * Represents a PrivacyCheck user authenticated through Google.
     */
    public static class GoogleUser {

        private final long id;
        private final String name;
        private final String email;

        public GoogleUser(long id, String name, String email) {
            this.id = id;
            this.name = name;
            this.email = email;
        }

        public long getId() {
            return id;
        }

        public String getName() {
            return name;
        }

        public String getEmail() {
            return email;
        }
    }
}
