package util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

public class SHA256 {
    public static String getSHA256(String input) {
        StringBuffer result = new StringBuffer();

        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] salt = "Hello! This is Salt.".getBytes();
            digest.reset();
            digest.update(salt);
            System.out.println("Convert to UTF-8 Bytes: " + input + " -> " + input.getBytes());
            byte[] chars = digest.digest(input.getBytes(StandardCharsets.UTF_8));
            // TODO: 이 부분의 수학적인 부분 이해하기
            for (int i = 0; i < chars.length; i++) {
                String hex = Integer.toHexString(0xff & chars[i]);
                if (hex.length() == 1) {
                    result.append("0");
                }
                result.append(hex);
            }
            System.out.println("SHA256 Result: " + result.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result.toString();
    }
}
