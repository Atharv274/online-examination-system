package controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        // destroy session
        HttpSession session = req.getSession(false);

        if(session != null){
            session.invalidate();
        }

        // go to login page
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}
