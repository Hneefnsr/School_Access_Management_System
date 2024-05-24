/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package SAMS;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
/**
 *
 * @author usee
 */
@WebServlet("/deleteRequest")
public class DeleteReqServlet extends HttpServlet{
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int requestID = Integer.parseInt(request.getParameter("requestID"));

        // Database connection details (update with your database credentials)
        String dbURL = "jdbc:mysql://localhost:3306/school_access_management";
        String dbUser = "admin";
        String dbPassword = "admin";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            DeleteReqModel requestModel = new DeleteReqModel(connection);

            // Attempt to delete the request
            if (requestModel.deleteRequest(requestID)) {
                response.getWriter().write("Request deleted successfully");
            } else {
                response.getWriter().write("Error deleting request");
            }

            connection.close();
        } catch (Exception e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
