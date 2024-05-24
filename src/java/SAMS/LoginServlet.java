/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package SAMS;

/**
 *
 * @author usee
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String jdbcUrl = "jdbc:mysql://localhost:3306/school_access_management";
        String dbUser = "admin";
        String dbPassword = "admin";

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("user-type");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            String query = "";
            if ("admin".equals(userType)) {
                query = "SELECT * FROM administrator WHERE adminEmail=? AND adminPassword=?";
            } else if ("teacher".equals(userType)) {
                query = "SELECT * FROM teacher WHERE teacherEmail=? AND teacherPassword=?";
            } else if ("security".equals(userType)) {
                query = "SELECT * FROM security WHERE SecurityEmail=? AND securityPassword=?";
            } else if ("visitor".equals(userType)) {
                query = "SELECT * FROM visitor WHERE visitorEmail=? AND visitorPassword=?";
            }

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // User found in the database
                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                session.setAttribute("userType", userType);
                
                // Retrieve visitorID from the result set
//                int visitorID = resultSet.getInt("visitorID");
//                session.setAttribute("visitorID", userID);

                String redirectPage = userType + "profile.jsp";
                response.sendRedirect(redirectPage);
            } else {
                // User not found in the database
                System.out.println("User not found or Invalid email and password");
                response.sendRedirect("login.jsp?error=InvalidCredentials");
            }

            preparedStatement.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.out.println("Database Error: " + e.getMessage());
            response.sendRedirect("login.jsp?error=DatabaseError");
        }
    }

}
