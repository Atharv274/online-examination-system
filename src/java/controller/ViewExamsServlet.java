package controller;

import dao.ExamDAO;
import model.user;
import util.DBConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/viewExams")
public class ViewExamsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            System.out.println("ViewExamsServlet HIT");

            // ==============================
            // SESSION VALIDATION
            // ==============================
            HttpSession session = req.getSession(false);

            if (session == null) {
                System.out.println("Session is NULL");
                resp.sendRedirect("login.jsp");
                return;
            }

            user u = (user) session.getAttribute("user");

            if (u == null) {
                System.out.println("User is NULL");
                resp.sendRedirect("login.jsp");
                return;
            }

            System.out.println("User Email: " + u.getEmail());

            // ==============================
            // FETCH EXAMS
            // ==============================
            List<Map<String, String>> exams = new ArrayList<>();

            try {
                ExamDAO dao = new ExamDAO();
                exams = dao.getAllExams();
                System.out.println("Exams fetched: " + exams.size());
            } catch (Exception e) {
                System.out.println("DAO ERROR");
                e.printStackTrace();
            }

            // ==============================
            // FETCH ATTEMPTED EXAMS
            // ==============================
            Set<Integer> attemptedExams = new HashSet<>();

            try (Connection con = DBConnection.getConnection()) {

                if (con == null) {
                    System.out.println("DB CONNECTION FAILED");
                } else {

                    String sql = "SELECT exam_id FROM results WHERE student_email = ?";
                    PreparedStatement ps = con.prepareStatement(sql);

                    ps.setString(1, u.getEmail());

                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        attemptedExams.add(rs.getInt("exam_id"));
                    }

                    System.out.println("Attempted exams: " + attemptedExams.size());
                }

            } catch (Exception e) {
                System.out.println("SQL ERROR");
                e.printStackTrace();
            }

            // ==============================
            // SEND TO JSP
            // ==============================
            req.setAttribute("exams", exams);
            req.setAttribute("attemptedExams", attemptedExams);

            req.getRequestDispatcher("viewExams.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("student.jsp?error=server");
        }
    }
}