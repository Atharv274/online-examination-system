package controller;

import model.user;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if(session == null){
            resp.sendRedirect("login.jsp");
            return;
        }

        user u = (user) session.getAttribute("user");

        if(u == null || !u.getRole().equals("admin")){
            resp.sendRedirect("login.jsp");
            return;
        }

        // forward to dashboard data servlet
        resp.sendRedirect("dashboard");
    }
}