package controller;

import util.DBConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/createExam")
public class CreateExamServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
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

            String sessionSubject =
                    (String) session.getAttribute("subject");

            String courseName =
                    req.getParameter("course_name");

            // Faculty Security
            if(!"admin".equalsIgnoreCase(role)){

                if(sessionSubject == null ||
                   !sessionSubject.equalsIgnoreCase(courseName)){

                    resp.getWriter()
                        .println("Access Denied");
                    return;
                }
            }

            Connection con =
                    DBConnection.getConnection();

            // Simple Exam Create
            String sql =
            "INSERT INTO exams(course_name) VALUES(?)";

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

            // Direct Question Page
            resp.sendRedirect(
                    req.getContextPath()
                    + "/addQuestion?exam_id="
                    + examId);

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}