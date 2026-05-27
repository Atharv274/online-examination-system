package controller;

import util.DBConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/addQuestion")
public class AddQuestionServlet extends HttpServlet {

    // Open Add Question Page
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        String examId =
                req.getParameter("exam_id");

        if (examId == null) {

            resp.sendRedirect("manageExams");
            return;
        }

        req.setAttribute(
                "exam_id",
                examId);

        req.getRequestDispatcher(
                "addQuestion.jsp")
                .forward(req, resp);
    }

    // Save Question
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws IOException {

        try {

            int examId =
                    Integer.parseInt(
                            req.getParameter("exam_id"));

            String question =
                    req.getParameter(
                            "question_text");

            String optionA =
                    req.getParameter(
                            "optionA");

            String optionB =
                    req.getParameter(
                            "optionB");

            String optionC =
                    req.getParameter(
                            "optionC");

            String optionD =
                    req.getParameter(
                            "optionD");

            String correct =
                    req.getParameter(
                            "correct_answer");

            Connection con =
                    DBConnection.getConnection();

            // MARKS REMOVED
            String sql =
            "INSERT INTO questions(exam_id,question_text,optionA,optionB,optionC,optionD,correct_answer) VALUES(?,?,?,?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, examId);
            ps.setString(2, question);
            ps.setString(3, optionA);
            ps.setString(4, optionB);
            ps.setString(5, optionC);
            ps.setString(6, optionD);
            ps.setString(7, correct);

            ps.executeUpdate();

            ps.close();
            con.close();

            String action =
                    req.getParameter("action");

            if ("finish".equals(action)) {

                resp.sendRedirect(
                        "manageExams");

            } else {

                resp.sendRedirect(
                        "addQuestion?exam_id="
                        + examId);
            }

        } catch (Exception e) {

            e.printStackTrace();

            resp.getWriter().println(
                    "ERROR: "
                    + e.getMessage());
        }
    }
}