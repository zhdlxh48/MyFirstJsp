package evaluation;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EvaluationDAO {
    public int write(EvaluationDTO evaluationDTO) {
        // evaluationID is auto-increment, likeCount must be initialized to 0
        String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
        Connection conn = null;
        PreparedStatement pstate = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstate = conn.prepareStatement(SQL);
            pstate.setString(1, evaluationDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replace("\r\n", "<br/>"));
            pstate.setString(2, evaluationDTO.getLectureName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replace("\r\n", "<br/>"));
            pstate.setString(3, evaluationDTO.getProfessorName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replace("\r\n", "<br/>"));
            pstate.setInt(4, evaluationDTO.getLectureYear());
            pstate.setString(5, evaluationDTO.getSemesterDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replace("\r\n", "<br/>"));
            pstate.setString(6, evaluationDTO.getLectureDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replace("\r\n", "<br/>"));
            pstate.setString(7, evaluationDTO.getEvaluationTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replace("\r\n", "<br/>"));
            pstate.setString(8, evaluationDTO.getEvaluationContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replace("\r\n", "<br/>"));
            pstate.setString(9, evaluationDTO.getTotalScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replace("\r\n", "<br/>"));
            pstate.setString(10, evaluationDTO.getCreditScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replace("\r\n", "<br/>"));
            pstate.setString(11, evaluationDTO.getComfortableScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replace("\r\n", "<br/>"));
            pstate.setString(12, evaluationDTO.getLectureScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replace("\r\n", "<br/>"));
            return pstate.executeUpdate();
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
        return -1; // DB Error
    }

    public ArrayList<EvaluationDTO> getList (String lectureDivide, String searchType, String search, int pageNumber) {
        if (lectureDivide.equals("전체")) {
            lectureDivide = "";
        }

        ArrayList<EvaluationDTO> evaluationList = null;

        String SQL = null;
        Connection conn = null;
        PreparedStatement pstate = null;
        ResultSet rs = null;

        try {
            if (searchType.equals("최신순")) {
                // LIKE: 문자열에 ? 값을 포함하고 있는지
                // SQL %value% 문법 알아보기
                SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
            } else if (searchType.equals("추천순")) {
                // LIKE: 문자열에 ? 값을 포함하고 있는지
                SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
            }

            conn = DatabaseUtil.getConnection();
            pstate = conn.prepareStatement(SQL);
            pstate.setString(1, "%" + lectureDivide + "%");
            pstate.setString(2, "%" + search + "%");

            rs = pstate.executeQuery();
            evaluationList = new ArrayList<EvaluationDTO>();

            while (rs.next()) {
                EvaluationDTO evaluation = new EvaluationDTO(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getInt(14)
                );
                evaluationList.add(evaluation);
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
        return evaluationList;
    }

    public int like(String evaluationID) {
        String SQL = "UPDATE EVALUATION SET likeCount = likeCount + 1 WHERE evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstate = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstate = conn.prepareStatement(SQL);
            pstate.setInt(1, Integer.parseInt(evaluationID));
            return pstate.executeUpdate();
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
        return -1; // Set Error
    }

    public int delete(String evaluationID) {
        String SQL = "DELETE FROM EVALUATION WHERE evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstate = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstate = conn.prepareStatement(SQL);
            pstate.setInt(1, Integer.parseInt(evaluationID));
            return pstate.executeUpdate();
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
        return -1; // Set Error
    }

    public String getUserID(String evaluationID) {
        String SQL = "SELECT userID FROM EVALUATION WHERE evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstate = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstate = conn.prepareStatement(SQL);
            pstate.setInt(1, Integer.parseInt(evaluationID));
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
        return null; // 존재하지 않는 인기글
    }
}
