package user;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstate = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstate = conn.prepareStatement(SQL);
            pstate.setString(1, userID);
            rs = pstate.executeQuery();
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    return 1; // Login Success
                } else {
                    return 0; // Login Failed
                }
            }
            return -1; // ID is not available in DB
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
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -2; // DB Error
    }

    public int join(UserDTO user) {
        String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, false)";
        Connection conn = null;
        PreparedStatement pstate = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstate = conn.prepareStatement(SQL);
            pstate.setString(1, user.getUserID());
            pstate.setString(2, user.getUserPassword());
            pstate.setString(3, user.getUserEmail());
            pstate.setString(4, user.getUserEmailHash());
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
        return -1; // Join Error
    }

    public String getUserEmail(String userID) {
        String SQL = "SELECT userEmail FROM USER WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstate = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstate = conn.prepareStatement(SQL);
            pstate.setString(1, userID);
            rs = pstate.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
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
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null; // Search Error
    }

    public boolean getUserEmailChecked(String userID) {
        String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstate = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstate = conn.prepareStatement(SQL);
            pstate.setString(1, userID);
            rs = pstate.executeQuery();
            if (rs.next()) {
                return rs.getBoolean(1);
            }
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
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false; // Search Error
    }

    public boolean setUserEmailChecked(String userID) {
        String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstate = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstate = conn.prepareStatement(SQL);
            pstate.setString(1, userID);
            pstate.executeUpdate();
            return true;
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
        return false; // Set Error
    }
}
