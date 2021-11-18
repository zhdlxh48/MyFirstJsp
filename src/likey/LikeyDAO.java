package likey;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class LikeyDAO {
    public int like(String userID, String evaluationID, String userIP) {
        String SQL = "INSERT INTO LIKEY VALUES (?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstate = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstate = conn.prepareStatement(SQL);
            pstate.setString(1, userID);
            pstate.setString(2, evaluationID);
            pstate.setString(3, userIP);
            return pstate.executeUpdate(); // If 1, Success
        } catch (Exception e) {
            e.printStackTrace();
        } finally { // Resource Clear
            try {
                if (conn != null) {
                    conn.close();
                }
                if (pstate != null) {
                    pstate.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1; // 추천 중복 오류
    }
}
