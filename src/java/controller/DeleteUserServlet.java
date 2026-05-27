package controller;

import dao.UserDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {

            String email = req.getParameter("email");

            UserDAO dao = new UserDAO();

            dao.deleteUser(email);

            resp.sendRedirect(req.getContextPath() + "/viewUsers");

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
