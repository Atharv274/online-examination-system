package controller;

import dao.ExamDAO;
import model.user;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.*;

@WebServlet("/studentDashboard")
public class StudentDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        // ==============================
        // 1. SESSION VALIDATION
        // ==============================
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        user u = (user) session.getAttribute("user");

        try {

            // ==============================
            // 2. DAO CALL
            // ==============================
            ExamDAO dao = new ExamDAO();
            String email = u.getEmail();

            // ✅ FIXED: DIRECTLY GET PERCENTAGE (CORRECT WAY)
            Map<String, Double> percentageMap =
                    dao.getStudentPercentageWithSubjects(email);

            // summary
            Map<String, Object> summary =
                    dao.getPerformanceSummary(email);

            // ==============================
            // 3. NULL SAFETY
            // ==============================
            if (percentageMap == null) {
                percentageMap = new LinkedHashMap<>();
            }

            if (summary == null) {
                summary = new HashMap<>();
            }

            // ==============================
            // 4. SEND DATA TO JSP
            // ==============================
            req.setAttribute("percentageMap", percentageMap);

            req.setAttribute("totalExams",
                    summary.getOrDefault("totalExams", 0));

            req.setAttribute("avgScore",
                    summary.getOrDefault("avgScore", 0.0));

            req.setAttribute("bestScore",
                    summary.getOrDefault("bestScore", 0));

            // ==============================
            // 5. DEBUG
            // ==============================
            System.out.println("EMAIL: " + email);
            System.out.println("percentageMap: " + percentageMap);

            // ==============================
            // 6. FORWARD
            // ==============================
            RequestDispatcher rd =
                    req.getRequestDispatcher("student.jsp");

            rd.forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp");
        }
    }
}