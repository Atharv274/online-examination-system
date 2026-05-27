package dao;

import java.sql.*;
import model.user;
import util.DBConnection;
import java.util.*;

public class UserDAO {

    public user login(String email, String password) throws Exception {

        Connection con = DBConnection.getConnection();

        String sql = "SELECT * FROM users WHERE email=? AND password=?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            user u = new user();

            u.setId(rs.getInt("id"));
            u.setName(rs.getString("name"));
            u.setEmail(rs.getString("email"));
            u.setRole(rs.getString("role"));

            // NEW
            u.setSubjectName(rs.getString("subject_name"));

            return u;
        }

        rs.close();
        ps.close();
        con.close();

        return null;
    }

    public boolean addUser(user u) throws Exception {

        Connection con = DBConnection.getConnection();

        String sql =
        "INSERT INTO users(name,email,password,role,subject_name) VALUES(?,?,?,?,?)";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, u.getName());
        ps.setString(2, u.getEmail());
        ps.setString(3, u.getPassword());
        ps.setString(4, u.getRole());
        ps.setString(5, u.getSubjectName());

        boolean result = ps.executeUpdate() > 0;

        ps.close();
        con.close();

        return result;
    }

    public void deleteUser(String email) throws Exception {

        Connection con = DBConnection.getConnection();

        String sql = "DELETE FROM users WHERE email=?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, email);

        ps.executeUpdate();

        ps.close();
        con.close();
    }

    public boolean registerUser(String name,
                                String email,
                                String password,
                                String role,
                                String subjectName) throws Exception {

        Connection con = DBConnection.getConnection();

        String sql =
        "INSERT INTO users(name,email,password,role,subject_name) VALUES(?,?,?,?,?)";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, password);
        ps.setString(4, role);
        ps.setString(5, subjectName);

        int rows = ps.executeUpdate();

        ps.close();
        con.close();

        return rows > 0;
    }

    public List<user> getAllUsers() throws Exception {

        List<user> list = new ArrayList<>();

        Connection con = DBConnection.getConnection();

        String sql = "SELECT * FROM users";

        PreparedStatement ps = con.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {

            user u = new user();

            u.setId(rs.getInt("id"));
            u.setName(rs.getString("name"));
            u.setEmail(rs.getString("email"));
            u.setRole(rs.getString("role"));

            // NEW
            u.setSubjectName(rs.getString("subject_name"));

            list.add(u);
        }

        rs.close();
        ps.close();
        con.close();

        return list;
    }
}