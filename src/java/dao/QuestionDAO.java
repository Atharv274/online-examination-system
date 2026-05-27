package dao;

import model.Question;
import util.DBConnection;

import java.sql.*;
import java.util.*;

public class QuestionDAO {

    // ==========================
    // GET QUESTIONS BY EXAM
    // ==========================
    public List<Question> getQuestionsByExam(int examId) {

        List<Question> list =
                new ArrayList<>();

        String sql =
        "SELECT * FROM questions " +
        "WHERE exam_id=? " +
        "ORDER BY question_id";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, examId);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Question q =
                        new Question();

                q.setQuestionId(
                        rs.getInt(
                                "question_id"));

                q.setExamId(
                        rs.getInt(
                                "exam_id"));

                q.setQuestionText(
                        rs.getString(
                                "question_text"));

                q.setOptionA(
                        rs.getString(
                                "optionA"));

                q.setOptionB(
                        rs.getString(
                                "optionB"));

                q.setOptionC(
                        rs.getString(
                                "optionC"));

                q.setOptionD(
                        rs.getString(
                                "optionD"));

                q.setCorrectAnswer(
                        rs.getString(
                                "correct_answer"));

                // MARKS REMOVED
                // every question = 1 mark

                list.add(q);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ==========================
    // CORRECT ANSWERS
    // ==========================
    public Map<Integer, String>
    getCorrectAnswers(int examId) {

        Map<Integer, String> map =
                new HashMap<>();

        String sql =
        "SELECT question_id, correct_answer " +
        "FROM questions " +
        "WHERE exam_id=?";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, examId);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                map.put(
                        rs.getInt(
                                "question_id"),

                        rs.getString(
                                "correct_answer"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }
}