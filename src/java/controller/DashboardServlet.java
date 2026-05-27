package controller;

import util.DBConnection;
import model.user;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {

            // ==========================
            // SESSION CHECK
            // ==========================
            HttpSession session =
                    req.getSession(false);

            if(session == null){

                resp.sendRedirect("login.jsp");
                return;
            }

            user u =
                    (user) session.getAttribute("user");

            if(u == null){

                resp.sendRedirect("login.jsp");
                return;
            }

            String role =
                    u.getRole();

            String subject =
                    (String) session.getAttribute(
                            "subject");

            con =
                    DBConnection.getConnection();

            st =
                    con.createStatement();

            // ==========================
            // STUDENTS
            // ==========================
            rs = st.executeQuery(
                    "SELECT COUNT(*) " +
                    "FROM users " +
                    "WHERE role='student'");

            rs.next();

            req.setAttribute(
                    "students",
                    rs.getInt(1));

            // ==========================
            // EXAMS
            // ==========================
            if("admin".equalsIgnoreCase(role)){

                rs = st.executeQuery(
                        "SELECT COUNT(*) FROM exams");

            }else{

                rs = st.executeQuery(
                    "SELECT COUNT(*) " +
                    "FROM exams " +
                    "WHERE course_name LIKE '"
                    + subject + "%'");
            }

            rs.next();

            req.setAttribute(
                    "exams",
                    rs.getInt(1));

            // ==========================
            // QUESTIONS
            // ==========================
            if("admin".equalsIgnoreCase(role)){

                rs = st.executeQuery(
                        "SELECT COUNT(*) FROM questions");

            }else{

                rs = st.executeQuery(
                    "SELECT COUNT(*) " +
                    "FROM questions q " +
                    "JOIN exams e " +
                    "ON q.exam_id=e.exam_id " +
                    "WHERE e.course_name LIKE '"
                    + subject + "%'");
            }

            rs.next();

            req.setAttribute(
                    "questions",
                    rs.getInt(1));

            // ==========================
            // SUBMISSIONS
            // ==========================
            if("admin".equalsIgnoreCase(role)){

                rs = st.executeQuery(
                        "SELECT COUNT(*) FROM results");

            }else{

                rs = st.executeQuery(
                    "SELECT COUNT(*) " +
                    "FROM results r " +
                    "JOIN exams e " +
                    "ON r.exam_id=e.exam_id " +
                    "WHERE e.course_name LIKE '"
                    + subject + "%'");
            }

            rs.next();

            req.setAttribute(
                    "submissions",
                    rs.getInt(1));

            // ==========================
            // GRAPH DATA
            // ==========================
            String sql;

            if("admin".equalsIgnoreCase(role)){

                sql =
                "SELECT e.course_name, " +
                "COUNT(r.exam_id) total " +
                "FROM exams e " +
                "LEFT JOIN results r " +
                "ON e.exam_id=r.exam_id " +
                "GROUP BY e.exam_id " +
                "ORDER BY e.exam_id DESC";

            }else{

                sql =
                "SELECT e.course_name, " +
                "COUNT(r.exam_id) total " +
                "FROM exams e " +
                "LEFT JOIN results r " +
                "ON e.exam_id=r.exam_id " +
                "WHERE e.course_name LIKE '"
                + subject + "%' " +
                "GROUP BY e.exam_id " +
                "ORDER BY e.exam_id DESC";
            }

            rs =
                    st.executeQuery(sql);

            List<String> labels =
                    new ArrayList<>();

            List<Integer> values =
                    new ArrayList<>();

            while(rs.next()){

                labels.add(
                        rs.getString(
                                "course_name"));

                values.add(
                        rs.getInt(
                                "total"));
            }

            req.setAttribute(
                    "labels",
                    labels);

            req.setAttribute(
                    "chartData",
                    values);

            // ==========================
            // FORWARD
            // ==========================
            req.getRequestDispatcher(
                    "admin.jsp")
                    .forward(req, resp);

        } catch(Exception e){

            e.printStackTrace();

            resp.sendRedirect(
                    "login.jsp");

        } finally {

            try{
                if(rs!=null) rs.close();
            }catch(Exception ignored){}

            try{
                if(st!=null) st.close();
            }catch(Exception ignored){}

            try{
                if(con!=null) con.close();
            }catch(Exception ignored){}
        }
    }
}