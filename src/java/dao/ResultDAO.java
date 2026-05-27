package dao;

import util.DBConnection;
import java.sql.*;
import java.util.*;

public class ResultDAO {

    // ==============================
    // SAVE RESULT (your existing code)
    // ==============================
    public void saveResult(String email, int examId, int score) throws Exception {

        Connection con = DBConnection.getConnection();

        String checkSql = "SELECT * FROM results WHERE student_email=? AND exam_id=?";
        PreparedStatement checkPs = con.prepareStatement(checkSql);

        checkPs.setString(1, email);
        checkPs.setInt(2, examId);

        ResultSet rs = checkPs.executeQuery();

        if (rs.next()) {

            String updateSql = "UPDATE results SET score=? WHERE student_email=? AND exam_id=?";
            PreparedStatement updatePs = con.prepareStatement(updateSql);

            updatePs.setInt(1, score);
            updatePs.setString(2, email);
            updatePs.setInt(3, examId);

            updatePs.executeUpdate();
            updatePs.close();

        } else {

            String insertSql = "INSERT INTO results(student_email, exam_id, score) VALUES(?,?,?)";
            PreparedStatement insertPs = con.prepareStatement(insertSql);

            insertPs.setString(1, email);
            insertPs.setInt(2, examId);
            insertPs.setInt(3, score);

            insertPs.executeUpdate();
            insertPs.close();
        }

        rs.close();
        checkPs.close();
        con.close();
    }

    // ==============================
    // GET RESULTS FOR FACULTY VIEW
    // ==============================
    public List<Map<String, Object>> getSimpleResults() {

        List<Map<String, Object>> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT r.student_email, e.title AS exam, r.score, e.total_questions " +
                         "FROM results r " +
                         "JOIN exams e ON r.exam_id = e.id";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Map<String, Object> row = new HashMap<>();

                row.put("student", rs.getString("student_email"));
                row.put("exam", rs.getString("exam"));
                row.put("score", rs.getInt("score"));
                row.put("total", rs.getInt("total_questions"));

                list.add(row);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}