
package com.privacycheck.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {

    private static final String URL =
            "jdbc:oracle:thin:@//localhost:1521/XEPDB1";

    private static final String USER = "PRIVACYCHECK";

    private static final String PASSWORD = "PcTest2026_Xe";

    private DBConnection() {
        // Prevent object creation.
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("oracle.jdbc.OracleDriver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "Oracle JDBC driver is not available. "
                    + "Check the Maven ojdbc11 dependency and redeploy.",
                    e
            );
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
