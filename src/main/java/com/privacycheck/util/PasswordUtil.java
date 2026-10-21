
package com.privacycheck.util;

import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public final class PasswordUtil {

    private static final int ITERATIONS = 600_000;
    private static final int KEY_LENGTH = 256;
    private static final int SALT_LENGTH = 16;
    private static final SecureRandom RANDOM = new SecureRandom();

    private PasswordUtil() {}

    public static String hash(String password) {
        byte[] salt = new byte[SALT_LENGTH];
        RANDOM.nextBytes(salt);

        byte[] derived = derive(password.toCharArray(), salt);

        return ITERATIONS + ":"
                + Base64.getEncoder().encodeToString(salt) + ":"
                + Base64.getEncoder().encodeToString(derived);
    }

    public static boolean verify(String password, String storedHash) {
        if (password == null || storedHash == null) {
            return false;
        }

        try {
            String[] parts = storedHash.split(":");
            int iterations = Integer.parseInt(parts[0]);
            byte[] salt = Base64.getDecoder().decode(parts[1]);
            byte[] expected = Base64.getDecoder().decode(parts[2]);

            PBEKeySpec spec = new PBEKeySpec(
                    password.toCharArray(), salt, iterations,
                    expected.length * 8);

            byte[] actual;
            try {
                actual = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")
                        .generateSecret(spec).getEncoded();
            } finally {
                spec.clearPassword();
            }

            return MessageDigest.isEqual(expected, actual);
        } catch (RuntimeException | GeneralSecurityException e) {
            return false;
        }
    }

    private static byte[] derive(char[] password, byte[] salt) {
        PBEKeySpec spec = new PBEKeySpec(
                password, salt, ITERATIONS, KEY_LENGTH);

        try {
            return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")
                    .generateSecret(spec).getEncoded();
        } catch (GeneralSecurityException e) {
            throw new IllegalStateException("Password hashing unavailable", e);
        } finally {
            spec.clearPassword();
        }
    }
}
