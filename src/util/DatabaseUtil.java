package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
    public static Connection getConnection() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/TUTORIAL";
            String dbID = "root", dbPassword = "RealTjshd*499";
            // TODO: Class.forName의 사용법 알아보기
            // TODO: This class is deprecated. Use 'com.mysql.cj.jdbc.Driver' class.
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
