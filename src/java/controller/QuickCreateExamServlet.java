package controller;

import util.DBConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/quickCreateExam")
public class QuickCreateExamServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws IOException {

        try {

            HttpSession session =
                    req.getSession(false);

            if(session == null){
                resp.sendRedirect("login.jsp");
                return;
            }

            String role =
                    (String) session.getAttribute("role");

            String subject =
                    (String) session.getAttribute("subject");

            String examTitle =
                    req.getParameter("title");

            Connection con =
                    DBConnection.getConnection();

            String courseName;

            // ===================
            // ADMIN
            // ===================
            if("admin".equalsIgnoreCase(role)){

                courseName =
                        req.getParameter("course_name");

                if(courseName == null
                   || courseName.trim().isEmpty()){

                    resp.getWriter()
                        .println("Subject required");
                    return;
                }

            } else {

                // ===================
                // FACULTY
                // ===================
                if(subject == null ||
                   subject.trim().isEmpty()){

                    resp.getWriter()
                        .println("Subject not assigned");
                    return;
                }

                if(examTitle == null ||
                   examTitle.trim().isEmpty()){

                    resp.getWriter()
                        .println("Exam title required");
                    return;
                }

                courseName =
                        subject +
                        " - " +
                        examTitle;
            }

            // default 5 mins
            String sql =
            "INSERT INTO exams(course_name,duration) VALUES(?,5)";

            PreparedStatement ps =
                    con.prepareStatement(
                            sql,
                            Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, courseName);

            ps.executeUpdate();

            ResultSet rs =
                    ps.getGeneratedKeys();

            int examId = 0;

            if(rs.next()){
                examId = rs.getInt(1);
            }

            rs.close();
            ps.close();
            con.close();

            resp.sendRedirect(
                    req.getContextPath()
                    + "/addQuestion?exam_id="
                    + examId);

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}