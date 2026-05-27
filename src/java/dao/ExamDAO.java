package dao;

import util.DBConnection;
import java.sql.*;
import java.util.*;

public class ExamDAO {

    // ==============================
    // GET ALL EXAMS
    // TOTAL MARKS = QUESTION COUNT
    // ==============================
    public List<Map<String, String>> getAllExams() {

        List<Map<String, String>> list =
                new ArrayList<>();

        String query =
            "SELECT e.exam_id, " +
            "e.course_name, " +
            "e.duration, " +
            "COUNT(q.question_id) AS total_marks " +
            "FROM exams e " +
            "LEFT JOIN questions q " +
            "ON e.exam_id = q.exam_id " +
            "GROUP BY e.exam_id, e.course_name, e.duration";

        try (Connection conn =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     conn.prepareStatement(query);

             ResultSet rs =
                     ps.executeQuery()) {

            while (rs.next()) {

                Map<String, String> map =
                        new HashMap<>();

                map.put(
                        "exam_id",
                        String.valueOf(
                                rs.getInt("exam_id")));

                map.put(
                        "title",
                        rs.getString(
                                "course_name"));

                map.put(
                        "duration",
                        rs.getString(
                                "duration"));

                // AUTO TOTAL MARKS
                map.put(
                        "total_marks",
                        String.valueOf(
                                rs.getInt(
                                        "total_marks")));

                list.add(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ==============================
    // STUDENT PERCENTAGE
    // ==============================
    public Map<String, Double>
    getStudentPercentageWithSubjects(
            String email) {

        Map<String, Double> map =
                new LinkedHashMap<>();

        String sql =
            "SELECT e.course_name, r.score, " +
            "(SELECT COUNT(*) FROM questions q WHERE q.exam_id = r.exam_id) AS total " +
            "FROM results r " +
            "JOIN exams e ON r.exam_id = e.exam_id " +
            "WHERE r.student_email = ? " +
            "ORDER BY r.result_id";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                String subject =
                        rs.getString(
                                "course_name");

                int score =
                        rs.getInt(
                                "score");

                int total =
                        rs.getInt(
                                "total");

                double percentage = 0;

                if (total > 0) {
                    percentage =
                            (score * 100.0)
                            / total;
                }

                map.put(
                        subject,
                        percentage);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    // ==============================
    // STUDENT SCORES
    // ==============================
    public List<Integer>
    getStudentScores(String email) {

        List<Integer> scores =
                new ArrayList<>();

        String query =
            "SELECT score FROM results " +
            "WHERE TRIM(LOWER(student_email)) = TRIM(LOWER(?)) " +
            "ORDER BY result_id";

        try (Connection conn =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     conn.prepareStatement(query)) {

            ps.setString(1, email);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {
                scores.add(
                        rs.getInt("score"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return scores;
    }

    // ==============================
    // GRAPH DATA
    // ==============================
    public Map<String,Integer>
    getStudentScoreWithSubjects(
            String email) {

        Map<String,Integer> map =
                new LinkedHashMap<>();

        String query =
            "SELECT score FROM results " +
            "WHERE TRIM(LOWER(student_email)) = TRIM(LOWER(?)) " +
            "ORDER BY result_id";

        try (Connection conn =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     conn.prepareStatement(query)) {

            ps.setString(1, email);

            ResultSet rs =
                    ps.executeQuery();

            int i = 1;

            while (rs.next()) {

                map.put(
                        "Exam " + i,
                        rs.getInt("score"));

                i++;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    // ==============================
    // PERFORMANCE SUMMARY
    // ==============================
    public Map<String,Object>
    getPerformanceSummary(
            String email) {

        Map<String,Object> summary =
                new HashMap<>();

        String query =
            "SELECT " +
            "COUNT(*) as total, " +
            "AVG((r.score / q.total) * 100) as avgPercentage, " +
            "MAX(r.score) as bestScore " +
            "FROM results r " +
            "JOIN (" +
            "SELECT exam_id, COUNT(*) as total " +
            "FROM questions GROUP BY exam_id" +
            ") q ON r.exam_id = q.exam_id " +
            "WHERE r.student_email = ?";

        try (Connection conn =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     conn.prepareStatement(query)) {

            ps.setString(1, email);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                summary.put(
                        "totalExams",
                        rs.getInt("total"));

                summary.put(
                        "avgScore",
                        rs.getDouble(
                                "avgPercentage"));

                summary.put(
                        "bestScore",
                        rs.getInt(
                                "bestScore"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return summary;
    }
}