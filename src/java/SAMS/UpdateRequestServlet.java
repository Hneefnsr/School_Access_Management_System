/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package SAMS;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateRequest")
public class UpdateRequestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/school_access_management";
    private static final String DB_USER = "admin";
    private static final String DB_PASSWORD = "admin";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String requestIDParam = request.getParameter("requestID");
        int requestID = (requestIDParam != null && !requestIDParam.isEmpty()) ? Integer.parseInt(requestIDParam) : 0;
        String purpose = request.getParameter("purpose");
        String date = request.getParameter("date");
        String time = request.getParameter("time");

        try {
            // Establish a database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Update the request in the database
            String updateQuery = "UPDATE request SET visitPurpose=?, visitDate=?, visitTime=? WHERE requestID=?";
            PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);
            preparedStatement.setString(1, purpose);
            preparedStatement.setString(2, date);
            preparedStatement.setString(3, time);
            preparedStatement.setInt(4, requestID);

            // Execute the update query
            int rowsAffected = preparedStatement.executeUpdate();

            // Close the database resources
            preparedStatement.close();
            connection.close();

            // Check if the update was successful
            if (rowsAffected > 0) {
                // Redirect to pending.jsp after a successful update
                response.sendRedirect("pending.jsp");
            } else {
                response.getWriter().println("Error: Failed to update the request.");
            }
        } catch (Exception e) {
            // Handle database connection or query errors
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
