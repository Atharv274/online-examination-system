package controller;

import util.DBConnection;
import model.user;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/submitExam")
public class SubmitExamServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        int score = 0;

        try (Connection con =
                     DBConnection.getConnection()) {

            HttpSession session =
                    req.getSession();

            Integer examIdObj =
                    (Integer) session.getAttribute(
                            "examId");

            if(examIdObj == null){

                resp.sendRedirect(
                        "studentDashboard");
                return;
            }

            int examId =
                    examIdObj;

            // ==========================
            // ANSWERS
            // ==========================
            Map<String,String> answers =
                    (Map<String,String>)
                            session.getAttribute(
                                    "answers");

            if(answers == null){
                answers =
                        new HashMap<>();
            }

            Enumeration<String> params =
                    req.getParameterNames();

            while(params.hasMoreElements()){

                String param =
                        params.nextElement();

                if(param.startsWith("q")){

                    String value =
                            req.getParameter(param);

                    if(value != null
                       && !value.trim().isEmpty()){

                        answers.put(
                                param,
                                value.toLowerCase());
                    }
                }
            }

            session.setAttribute(
                    "answers",
                    answers);

            // ==========================
            // SCORE
            // ==========================
            Map<String,String> correctAnswers =
                    new HashMap<>();

            String sql =
            "SELECT question_id, correct_answer " +
            "FROM questions " +
            "WHERE exam_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, examId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                int qid =
                        rs.getInt(
                                "question_id");

                String correct =
                        rs.getString(
                                "correct_answer");

                correctAnswers.put(
                        "q" + qid,
                        correct);

                String selected =
                        answers.get(
                                "q" + qid);

                if(selected != null
                   && correct != null
                   && selected.trim()
                   .equalsIgnoreCase(
                           correct.trim())){

                    score++;
                }
            }

            session.setAttribute(
                    "correctAnswers",
                    correctAnswers);

            // ==========================
            // USER
            // ==========================
            user u =
                    (user) session.getAttribute(
                            "user");

            if(u == null){

                resp.sendRedirect(
                        "login.jsp");
                return;
            }

            // ==========================
            // SAVE RESULT
            // ==========================
            PreparedStatement delete =
                    con.prepareStatement(
                    "DELETE FROM results " +
                    "WHERE student_email=? " +
                    "AND exam_id=?");

            delete.setString(
                    1,
                    u.getEmail());

            delete.setInt(
                    2,
                    examId);

            delete.executeUpdate();
            delete.close();

            PreparedStatement insert =
                    con.prepareStatement(
                    "INSERT INTO results" +
                    "(student_email,exam_id,score) " +
                    "VALUES(?,?,?)");

            insert.setString(
                    1,
                    u.getEmail());

            insert.setInt(
                    2,
                    examId);

            insert.setInt(
                    3,
                    score);

            insert.executeUpdate();
            insert.close();

            // ==========================
            // SAVE USER ANSWERS
            // ==========================
            PreparedStatement deleteAns =
                    con.prepareStatement(
                    "DELETE FROM user_answers " +
                    "WHERE student_email=? " +
                    "AND exam_id=?");

            deleteAns.setString(
                    1,
                    u.getEmail());

            deleteAns.setInt(
                    2,
                    examId);

            deleteAns.executeUpdate();
            deleteAns.close();

            PreparedStatement insertAns =
                    con.prepareStatement(
                    "INSERT INTO user_answers" +
                    "(student_email,exam_id," +
                    "question_id,selected_answer) " +
                    "VALUES(?,?,?,?)");

            for(Map.Entry<String,String>
                    entry : answers.entrySet()){

                String key =
                        entry.getKey();

                String value =
                        entry.getValue();

                int qid =
                        Integer.parseInt(
                        key.substring(1));

                insertAns.setString(
                        1,
                        u.getEmail());

                insertAns.setInt(
                        2,
                        examId);

                insertAns.setInt(
                        3,
                        qid);

                insertAns.setString(
                        4,
                        value);

                insertAns.addBatch();
            }

            insertAns.executeBatch();
            insertAns.close();

            // ==========================
            // CLEAR EXAM SESSION
            // ==========================
            session.removeAttribute(
                    "questions");

            session.removeAttribute(
                    "answers");

            session.removeAttribute(
                    "currentIndex");

            session.removeAttribute(
                    "examId");

            // ==========================
            // FINAL REDIRECT
            // ==========================
            resp.sendRedirect(
                    "studentDashboard");

        } catch(Exception e){

            e.printStackTrace();

            resp.sendRedirect(
                    "studentDashboard?error=submit");
        }
    }
}