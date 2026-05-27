package controller;

import util.DBConnection;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet; 
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/test")
public class TestServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("text/html");

        try {
            Connection con = DBConnection.getConnection();

            if (con != null)
                resp.getWriter().println("Database Connected Successfully ✅");
            else
                resp.getWriter().println("Connection Failed ❌");

        } catch (Exception e) {
            resp.getWriter().println("Error: " + e.getMessage());
        }
    }
}
