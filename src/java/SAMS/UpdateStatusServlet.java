/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package SAMS;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateStatus")
public class UpdateStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int requestID = Integer.parseInt(request.getParameter("requestID"));
        String newStatus = request.getParameter("newStatus");
        int teacherID = (int) request.getSession().getAttribute("teacherID");
        String notes = request.getParameter("notes");

        // Log received parameters
        System.out.println("Request ID: " + requestID);
        System.out.println("New Status: " + newStatus);
        System.out.println("Teacher ID: " + teacherID);
        System.out.println("Notes: " + notes);

        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/school_access_management";
        String dbUser = "admin";
        String dbPassword = "admin";

        try {
            // Establish a database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Insert data into the approval table
            String insertApprovalQuery = "INSERT INTO approval (decision, teacherID, requestID, notes) VALUES (?, ?, ?, ?)";
            PreparedStatement approvalStatement = connection.prepareStatement(insertApprovalQuery);
            approvalStatement.setString(1, newStatus);
            approvalStatement.setInt(2, teacherID);
            approvalStatement.setInt(3, requestID);
            approvalStatement.setString(4, notes);
            approvalStatement.executeUpdate();
            approvalStatement.close();

            // Update status in the request table
            String updateRequestQuery = "UPDATE request SET visitStatus = ? WHERE requestID = ?";
            PreparedStatement requestStatement = connection.prepareStatement(updateRequestQuery);
            requestStatement.setString(1, newStatus);
            requestStatement.setInt(2, requestID);
            requestStatement.executeUpdate();
            requestStatement.close();

            // Close the database connection
            connection.close();

            // Send response back to the client
            response.getWriter().write("Status updated successfully.");
        } catch (Exception e) {
            // Handle database connection or query errors
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

}
