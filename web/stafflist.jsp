<%-- 
    Document   : stafflist
    Created on : May 26, 2024, 8:50:15 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fontawesome.com/icons/check-to-slot?f=classic&s=solid" integrity="sha512-xxx" crossorigin="anonymous" />
        <title>Staff List</title>
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
        <div id="sign-up-button">Staff List</div>
        <button class="button2"><a href="addstaff.jsp" style="text-decoration: none; color: white;">Add Staff</a></button>
        <div class="container">
            <h2>Teachers</h2>
            <table id="teachers-table">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Phone</th>
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

                            // Retrieve all teachers
                            String selectQueryTeachers = "SELECT teacherFirstName, teacherLastName, teacherEmail, teacherPhone FROM teacher";
                            Statement statementTeachers = connection.createStatement();
                            ResultSet resultSetTeachers = statementTeachers.executeQuery(selectQueryTeachers);

                            // Display the data in the table
                            int rowNumber = 1;
                            while (resultSetTeachers.next()) {
                                String firstName = resultSetTeachers.getString("teacherFirstName");
                                String lastName = resultSetTeachers.getString("teacherLastName");
                                String email = resultSetTeachers.getString("teacherEmail");
                                String phone = resultSetTeachers.getString("teacherPhone");

                                // Add a row to the table
                                out.println("<tr>");
                                out.println("<td>" + rowNumber + "</td>");
                                out.println("<td>" + firstName + "</td>");
                                out.println("<td>" + lastName + "</td>");
                                out.println("<td>" + email + "</td>");
                                out.println("<td>" + phone + "</td>");
                                out.println("</tr>");

                                rowNumber++;
                            }

                            // Close the ResultSet for teachers
                            resultSetTeachers.close();
                            statementTeachers.close();
                        } catch (Exception e) {
                            // Handle database connection or query errors
                            out.println("Error: " + e.getMessage());
                        }
                    %>
                </tbody>
            </table>
            <h2>Security Guards</h2>
            <table id="security-table">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            // Establish a database connection
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                            // Retrieve all security guards
                            String selectQuerySecurity = "SELECT securityFirstName, securityLastName, securityEmail, securityPhone FROM security";
                            Statement statementSecurity = connection.createStatement();
                            ResultSet resultSetSecurity = statementSecurity.executeQuery(selectQuerySecurity);

                            // Display the data in the table
                            int rowNumber = 1;
                            while (resultSetSecurity.next()) {
                                String firstName = resultSetSecurity.getString("securityFirstName");
                                String lastName = resultSetSecurity.getString("securityLastName");
                                String email = resultSetSecurity.getString("securityEmail");
                                String phone = resultSetSecurity.getString("securityPhone");

                                // Add a row to the table
                                out.println("<tr>");
                                out.println("<td>" + rowNumber + "</td>");
                                out.println("<td>" + firstName + "</td>");
                                out.println("<td>" + lastName + "</td>");
                                out.println("<td>" + email + "</td>");
                                out.println("<td>" + phone + "</td>");
                                out.println("</tr>");

                                rowNumber++;
                            }

                            // Close the ResultSet for security guards
                            resultSetSecurity.close();
                            statementSecurity.close();
                            connection.close();
                        } catch (Exception e) {
                            // Handle database connection or query errors
                            out.println("Error: " + e.getMessage());
                        }
                    %>
                </tbody>
            </table>
        </div>
        <footer>
            <p>&copy; 2024 Sekolah Kebangsaan Bukit Damansara. All rights reserved.</p>
        </footer>
    </body>
</html>
