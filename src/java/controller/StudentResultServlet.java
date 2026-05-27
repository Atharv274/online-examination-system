package controller;

import util.DBConnection;
import model.user;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/studentResult")
public class StudentResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            HttpSession session = req.getSession(false);
            user u = (user) session.getAttribute("user");

            if (u == null) {
                resp.sendRedirect("login.jsp");
                return;
            }

            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT r.score, e.course_name, " +
                "(SELECT COUNT(*) FROM questions q WHERE q.exam_id = r.exam_id) AS total " +
                "FROM results r " +
                "JOIN exams e ON r.exam_id = e.exam_id " +
                "WHERE r.student_email = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, u.getEmail());

            ResultSet rs = ps.executeQuery();

            List<Map<String, Object>> results = new ArrayList<>();

            while (rs.next()) {

                Map<String, Object> row = new HashMap<>();

                row.put("subject", rs.getString("course_name"));
                row.put("score", rs.getInt("score"));
                row.put("total", rs.getInt("total"));

                results.add(row);
            }

            req.setAttribute("results", results);
            req.getRequestDispatcher("/student_result.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}