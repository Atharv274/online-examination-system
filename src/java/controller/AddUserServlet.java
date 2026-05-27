package controller;

import dao.UserDAO;
import model.user;

import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/addUser")
public class AddUserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {

            user u = new user();

            u.setName(req.getParameter("name"));
            u.setEmail(req.getParameter("email"));
            u.setPassword(req.getParameter("password"));

            String role = req.getParameter("role");
            String subjectName =
                    req.getParameter("subject_name");

            u.setRole(role);

            // Faculty gets subject
            if ("faculty".equalsIgnoreCase(role)
                    || "teacher".equalsIgnoreCase(role)) {

                u.setSubjectName(subjectName);

            } else {

                u.setSubjectName(null);
            }

            // Debug
            System.out.println(
                    "ROLE = " + role);
            System.out.println(
                    "SUBJECT = " + subjectName);

            UserDAO dao = new UserDAO();

            if (dao.addUser(u))
                resp.sendRedirect("admin.jsp");
            else
                resp.sendRedirect("addUser.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}