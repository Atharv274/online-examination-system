package controller;

import util.DBConnection;
import model.user;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet({"/viewResults", "/viewResult"})
public class ViewResultServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            // ==========================
            // SESSION CHECK
            // ==========================
            HttpSession session =
                    req.getSession(false);

            if(session == null){

                resp.sendRedirect(
                        "login.jsp");
                return;
            }

            user u =
                    (user) session.getAttribute(
                            "user");

            if(u == null){

                resp.sendRedirect(
                        "login.jsp");
                return;
            }

            String role =
                    (String) session.getAttribute(
                            "role");

            String subject =
                    (String) session.getAttribute(
                            "subject");

            // ==========================
            // DB
            // ==========================
            con =
                    DBConnection.getConnection();

            String sql;

            // ==========================
            // ADMIN → ALL RESULTS
            // FACULTY → SUBJECT%
            // ==========================
            if("admin".equalsIgnoreCase(role)){

                sql =
                "SELECT r.student_email, " +
                "r.exam_id, r.score, " +
                "e.course_name, " +
                "(SELECT COUNT(*) " +
                "FROM questions q " +
                "WHERE q.exam_id=r.exam_id) " +
                "AS total_questions " +
                "FROM results r " +
                "JOIN exams e " +
                "ON r.exam_id=e.exam_id " +
                "ORDER BY r.result_id DESC";

                ps =
                        con.prepareStatement(
                                sql);

            } else {

                sql =
                "SELECT r.student_email, " +
                "r.exam_id, r.score, " +
                "e.course_name, " +
                "(SELECT COUNT(*) " +
                "FROM questions q " +
                "WHERE q.exam_id=r.exam_id) " +
                "AS total_questions " +
                "FROM results r " +
                "JOIN exams e " +
                "ON r.exam_id=e.exam_id " +
                "WHERE e.course_name LIKE ? " +
                "ORDER BY r.result_id DESC";

                ps =
                        con.prepareStatement(
                                sql);

                ps.setString(
                        1,
                        subject + "%");
            }

            rs =
                    ps.executeQuery();

            List<Map<String,Object>> results =
                    new ArrayList<>();

            while(rs.next()){

                Map<String,Object> row =
                        new HashMap<>();

                int score =
                        rs.getInt(
                                "score");

                int total =
                        rs.getInt(
                                "total_questions");

                row.put(
                        "student",
                        rs.getString(
                                "student_email"));

                row.put(
                        "subject",
                        rs.getString(
                                "course_name"));

                row.put(
                        "score",
                        score);

                row.put(
                        "total",
                        total);

                results.add(row);
            }

            req.setAttribute(
                    "results",
                    results);

            req.getRequestDispatcher(
                    "/result.jsp")
                    .forward(req, resp);

        } catch(Exception e){

            e.printStackTrace();

            resp.getWriter().println(
                    "Error: " +
                    e.getMessage());

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