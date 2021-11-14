package user;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserDAO {
    public int join(String userID, String userPassword) {
        String SQL = "INSERT INTO USER VALUES (?, ?)";
        try {
            Connection conn = DatabaseUtil.getConnection();
            // TODO: PreparedStatement에 대해 알아보기
            PreparedStatement pState = conn.prepareStatement(SQL);
            pState.setString(1, userID);
            pState.setString(2, userPassword);
            return pState.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
