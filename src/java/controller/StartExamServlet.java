package controller;

import dao.QuestionDAO;
import model.Question;
import model.user;
import util.DBConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/startExam")
public class StartExamServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {

            HttpSession session = req.getSession();
            user u = (user) session.getAttribute("user");

            // ==============================
            // SESSION CHECK
            // ==============================
            if (u == null) {
                resp.sendRedirect("login.jsp");
                return;
            }

            int examId = Integer.parseInt(req.getParameter("exam_id"));

            Connection con = DBConnection.getConnection();

            // ==============================
            // 🔥 CHECK IF ALREADY ATTEMPTED
            // ==============================
            String checkSql =
                "SELECT * FROM results WHERE student_email = ? AND exam_id = ?";

            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setString(1, u.getEmail());
            checkPs.setInt(2, examId);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // ❌ already attempted
                resp.sendRedirect("viewExams?error=attempted");
                return;
            }

            // ==============================
            // LOAD QUESTIONS
            // ==============================
            QuestionDAO dao = new QuestionDAO();
            List<Question> questions = dao.getQuestionsByExam(examId);

            if (questions == null || questions.isEmpty()) {
                resp.sendRedirect("viewExams?error=noquestions");
                return;
            }

            // ==============================
            // SET SESSION DATA
            // ==============================
            session.setAttribute("questions", questions);
            session.setAttribute("currentIndex", 0);

            // 🔥 IMPORTANT FIX (String key)
            session.setAttribute("answers", new HashMap<String, String>());

            session.setAttribute("examId", examId);

            // ==============================
            // REDIRECT TO EXAM
            // ==============================
            resp.sendRedirect("takeExam.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("viewExams?error=server");
        }
    }
}