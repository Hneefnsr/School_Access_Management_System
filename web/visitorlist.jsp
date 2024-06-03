<%-- 
    Document   : visitorlist
    Created on : Jun 2, 2024, 4:28:42 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Visitors List</title>
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
                display: inline-block;
                font-size: 16px;
                margin: 4px 5px;
                cursor: pointer;
                white-space: nowrap;
                transition-duration: 0.4s;
            }
            .button:hover {
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
                <img src="png/skbd logo1.png" alt="School Logo" class="logo">
                <span class="system-name">Sekolah Kebangsaan Bukit Damansara Access Permission System</span>
            </div>
            <div class="buttons">
                <button class="button"><a href="securityprofile.jsp" style="text-decoration: none; color: white;">Back</a></button>
            </div>
        </header>
        <h2>Visitors List</h2>
        <form action="RecordCheckInOutServlet" method="POST">
            <table>
                <thead>
                    <tr>
                        <th>Number</th>
                        <th>Name</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Check In Time</th>
                        <th>Check Out Time</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Database connection details
                        String dbURL = "jdbc:mysql://localhost:3306/school_access_management";
                        String dbUser = "admin";
                        String dbPassword = "admin";

                        // Retrieve securityID from session
                        session = request.getSession();
                        Integer securityID = (Integer) session.getAttribute("securityID");

                        if (securityID == null || securityID == 0) {
                            out.println("<tr><td colspan='7'>Error: Security ID not found in session. Please log in again.</td></tr>");
                        } else {
                            try {
                                // Establish a database connection
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                                // Retrieve approved visitor requests and their check-in/check-out times
                                String selectQuery = "SELECT r.requestID, v.visitorFirstName, v.visitorLastName, r.visitDate, r.visitTime, rec.checkInTime, rec.checkOutTime "
                                        + "FROM request r "
                                        + "JOIN visitor v ON r.visitorID = v.visitorID "
                                        + "LEFT JOIN record rec ON r.requestID = rec.requestID "
                                        + "WHERE r.visitStatus = 'Approved'";
                                Statement statement = connection.createStatement();
                                ResultSet resultSet = statement.executeQuery(selectQuery);

                                // Display the data in the table
                                int number = 1;
                                while (resultSet.next()) {
                                    int requestID = resultSet.getInt("requestID");
                                    String visitorFirstName = resultSet.getString("visitorFirstName");
                                    String visitorLastName = resultSet.getString("visitorLastName");
                                    Date visitDate = resultSet.getDate("visitDate");
                                    Time visitTime = resultSet.getTime("visitTime");
                                    Time checkInTime = resultSet.getTime("checkInTime");
                                    Time checkOutTime = resultSet.getTime("checkOutTime");

                                    // Output table row for each request
                                    out.println("<tr>");
                                    out.println("<td>" + number++ + "</td>");
                                    out.println("<td>" + visitorFirstName + " " + visitorLastName + "</td>");
                                    out.println("<td>" + visitDate + "</td>");
                                    out.println("<td>" + visitTime + "</td>");
                                    out.println("<td><input type='time' name='checkInTime_" + requestID + "' value='" + (checkInTime != null ? checkInTime : "") + "'><button type='submit' name='action' value='checkIn_" + requestID + "'>Submit</button></td>");
                                    out.println("<td><input type='time' name='checkOutTime_" + requestID + "' value='" + (checkOutTime != null ? checkOutTime : "") + "'><button type='submit' name='action' value='checkOut_" + requestID + "'>Submit</button></td>");
                                    out.println("</tr>");
                                }

                                // Close the ResultSet and Statement
                                resultSet.close();
                                statement.close();
                                connection.close();
                            } catch (Exception e) {
                                // Handle database connection or query errors
                                out.println("<tr><td colspan='7'>Error retrieving data: " + e.getMessage() + "</td></tr>");
                            }
                        }
                    %>
                </tbody>
            </table>
            <input type="hidden" name="securityID" value="<%= securityID%>">
        </form>
    </body>
</html>


