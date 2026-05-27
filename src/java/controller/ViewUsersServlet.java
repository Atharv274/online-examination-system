package controller;

import dao.UserDAO;
import model.user;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewUsers")
public class ViewUsersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            UserDAO dao = new UserDAO();

            List<user> users = dao.getAllUsers();

            req.setAttribute("users", users);

            req.getRequestDispatcher("viewUsers.jsp").forward(req, resp);

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
