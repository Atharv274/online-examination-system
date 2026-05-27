package controller;

import dao.UserDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {

            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            UserDAO dao = new UserDAO();

            boolean inserted =
                    dao.registerUser(
                            name,
                            email,
                            password,
                            "student",
                            null
                    );

            if (inserted) {
                resp.sendRedirect("login.jsp");
            } else {
                resp.getWriter().println("Registration Failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Server Error");
        }
    }
}