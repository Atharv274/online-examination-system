package controller;

import util.DBConnection;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/manageExams")
public class ManageExamsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

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

            con =
                    DBConnection.getConnection();

            // ==========================
            // ADMIN → ALL EXAMS
            // FACULTY → SUBJECT%
            // ==========================

            if("admin".equalsIgnoreCase(role)){

                ps =
                con.prepareStatement(
                "SELECT * FROM exams ORDER BY exam_id DESC");

            }else{

                ps =
                con.prepareStatement(
                "SELECT * FROM exams " +
                "WHERE course_name LIKE ? " +
                "ORDER BY exam_id DESC");

                ps.setString(
                        1,
                        subject + "%");
            }

            rs =
                    ps.executeQuery();

            List<Map<String,String>> exams =
                    new ArrayList<>();

            while(rs.next()){

                Map<String,String> e =
                        new HashMap<>();

                e.put(
                        "id",
                        rs.getString(
                                "exam_id"));

                e.put(
                        "title",
                        rs.getString(
                                "course_name"));

                e.put(
                        "duration",
                        rs.getString(
                                "duration"));

                // ==================
                // QUESTION COUNT
                // ==================

                PreparedStatement ps2 =
                        con.prepareStatement(
                        "SELECT COUNT(*) " +
                        "FROM questions " +
                        "WHERE exam_id=?");

                ps2.setInt(
                        1,
                        rs.getInt(
                                "exam_id"));

                ResultSet r2 =
                        ps2.executeQuery();

                r2.next();

                e.put(
                        "count",
                        r2.getString(1));

                exams.add(e);

                r2.close();
                ps2.close();
            }

            req.setAttribute(
                    "exams",
                    exams);

            req.getRequestDispatcher(
                    "manageExams.jsp")
                    .forward(req, resp);

        } catch(Exception e){

            e.printStackTrace();

        } finally {

            try{
                if(rs!=null) rs.close();
            }catch(Exception ignored){}

            try{
                if(ps!=null) ps.close();
            }catch(Exception ignored){}

            try{
                if(con!=null) con.close();
            }catch(Exception ignored){}
        }
    }
}