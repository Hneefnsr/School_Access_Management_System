<%-- 
    Document   : accessrecord
    Created on : May 26, 2024, 10:10:02 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Record</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-image: url("png/bgRegistration.png");
                background-size: cover;
            }
            header {
                background-color: #949bac;
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .logo-container {
                display: flex;
                align-items: center;
            }
            .logo {
                margin-left: 70px;
                width: 110px;
                height: 120px;
            }
            .system-name {
                font-family: 'Georgia', serif;
                font-size: 42px;
                text-align: center;
                margin-right: 4%;
            }
            .buttons {
                margin-right: auto;
                display: flex;
            }
            .button {
                background-color: #908c8c;
                color: white;
                border: none;
                border-radius: 12px;
                text-decoration: none;
                padding: 5px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 5px;
                cursor: pointer;
                white-space: nowrap;
                transition-duration: 0.4s;
            }
            .button2{
                background-color: #908c8c;
                color: white;
                border: none;
                border-radius: 12px;
                text-decoration: none;
                padding: 8px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin-left: 35px;
                cursor: pointer;
                white-space: nowrap;
                transition-duration: 0.4s;
            }

            .button:hover {
                box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
                background-color: #6b6b6b;
            }

            .button2:hover{
                box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
                background-color: #6b6b6b;
            }

            #sign-up-button {
                margin-top: 20px;
                font-size: 40px;
                font-weight: bold;
                text-align: center;
                color: #ffffff;
            }
            table {
                margin-top: 10px;
                border-collapse: collapse;
                width: 100%;
            }
            .container {
                margin: 10px;
            }
            th,
            td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #6b6b6b;
                color: white;
            }
            tbody {
                background-color: #ccc;
            }
            footer {
                color: gray;
                text-align: center;
                position: relative;
                bottom: 0;
                width: 100%;
            }
            h2 {
                color: white;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="logo-container">
                <img src="png\skbd logo1.png" alt="School Logo" class="logo">
                <span class="system-name">Sekolah Kebangsaan Bukit Damansara Access Permission System</span>
            </div>
            <div class="buttons">
                <button class="button"><a href="adminprofile.jsp" style="text-decoration: none; color: white;">Back</a></button>
            </div>
        </header>
        <h2>Visitor Requests</h2>
        <table>
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Visit Purpose</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Check In Time</th>
                    <th>Check Out Time</th>
                    <th>Security On Duty</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database connection details
                    String dbURL = "jdbc:mysql://localhost:3306/school_access_management";
                    String dbUser = "admin";
                    String dbPassword = "admin";

                    try {
                        // Establish a database connection
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                        // Retrieve visitor requests with their check-in and check-out times and security names
                        String selectQuery = "SELECT v.visitorFirstName, v.visitorLastName, r.visitPurpose, r.visitDate, r.visitTime, r.visitStatus, rec.checkinTime, rec.checkoutTime, s.securityFirstname, s.securityLastname "
                                + "FROM request r "
                                + "JOIN visitor v ON r.visitorID = v.visitorID "
                                + "LEFT JOIN record rec ON r.requestID = rec.requestID "
                                + "LEFT JOIN security s ON rec.securityID = s.securityID"; // Joined with the security table
                        Statement statement = connection.createStatement();
                        ResultSet resultSet = statement.executeQuery(selectQuery);

                        // Display the data in the table
                        while (resultSet.next()) {
                            String visitorFirstName = resultSet.getString("visitorFirstName");
                            String visitorLastName = resultSet.getString("visitorLastName");
                            String visitPurpose = resultSet.getString("visitPurpose");
                            Date visitDate = resultSet.getDate("visitDate");
                            Time visitTime = resultSet.getTime("visitTime");
                            String visitStatus = resultSet.getString("visitStatus");
                            Time checkInTime = resultSet.getTime("checkinTime");
                            Time checkOutTime = resultSet.getTime("checkoutTime");
                            String securityFirstname = resultSet.getString("securityFirstname");
                            String securityLastname = resultSet.getString("securityLastname");
                            

                            // Output table row for each request
                            out.println("<tr>");
                            out.println("<td>" + visitorFirstName + " " + visitorLastName + "</td>");
                            out.println("<td>" + visitPurpose + "</td>");
                            out.println("<td>" + visitDate + "</td>");
                            out.println("<td>" + visitTime + "</td>");
                            out.println("<td>" + visitStatus + "</td>");
                            out.println("<td>" + (checkInTime != null ? checkInTime : "N/A") + "</td>");
                            out.println("<td>" + (checkOutTime != null ? checkOutTime : "N/A") + "</td>");
                            out.println("<td>" + (securityFirstname != null ? securityFirstname : "") +" "+ (securityLastname != null ? securityLastname : "N/A") + "</td>");
                            out.println("</tr>");
                        }

                        // Close the ResultSet and Statement
                        resultSet.close();
                        statement.close();
                        connection.close();
                    } catch (Exception e) {
                        e.printStackTrace(); // Log the error to the server logs
                        out.println("<tr><td colspan='8'>Error retrieving data: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </body>
</html>

