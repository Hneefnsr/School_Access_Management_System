<%-- 
    Document   : editrequest.jsp
    Created on : Jan 10, 2024, 10:34:39 PM
    Author     : usee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Request Access Form</title>
        <style>
            .form-item {
                margin-bottom: 10px;
                justify-content: space-between;
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
            input[type="email"],
            input[type="password"] {
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
                width: 100%;
                padding: 30px 5px;
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

        <header>
            <div class="logo-container">
                <img src="png\skbd logo1.png" alt="School Logo" class="logo">
                <span class="system-name">Sekolah Kebangsaan Bukit Damansara Access Permission System</span>
            </div>

            <div class="buttons">
                <button class="button"><a href="visitorprofile.jsp" style="text-decoration: none; color: white;">Back</a></button>
            </div>

        </header>

        <div id="sign-up-button">Edit Request</div>
        <form id="visitorForm" action="updateRequest" method="post">
            <%
                // Retrieve the requestID parameter from the URL
                int requestID = Integer.parseInt(request.getParameter("requestID"));

                // Retrieve session attributes
                int visitorID = (int) session.getAttribute("visitorID");
                String visitorName = (String) session.getAttribute("visitorName");
                String visitorEmail = (String) session.getAttribute("visitorEmail");

                // Database connection details
                String dbURL = "jdbc:mysql://localhost:3306/school_access_management";
                String dbUser = "admin";
                String dbPassword = "admin";

                try {
                    // Establish a database connection
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    // Retrieve specific request information based on requestID and visitorID
                    String selectQuery = "SELECT * FROM request WHERE requestID = ? AND visitorID = ?";
                    PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
                    preparedStatement.setInt(1, requestID);
                    preparedStatement.setInt(2, visitorID);
                    ResultSet resultSet = preparedStatement.executeQuery();

                    // Populate the form fields with the retrieved data
                    if (resultSet.next()) {
            %>
            <input type="hidden" name="requestID" value="<%= request.getParameter("requestID")%>">
            <div class="form-item">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%=visitorName%>" readonly>
            </div>
            <div class="form-item">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%=visitorEmail%>" readonly>
            </div>
            <div class="form-item">
                <label for="purpose">Purpose:</label>
                <textarea id="purpose" name="purpose" rows="3" required><%= resultSet.getString("visitPurpose")%></textarea>
            </div>

            <div class="form-item">
                <label for="date">Date:</label>
                <input type="date" id="date" name="date" value="<%= resultSet.getString("visitDate")%>" required>
            </div>
            <div class="form-item">
                <label for="time">Time:</label>
                <input type="time" id="time" name="time" value="<%= resultSet.getString("visitTime")%>" required min="07:00" max="17:00">
            </div>

            <%
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
            <div class="form-item">
                <input type="submit" value="Submit">
                <button type="button" onclick="location.href = 'pending.jsp'">Cancel</button>
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
