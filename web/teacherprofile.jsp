<%-- 
    Document   : adminprofile
    Created on : Apr 30, 2024, 12:42:52 AM
    Author     : usee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Profile Page</title>
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
                align-items: center;
                justify-content: space-between;
            }

            .logo-container {
                display: flex;
                align-items: center;
            }

            .logo {
                margin-left: 50px;
                width: 80px;
                height: 90px;
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
                width: 400px;
                margin: 0 auto;
                padding: 30px;
                border: 1px solid #ccc;
                border-radius: 20px;
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
            }

            button[type="submit"] {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                display: inline-block;
                transition-duration: 0.4s;

            }
            button[type="submit"]:hover{
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
            .cancelbutton{
                background-color: red;
            }

            footer {
                color: gray;
                text-align: center;
                position: relative;
                bottom: 0;
                width: 100%;
            }

            .password-container {
                position: relative;
            }

            .password-container .eye-icon {
                position: absolute;
                right: 10px;
                top: 33%;
                transform: translateY(-50%);
                cursor: pointer;
            }

            .account-log {
                text-align: center;
            }

            .text-danger {
                outline: none;
                text-decoration: none;

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
            String Email = (String) session.getAttribute("email");

            if (Email != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_access_management", "admin", "admin");
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM teacher WHERE teacherEmail = ?");
                    ps.setString(1, Email);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        String FirstName = rs.getString("teacherFirstName");
                        String LastName = rs.getString("teacherLastName");
                        String Password = rs.getString("teacherPassword");
                        String PhoneNumber = rs.getString("teacherPhone");
                        Email = rs.getString("teacherEmail");
                        int teacherID = rs.getInt("teacherID");
                        session.setAttribute("teacherID", teacherID);
                        boolean editMode = false;

                        if (request.getParameter("editMode") != null) {
                            editMode = Boolean.parseBoolean(request.getParameter("editMode"));
                        }
                        session = request.getSession();
                        session.setAttribute("teacherName", FirstName + " " + LastName);
                        session.setAttribute("teacherEmail", Email);


                        if (request.getParameter("saveProfile") != null) {
                            // Retrieve the updated profile values from the request
                            String updatedFirstName = request.getParameter("first-name");
                            String updatedPassword = request.getParameter("password");
                            String updatedLastName = request.getParameter("last-name");
                            String updatedEmail = request.getParameter("email");
                            String updatedPhoneNumber = request.getParameter("phone-number");

                            // Update the database with the new profile values
                            PreparedStatement updatePs = con.prepareStatement("UPDATE teacher SET teacherPhone = ?, teacherPassword = ?, teacherFirstName = ?, teacherLastName = ? WHERE teacherEmail = ?");
                            updatePs.setString(1, updatedPhoneNumber);
                            updatePs.setString(2, updatedPassword);
                            updatePs.setString(3, updatedFirstName);
                            updatePs.setString(4, updatedLastName);
                            updatePs.setString(5, updatedEmail);
                            updatePs.executeUpdate();

                            updatePs.close();

                            // Redirect to the profile page in view mode
                            response.sendRedirect("teacherprofile.jsp");
                            return; // Stop further execution of the JSP
                        }
        %>
        <header>
            <div class="logo-container">
                <img src="png\skbd logo1.png" alt="School Logo" class="logo">
            </div>

            <div class="buttons">
                <button class="button"><a href="reqlist.jsp" style="text-decoration: none; color: white;">Request List</a></button>
                <button class="button"><a href="homepage.jsp" style="text-decoration: none; color: white;">Log Out</a></button>
            </div>

        </header>

        <div id="sign-up-button">Profile Information</div>
        <br>
        <div class="container">
            <form id="profileForm">
                <canvas id="logo" width="100" height="100"></canvas>
                <div>
                    <label for="firstname">First Name:</label>
                    <input type="text" placeholder="Enter your First Name" value="<%=FirstName%>" id="firstname" name="first-name" required
                           onkeypress="allowOnlyAlphabeticInput(event)"
                           <%-- Add readonly attribute if not in edit mode --%>
                           <% if (!editMode) { %>
                           readonly
                           <% }%>
                           >
                </div>
                <div>
                    <label for="lastname">Last Name:</label>
                    <input type="text" placeholder="Enter your Last Name" value="<%=LastName%>" id="lastname" name="last-name" required
                           onkeypress="allowOnlyAlphabeticInput(event)"
                           <%-- Add readonly attribute if not in edit mode --%>
                           <% if (!editMode) { %>
                           readonly
                           <% }%>
                           >
                </div>
                <div>
                    <label for="email">Email Address</label>
                    <input type="text" placeholder="Enter your Email Address" value="<%=Email%>" id="email" name="email"required
                           <%-- Add readonly attribute if not in edit mode --%>
                           <% if (!editMode) { %>
                           readonly
                           <% }%>
                           >
                </div>
                <div>
                    <label for="phonenumber">Phone Number</label>
                    <input type="text" placeholder="Enter your Phone Number" value="<%=PhoneNumber%>" id="phonenumber"
                           name="phone-number" onkeypress="allowOnlyNumericInput(event)" maxlength="11" required
                           <%-- Add readonly attribute if not in edit mode --%>
                           <% if (!editMode) { %>
                           readonly
                           <% }%>
                           >
                </div>
                <div class="password-container">
                    <label for="password">Password</label>
                    <div style="position: relative;">
                        <input type="password" placeholder="Enter your Password" value="<%=Password%>" id="password" name="password" oninput="validatePassword(this)" required
                               <%-- Add readonly attribute if not in edit mode --%>
                               <% if (!editMode) { %>
                               readonly
                               <% }%>
                               >
                        <span class="eye-icon" onclick="togglePasswordVisibility()">&#128065;</span>
                    </div>
                    <div id="passwordError" style="color: red"></div>
                </div>
                <%-- Display Edit/Save button based on the edit mode --%>
                <% if (editMode) { %>
                <div class="buttons">
                    <button type="submit" name="saveProfile">Save</button><br/>
                    <button type="button" onclick="location.href = 'teacherprofile.jsp'">Cancel</button>
                </div>
                <% } else { %>
                <div class="account-log" style="text-align: center;">
                    <button type="submit" name="editMode" value="true">Edit</button>
                </div>
                <% } %>


            </form>
            <%
                        } else {
                            out.println("No teacher profile found.");
                        }
                        rs.close();
                        ps.close();
                        con.close();
                    } catch (Exception e) {
                        out.println("Error: " + e);
                    }
                } else {
                    // If the session doesn't exist or adminID is not set, redirect to the login page
                    response.sendRedirect("login.jsp");
                }
            %>

        </div>

        <script>
            // Function to allow only alphabetic input
            function allowOnlyAlphabeticInput(event) {
                const keyCode = event.keyCode || event.which;
                const keyValue = String.fromCharCode(keyCode);

                // Allow only alphabetic characters and certain control keys
                const alphabeticRegex = /^[A-Za-z\s]+$/;
                if (!alphabeticRegex.test(keyValue)) {
                    event.preventDefault();
                }
            }
            function allowOnlyNumericInput(event) {
                const keyCode = event.keyCode || event.which;
                const keyValue = String.fromCharCode(keyCode);

                // Allow only numeric values and certain control keys
                const numericRegex = /^[0-9\b]+$/;
                if (!numericRegex.test(keyValue)) {
                    event.preventDefault();
                }
            }
            function validatePassword(input) {
                var password = input.value;
                var passwordError = document.getElementById("passwordError");

                // Regular expression to match the password requirements
                var regex = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()])[A-Za-z\d!@#$%^&*()]{8,}$/;

                if (!regex.test(password)) {
                    passwordError.textContent = "Password must be at least 8 characters long, contain an uppercase letter, a numeric character, and a special character.";
                } else {
                    passwordError.textContent = "";
                    input.setCustomValidity("");
                }
            }
            function togglePasswordVisibility() {
                const passwordInput = document.getElementById('password');
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                } else {
                    passwordInput.type = 'password';
                }
            }
        </script>

    </body>

    <footer>
        <p>&copy; 2024 Sekolah Kebangsaan Bukit Damansara. All rights reserved.</p>

    </footer>

</html>