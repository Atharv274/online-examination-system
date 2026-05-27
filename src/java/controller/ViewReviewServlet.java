package controller;

import util.DBConnection;
import model.user;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/viewReview")
public class ViewReviewServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            // ==============================
            // SESSION CHECK
            // ==============================
            HttpSession session = req.getSession(false);
            user u = (user) session.getAttribute("user");

            if (u == null) {
                resp.sendRedirect("login.jsp");
                return;
            }

            // ==============================
            // GET EXAM ID
            // ==============================
            String examIdStr = req.getParameter("examId");

            if (examIdStr == null || examIdStr.isEmpty()) {
                resp.getWriter().println("Error: Exam ID missing");
                return;
            }

            int examId = Integer.parseInt(examIdStr);

            // ==============================
            // DB CONNECTION
            // ==============================
            con = DBConnection.getConnection();

            // ==============================
            // QUERY
            // ==============================
            String sql =
                "SELECT q.question_text, q.optionA, q.optionB, q.optionC, q.optionD, " +
                "q.correct_answer, q.marks, ua.selected_answer " +
                "FROM questions q " +
                "LEFT JOIN user_answers ua ON q.question_id = ua.question_id " +
                "AND TRIM(LOWER(ua.student_email)) = TRIM(LOWER(?)) " +
                "WHERE q.exam_id = ?";

            ps = con.prepareStatement(sql);
            ps.setString(1, u.getEmail());
            ps.setInt(2, examId);

            rs = ps.executeQuery();

            // ==============================
            // STORE DATA
            // ==============================
            List<Map<String, Object>> questions = new ArrayList<>();

            int score = 0;
            int total = 0;

            while (rs.next()) {

                Map<String, Object> row = new HashMap<>();

                String correctKey = rs.getString("correct_answer");   // a/b/c/d
                String selectedKey = rs.getString("selected_answer"); // a/b/c/d
                int marks = rs.getInt("marks");

                // ==============================
                // CONVERT KEYS → TEXT
                // ==============================
                String correct = null;
                String selected = null;

                if (correctKey != null) {
                    switch (correctKey.toLowerCase()) {
                        case "a": correct = rs.getString("optionA"); break;
                        case "b": correct = rs.getString("optionB"); break;
                        case "c": correct = rs.getString("optionC"); break;
                        case "d": correct = rs.getString("optionD"); break;
                    }
                }

                if (selectedKey != null) {
                    switch (selectedKey.toLowerCase()) {
                        case "a": selected = rs.getString("optionA"); break;
                        case "b": selected = rs.getString("optionB"); break;
                        case "c": selected = rs.getString("optionC"); break;
                        case "d": selected = rs.getString("optionD"); break;
                    }
                }

                // ==============================
                // STORE VALUES
                // ==============================
                row.put("question", rs.getString("question_text"));

                row.put("option1", rs.getString("optionA"));
                row.put("option2", rs.getString("optionB"));
                row.put("option3", rs.getString("optionC"));
                row.put("option4", rs.getString("optionD"));

                row.put("correct", correct);
                row.put("selected", selected);
                row.put("marks", marks);

                // ==============================
                // SCORE CALCULATION (USE KEYS)
                // ==============================
                total += marks;

                if (selectedKey != null && selectedKey.equalsIgnoreCase(correctKey)) {
                    score += marks;
                }

                questions.add(row);
            }

            // ==============================
            // SEND TO JSP
            // ==============================
            req.setAttribute("questions", questions);
            req.setAttribute("score", score);
            req.setAttribute("total", total);

            req.getRequestDispatcher("/review.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error: " + e.getMessage());
        } finally {

            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}