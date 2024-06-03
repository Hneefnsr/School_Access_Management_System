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
            <%
                // Database connection details
                String dbURL = "jdbc:mysql://localhost:3306/school_access_management";
                String dbUser = "admin";
                String dbPassword = "admin";

                if ("POST".equals(request.getMethod()) && "delete".equals(request.getParameter("action"))) {
                    // Get the ID to delete
                    int idToDelete = Integer.parseInt(request.getParameter("id"));

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                        // Delete from the teacher table
                        String deleteQueryTeacher = "DELETE FROM teacher WHERE teacherID = ?";
                        PreparedStatement deleteStatementTeacher = connection.prepareStatement(deleteQueryTeacher);
                        deleteStatementTeacher.setInt(1, idToDelete);
                        int rowsAffectedTeacher = deleteStatementTeacher.executeUpdate();
                        deleteStatementTeacher.close();

                        // Delete from the security table
                        String deleteQuerySecurity = "DELETE FROM security WHERE securityID = ?";
                        PreparedStatement deleteStatementSecurity = connection.prepareStatement(deleteQuerySecurity);
                        deleteStatementSecurity.setInt(1, idToDelete);
                        int rowsAffectedSecurity = deleteStatementSecurity.executeUpdate();
                        deleteStatementSecurity.close();

                        connection.close();

                        // If at least one row is affected in either table, print success message
                        if (rowsAffectedTeacher > 0 || rowsAffectedSecurity > 0) {
                            out.println("<script>alert('Staff member deleted successfully.');</script>");
                        } else {
                            out.println("<script>alert('No staff member found with the given ID.');</script>");
                        }
                    } catch (Exception e) {
                        // Handle database connection or query errors
                        out.println("<script>alert('An error occurred while deleting staff data: " + e.getMessage() + "');</script>");
                    }
                }
            %>
            <br>
            <h2>Teachers</h2>
            <table id="teachers-table">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Database connection details
                        try {
                            // Establish a database connection
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                            // Retrieve all teachers
                            String selectQueryTeachers = "SELECT teacherID, teacherFirstName, teacherLastName, teacherEmail, teacherPhone FROM teacher";
                            Statement statementTeachers = connection.createStatement();
                            ResultSet resultSetTeachers = statementTeachers.executeQuery(selectQueryTeachers);

                            // Display the data in the table
                            int rowNumber = 1;
                            while (resultSetTeachers.next()) {
                                int ID = resultSetTeachers.getInt("teacherID");
                                String firstName = resultSetTeachers.getString("teacherFirstName");
                                String lastName = resultSetTeachers.getString("teacherLastName");
                                String email = resultSetTeachers.getString("teacherEmail");
                                String phone = resultSetTeachers.getString("teacherPhone");

                                // Add a row to the table
                                out.println("<tr>");
                                out.println("<td>" + rowNumber + "</td>");
                                out.println("<td>" + firstName + " " + lastName + "</td>");
                                out.println("<td>" + email + "</td>");
                                out.println("<td>" + phone + "</td>");

                                // Add a delete button with confirmation dialog
                                out.println("<td>");
                                out.println("<input type='hidden' name='email' value='" + email + "'>");
                                out.println("<button onclick=\"deleteStaff(" + resultSetTeachers.getInt("teacherID") + ")\">Delete</button>");
                                out.println("</form>");
                                out.println("</td>");
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
            <br><br>
            <h2>Security Guards</h2>

            <table id="security-table">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            // Establish a database connection
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                            // Retrieve all security guards
                            String selectQuerySecurity = "SELECT securityID, securityFirstName, securityLastName, securityEmail, securityPhone FROM security";
                            Statement statementSecurity = connection.createStatement();
                            ResultSet resultSetSecurity = statementSecurity.executeQuery(selectQuerySecurity);

                            // Display the data in the table
                            int rowNumber = 1;
                            while (resultSetSecurity.next()) {
                                int ID = resultSetSecurity.getInt("securityID");
                                String firstName = resultSetSecurity.getString("securityFirstName");
                                String lastName = resultSetSecurity.getString("securityLastName");
                                String email = resultSetSecurity.getString("securityEmail");
                                String phone = resultSetSecurity.getString("securityPhone");

                                // Add a row to the table
                                out.println("<tr>");
                                out.println("<td>" + rowNumber + "</td>");
                                out.println("<td>" + firstName + " " + lastName + "</td>");
                                out.println("<td>" + email + "</td>");
                                out.println("<td>" + phone + "</td>");

                                // Add a delete button with confirmation dialog
                                out.println("<td>");
                                out.println("<input type='hidden' name='email' value='" + email + "'>");
                                out.println("<button onclick=\"deleteStaff(" + resultSetSecurity.getInt("securityID") + ")\">Delete</button>");
                                out.println("</form>");
                                out.println("</td>");
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
        <script>
            function deleteStaff(id) {
                if (confirm("Are you sure to delete this staff?")) {
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "stafflist.jsp", true);
                    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === XMLHttpRequest.DONE) {
                            if (xhr.status === 200) {
                                // Reload the page after successful deletion
                                window.location.reload();
                            } else {
                                alert("An error occurred while deleting staff data.");
                            }
                        }
                    };
                    xhr.send("action=delete&id=" + id);
                }
            }
        </script>
        <footer>
            <p>&copy; 2024 Sekolah Kebangsaan Bukit Damansara. All rights reserved.</p>
        </footer>
    </body>
</html>
