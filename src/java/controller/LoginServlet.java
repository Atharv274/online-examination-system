package controller;

import dao.UserDAO;
import model.user;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            String email = req.getParameter("email");
            String password = req.getParameter("password");

            // Validation
            if (email == null || password == null ||
                    email.trim().isEmpty() || password.trim().isEmpty()) {

                resp.sendRedirect("login.jsp?error=empty");
                return;
            }

            // Login Check
            UserDAO dao = new UserDAO();
            user u = dao.login(email, password);

            if (u != null) {

                // New Session
                HttpSession session = req.getSession();
                session.invalidate();

                session = req.getSession(true);

                // Store User Object
                session.setAttribute("user", u);

                // Basic Info
                session.setAttribute("role", u.getRole());
                session.setAttribute("username", u.getName());
                session.setAttribute("email", u.getEmail());

                // NEW: Subject Name
                session.setAttribute("subject", u.getSubjectName());

                session.setMaxInactiveInterval(30 * 60);

                String role = u.getRole();

                // Admin + Teacher + Faculty
                if ("admin".equalsIgnoreCase(role)
                        || "teacher".equalsIgnoreCase(role)
                        || "faculty".equalsIgnoreCase(role)) {

                    resp.sendRedirect("dashboard");

                } else {

                    // Student
                    resp.sendRedirect("studentDashboard");
                }

            } else {

                resp.sendRedirect("login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp?error=server");
        }
    }
}