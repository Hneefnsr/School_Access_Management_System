<%-- 
    Document   : pending
    Created on : Jan 10, 2024, 9:46:34 PM
    Author     : usee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>

<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fontawesome.com/icons/check-to-slot?f=classic&s=solid" integrity="sha512-xxx" crossorigin="anonymous" />


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
            .tick-icon{
                width: 20px;
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
                <button class="button"><a href="visitorprofile.jsp" style="text-decoration: none; color: white;">Back</a></button>
            </div>

        </header>
        <div id="sign-up-button">Request List</div>
        <script>
            function deleteRequest(requestID) {
                if (confirm("Are you sure you want to delete this request?")) {
                    var xhr = new XMLHttpRequest();

                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            alert(xhr.responseText);
                            location.reload();
                        }
                    };

                    xhr.open("POST", "deleteRequest", true);
                    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    xhr.send("requestID=" + requestID);
                }
            }
        </script>
        <div class="container">
            <table id="visits-table">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Visit Purpose</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Retrieve session attribute
                        int visitorID = (int) session.getAttribute("visitorID");

                        // Database connection details
                        String dbURL = "jdbc:mysql://localhost:3306/school_access_management";
                        String dbUser = "admin";
                        String dbPassword = "admin";

                        try {
                            // Establish a database connection
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                            // Retrieve pending requests for the specific visitor
                            String selectQuery = "SELECT * FROM request WHERE visitorID = ?";
                            PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
                            preparedStatement.setInt(1, visitorID);
                            ResultSet resultSet = preparedStatement.executeQuery();

                            // Display the data in the table
                            int rowNumber = 1;
                            while (resultSet.next()) {
                                String visitPurpose = resultSet.getString("visitPurpose");
                                String date = resultSet.getString("visitDate");
                                String time = resultSet.getString("visitTime");
                                String status = resultSet.getString("visitStatus");

                                // Add a row to the table
                                out.println("<tr>");
                                out.println("<td>" + rowNumber + "</td>");
                                out.println("<td>" + visitPurpose + "</td>");
                                out.println("<td>" + date + "</td>");
                                out.println("<td>" + time + "</td>");
                                out.println("<td>" + status + "</td>");

                                // Add Edit and Delete buttons
                                out.println("<td>");
                                if (status.equalsIgnoreCase("approved") || (status.equalsIgnoreCase("rejected"))) {
                                    if (status.equals("Approved")) {
                                        out.println("<img src='png/checked.png' alt='Approved' class='tick-icon'/>");
                                    } else if (status.equals("Rejected")) {
                                        out.println("<img src='png/remove.png' alt='Rejected' class='tick-icon'/>");
                                    }
                                } else {
                                    out.println("<button onclick=\"editRequest(" + resultSet.getInt("requestID") + ")\">Edit</button>");
                                    out.println("<button onclick=\"deleteRequest(" + resultSet.getInt("requestID") + ")\">Delete</button>");
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
            function editRequest(requestID) {
                // Redirect to the edit page with the specific requestID
                window.location.href = "editrequest.jsp?requestID=" + requestID;
            }


        </script>
        <footer>
            <p>&copy; 2024 Sekolah Kebangsaan Bukit Damansara. All rights reserved.</p>
        </footer>
    </body>
</html>
