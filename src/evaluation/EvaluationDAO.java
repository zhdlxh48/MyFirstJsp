package evaluation;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class EvaluationDAO {
    public int write(EvaluationDTO evaluationDTO) {
        // evaluationID is auto-increment, likeCount must be initialized to 0
        String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
        Connection conn = null;
        PreparedStatement pstate = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstate = conn.prepareStatement(SQL);
            pstate.setString(1, evaluationDTO.getUserID());
            pstate.setString(2, evaluationDTO.getLectureName());
            pstate.setString(3, evaluationDTO.getProfessorName());
            pstate.setInt(4, evaluationDTO.getLectureYear());
            pstate.setString(5, evaluationDTO.getSemesterDivide());
            pstate.setString(6, evaluationDTO.getLectureDivide());
            pstate.setString(7, evaluationDTO.getEvaluationTitle());
            pstate.setString(8, evaluationDTO.getEvaluationContent());
            pstate.setString(9, evaluationDTO.getTotalScore());
            pstate.setString(10, evaluationDTO.getCreditScore());
            pstate.setString(11, evaluationDTO.getComfortableScore());
            pstate.setString(12, evaluationDTO.getLectureScore());
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
}
