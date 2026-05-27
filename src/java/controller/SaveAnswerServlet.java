package controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.*;

@WebServlet("/saveAnswer")
public class SaveAnswerServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Map<String, String> answers =
                (Map<String, String>) session.getAttribute("answers");

        if (answers == null) {
            answers = new HashMap<>();
        }

        String qid = req.getParameter("qid");
        String answer = req.getParameter("answer");

        // SAVE ANSWER
        if (qid != null && answer != null) {
            answers.put("q" + qid, answer);
        }

        session.setAttribute("answers", answers);

        // SAFE CURRENT
        int current = 1;
        try {
            current = Integer.parseInt(req.getParameter("current"));
        } catch (Exception e) {
            current = 1;
        }

        String action = req.getParameter("action");

        if ("next".equals(action)) {

            resp.sendRedirect("takeExam.jsp?q=" + (current + 1));

        } else if ("prev".equals(action)) {

            resp.sendRedirect("takeExam.jsp?q=" + (current - 1));

        } else if ("submit".equals(action)) {

            // CRITICAL: forward to submitExam
            RequestDispatcher rd =
                    req.getRequestDispatcher("submitExam");

            rd.forward(req, resp);

        } else {

            resp.sendRedirect("takeExam.jsp?q=" + current);
        }
    }
}