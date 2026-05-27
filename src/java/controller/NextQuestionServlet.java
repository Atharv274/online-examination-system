package controller;

import dao.ResultDAO;
import model.Question;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/nextQuestion")
public class NextQuestionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {

            HttpSession session = req.getSession();

            List<Question> questions =
                (List<Question>)session.getAttribute("questions");

            int index =
                (int)session.getAttribute("currentIndex");

            Map<Integer,String> answers =
                (Map<Integer,String>)session.getAttribute("answers");

            int questionId =
                Integer.parseInt(req.getParameter("questionId"));

            String selected =
                req.getParameter("answer");

            answers.put(questionId, selected);

            if(index < questions.size()-1){

                session.setAttribute("currentIndex", index+1);
                resp.sendRedirect("takeExam.jsp");

            } else {

                int score = 0;

                for(Question q : questions){

                    String ans = answers.get(q.getQuestionId());

                    if(ans != null &&
                       ans.equals(q.getCorrectAnswer())) {

                        score += q.getMarks();
                    }
                }

                String email =
                    (String)session.getAttribute("email");

                int examId =
                    (int)session.getAttribute("examId");

                ResultDAO dao = new ResultDAO();
                dao.saveResult(email, examId, score);

                session.removeAttribute("questions");
                session.removeAttribute("answers");
                session.removeAttribute("currentIndex");

                resp.sendRedirect("result.jsp?score=" + score);
            }

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
