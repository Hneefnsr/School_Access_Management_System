<%-- 
    Document   : accessform
    Created on : Jan 9, 2024, 9:13:29 PM
    Author     : usee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>New Request Form</title>
        <style>
            .form-item {
                margin-bottom: 10px;
                font-size: 20px;
            }

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

            form {
                height: auto;
                width: 500px;
                margin: 0 auto;
                padding: 30px;
                border: 1px solid #ccc;
                border-radius: 5px;
                border-color: #007bff;
                font-size: 20px;
                background-color: #ccc;
            }

            label {
                display: block;
                margin-bottom: 5px;
            }

            input[type="text"],
            input[type="email"] {
                width: 100%;
                padding: 10px;
                border: 2px solid #ccc;
                border-radius: 20px;
                box-sizing: border-box;
                margin-bottom: 10px;
                background-color: #e1e1e1;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif
            }

            #purpose{
                width: 95%;
                padding: 10px;
                background-color: #e1e1e1;
                border: #ccc;
                border-radius: 15px;
            }

            input[type="date"],
            input[type="time"] {
                width: 45%;
                text-align: center;
                border: 2px solid #ccc;
                border-radius: 15px;
                padding: 5px;
                background-color: #e1e1e1;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif
            }

            input[type="submit"] {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                transition-duration: 0.4s;

            }
            input[type="submit"]:hover{
                background-color:darkblue;
                box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
            }
            button[type="button"]{
                background-color: red;
                color: white;
                margin-left: 10px;
                padding: 10px 20px;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                display: inline-block;
                transition-duration: 0.4s;
            }
            button[type="button"]:hover{
                background-color:darkred;
                box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
            }

            footer {
                color: gray;
                text-align: center;
                position: relative;
                bottom: 0;
                width: 100%;
            }

            #logo {
                border: 1px solid black;
                border-radius: 100%;
                margin-left: 150px;
                align-items: center;
                background-image: url("png/profile-icon-9.png");
                background-size: cover;
            }
        </style>
    </head>

    <body>
        <%
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/school_access_management";
            String dbUser = "admin";
            String dbPassword = "admin";

            // Retrieve session attributes
            String visitorName = (String) session.getAttribute("visitorName");
            String visitorEmail = (String) session.getAttribute("visitorEmail");

            // Additional session attribute for visitorID
            int visitorID = (int) session.getAttribute("visitorID");

            // Check if the form is submitted
            if (request.getMethod().equals("POST")) {
                // Retrieve form data
                String visitPurpose = request.getParameter("purpose");
                String visitDate = request.getParameter("date");
                String visitTime = request.getParameter("time");
                String visitStatus = "Pending";

                try {
                    // Establish a database connection
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    // Insert data into the database
                    String insertQuery = "INSERT INTO request (visitorID, visitPurpose, visitDate, visitTime, visitStatus) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
                    preparedStatement.setInt(1, visitorID);
                    preparedStatement.setString(2, visitPurpose);
                    preparedStatement.setString(3, visitDate);
                    preparedStatement.setString(4, visitTime);
                    preparedStatement.setString(5, visitStatus);
                    preparedStatement.executeUpdate();

                    // Close the database resources
                    preparedStatement.close();
                    connection.close();

                    // Redirect to visitorprofile.jsp after successful database insertion
                    response.sendRedirect("visitorprofile.jsp");
                    return; // Stop further execution of the JSP

                } catch (Exception e) {
                    // Handle database connection or insertion errors
                    out.println("Error: " + e.getMessage());
                }
            }

        %>
        <header>
            <div class="logo-container">
                <img src="png\skbd logo1.png" alt="School Logo" class="logo">
                <span class="system-name">Sekolah Kebangsaan Bukit Damansara Access Permission System</span>
            </div>

            <div class="buttons">
                <button class="button"><a href="visitorprofile.jsp" style="text-decoration: none; color: white;">Back</a></button>
            </div>

        </header>

        <div id="sign-up-button">New Request Form</div>
        <form id="visitorForm" method="post">
            <div class="form-item">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%=visitorName%>" readonly onkeypress="allowOnlyAlphabeticInput(event)">
            </div>
            <div class="form-item">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%=visitorEmail%>" readonly>
            </div>
            <div class="form-item">
                <label for="purpose">Visit Purpose:</label>
                <textarea id="purpose" name="purpose" rows="3" required></textarea>
            </div>
            <div class="form-item">
                <label for="date">Date:</label>
                <input type="date" id="date" name="date" required>
            </div>

            <div class="form-item">
                <label for="time">Time:</label>
                <input type="time" id="time" name="time" required min="07:00" max="17:00">
            </div>
            <div class="form-item">
                <input type="submit" value="Submit" onclick="submitRequest()">
                <button type="button" onclick="location.href = 'visitorprofile.jsp'">Cancel</button>
            </div>
        </form>

        <script>
            document.getElementById('visitorForm').addEventListener('submit', function (event) {
                event.preventDefault();
                this.submit();
            });

            function isTimeInRange(time, startTime, endTime) {
                var selectedTime = new Date('2000-01-01T' + time);
                var start = new Date('2000-01-01T' + startTime);
                var end = new Date('2000-01-01T' + endTime);

                var isInRange = selectedTime >= start && selectedTime <= end;

                if (!isInRange) {
                    alert('Please select a time between 7:00 am and 5:00 pm.');
                }

                return isInRange;
            }

            // Function to set the minimum date to tomorrow's date
            function setMinDate() {
                var tomorrow = new Date();
                tomorrow.setDate(tomorrow.getDate() + 1);

                var day = tomorrow.getDate();
                var month = tomorrow.getMonth() + 1;
                var year = tomorrow.getFullYear();

                if (day < 10) {
                    day = '0' + day;
                }
                if (month < 10) {
                    month = '0' + month;
                }

                var minDate = year + '-' + month + '-' + day;
                document.getElementById('date').setAttribute('min', minDate);
            }

            // Call setMinDate() when the page loads
            setMinDate();

            // Function to validate the selected time range
            function isTimeInRange(time, startTime, endTime) {
                var selectedTime = new Date('2000-01-01T' + time);
                var start = new Date('2000-01-01T' + startTime);
                var end = new Date('2000-01-01T' + endTime);

                var isInRange = selectedTime >= start && selectedTime <= end;

                if (!isInRange) {
                    alert('Please select a time between 7:00 am and 5:00 pm.');
                }

                return isInRange;
            }
        </script>

        <footer>
            <p>&copy; 2024 Sekolah Kebangsaan Bukit Damansara. All rights reserved.</p>
        </footer>
    </body>

</html>