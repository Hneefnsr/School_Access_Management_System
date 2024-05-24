<%-- 
    Document   : reqlist
    Created on : Apr 30, 2024, 1:01:39 AM
    Author     : usee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>

<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pending Form Lists</title>
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
            .button:hover{
                box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
                background-color:#6b6b6b;
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
            .container{
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
            button{
                border: none;
                border-radius: 5px;
                padding: 4px 5px;
                cursor: pointer;
                transition-duration: 0.3s;
            }
            button:hover{
                background-color:#ddd;
                box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
            }
            footer {
                color: gray;
                text-align: center;
                position: relative;
                bottom: 0;
                width: 100%;
            }
            tbody{
                background-color: #ccc;
            }
            .tick-icon {
                width: 20px; /* Adjust the width and height as needed */
                height: 20px;
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
                <button class="button"><a href="teacherprofile.jsp" style="text-decoration: none; color: white;">Back</a></button>
            </div>

        </header>
        <div id="sign-up-button">Request List</div>

        <div class="container">
            <table id="visits-table">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Visitor Name</th>
                        <th>Visit Purpose</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int teacherID = (int) session.getAttribute("teacherID");

                        // Database connection details
                        String dbURL = "jdbc:mysql://localhost:3306/school_access_management";
                        String dbUser = "admin";
                        String dbPassword = "admin";

                        try {
                            // Establish a database connection
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                            // Retrieve pending requests
                        String selectQuery = "SELECT r.*, CONCAT(v.visitorFirstName, ' ', v.visitorLastName) AS visitorName " +
                                             "FROM request r " +
                                             "INNER JOIN visitor v ON r.visitorID = v.visitorID";
                        PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
                        ResultSet resultSet = preparedStatement.executeQuery();

                            // Display the data in the table
                            int rowNumber = 1;
                            while (resultSet.next()) {
                                String visitorName = resultSet.getString("visitorName");
                                String visitPurpose = resultSet.getString("visitPurpose");
                                String date = resultSet.getString("visitDate");
                                String time = resultSet.getString("visitTime");
                                String status = resultSet.getString("visitStatus");

                                // Add a row to the table
                                out.println("<tr>");
                                out.println("<td>" + rowNumber + "</td>");
                                out.println("<td>" + visitorName + "</td>");
                                out.println("<td>" + visitPurpose + "</td>");
                                out.println("<td>" + date + "</td>");
                                out.println("<td>" + time + "</td>");
                                out.println("<td>" + status + "</td>");

                                // Check the status and render the appropriate buttons
                                out.println("<td>");
                                if (status.equals("Pending")) {
                                    out.println("<button onclick=\"approveRequest(" + resultSet.getInt("requestID") + ")\">Approve</button>");
                                    out.println("<button onclick=\"rejectRequest(" + resultSet.getInt("requestID") + ")\">Reject</button>");
                                } else {
                                    // Render tick or reject icon based on the status
                                    if (status.equals("Approved")) {
                                        out.println("<img src='png/checked.png' alt='Approved' class='tick-icon'/>");
                                    } else if (status.equals("Rejected")) {
                                        out.println("<img src='png/remove.png' alt='Rejected' class='tick-icon'/>");
                                    }
                                }
                                out.println("</td>");

                                rowNumber++;
                            }

                            // Close the database resources
                            resultSet.close();
                            preparedStatement.close();
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
            function addVisitRow(no, visitPurpose, date, time, status) {
                const table = document.getElementById('visits-table');
                const row = table.insertRow();
                const cells = ['No.', 'Visit Purpose', 'Date', 'Time', 'Status'];

                cells.forEach((cell, index) => {
                    const cellElement = row.insertCell(index);
                    cellElement.textContent = index === 0 ? no : eval(cell);
                });
            }

            function approveRequest(requestID) {
                updateStatus(requestID, 'Approved');
            }

            function rejectRequest(requestID) {
                updateStatus(requestID, 'Rejected');
            }

            function updateStatus(requestID, newStatus, teacherID) {
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        alert(xhr.responseText);
                        location.reload();
                    }
                };

                xhr.open("POST", "updateStatus", true);
                xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhr.send("requestID=" + requestID + "&newStatus=" + newStatus + "&teacherID=" + teacherID);
            }

        </script>
        <footer>
            <p>&copy; 2024 Sekolah Kebangsaan Bukit Damansara. All rights reserved.</p>
        </footer>
    </body>
</html>
