package controller;

import util.DBConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
@WebServlet("/deleteExam")
public class DeleteExamServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        try {

            Connection con = DBConnection.getConnection();

            // 1️⃣ Delete results first
            PreparedStatement ps1 =
                    con.prepareStatement("DELETE FROM results WHERE exam_id=?");
            ps1.setInt(1, id);
            ps1.executeUpdate();

            // 2️⃣ Delete questions
            PreparedStatement ps2 =
                    con.prepareStatement("DELETE FROM questions WHERE exam_id=?");
            ps2.setInt(1, id);
            ps2.executeUpdate();

            // 3️⃣ Delete exam
            PreparedStatement ps3 =
                    con.prepareStatement("DELETE FROM exams WHERE exam_id=?");
            ps3.setInt(1, id);
            ps3.executeUpdate();

            resp.sendRedirect("manageExams");

        } catch(Exception e){
            e.printStackTrace();
            resp.getWriter().println("Delete failed due to dependency.");
        }
    }
}
