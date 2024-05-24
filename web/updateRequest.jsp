<%-- 
    Document   : updateRequest
    Created on : Jan 11, 2024, 2:01:45 AM
    Author     : usee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- Your head content goes here -->
    </head>
    <body>
        <%
            String requestIDParam = request.getParameter("requestID");
            int requestID = (requestIDParam != null && !requestIDParam.isEmpty()) ? Integer.parseInt(requestIDParam) : 0;
            String purpose = request.getParameter("purpose");
            String date = request.getParameter("date");
            String time = request.getParameter("time");

            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/school_access_management";
            String dbUser = "admin";
            String dbPassword = "admin";

            try {
                // Establish a database connection
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

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
                    out.println("Error: Failed to update the request.");
                }
            } catch (Exception e) {
                // Handle database connection or query errors
                out.println("Error: " + e.getMessage());
            }
        %>
    </body>
</html>


