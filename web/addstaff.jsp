<%-- 
    Document   : addstaff.jsp
    Created on : May 26, 2024, 8:46:27 PM
    Author     : User
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="SAMS.Teacher"%>
<%@page import="SAMS.Security"%>
<%@page import="SAMS.staffDAO"%>
<%
    if (request.getMethod().equals("POST")) {
        String firstName = request.getParameter("first-name");
        String lastName = request.getParameter("last-name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phone-number");
        String role = request.getParameter("role");

        boolean success = false;

        if ("teacher".equals(role)) {
            Teacher teacher = new Teacher();
            teacher.setFirstName(firstName);
            teacher.setLastName(lastName);
            teacher.setEmail(email);
            teacher.setPassword(password);
            teacher.setPhoneNumber(phoneNumber);

            staffDAO staffDAO = new staffDAO();
            success = staffDAO.insertTeacher(teacher);
        } else if ("security".equals(role)) {
            Security security = new Security();
            security.setFirstName(firstName);
            security.setLastName(lastName);
            security.setEmail(email);
            security.setPassword(password);
            security.setPhoneNumber(phoneNumber);

            staffDAO staffDAO = new staffDAO();
            success = staffDAO.insertSecurity(security);
        }

        if (success) {
            response.sendRedirect("stafflist.jsp");
        } else {
            out.println("An error occurred while saving staff data.");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Staff</title>
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
                margin-left: 70px;
                width: 110px;
                height: 120px;
            }

            .system-name {
                font-family: 'Georgia', serif;
                font-size: 55px;
                text-align: center;
                margin-right: 50px;
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

            form {
                height: auto;
                width: 400px;
                margin: 0 auto;
                padding: 20px;
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
            input[type="tel"],
            input[type="email"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 20px;
                box-sizing: border-box;
                margin-bottom: 10px;
                background-color: #e1e1e1;
            }

            select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 20px;
                box-sizing: border-box;
                margin-bottom: 10px;
                background-color: #e1e1e1;
            }

            button[type="submit"] {
                background-color: #007bff;
                border: none;
                border-radius: 10px;
                color: white;
                padding: 10px 20px;
                cursor: pointer;
                transition-duration: 0.4s;
            }

            button[type="submit"]:hover {
                box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
                background-color: darkblue;
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
        </style>
    </head>
    <body>
        <header>
            <div class="logo-container">
                <img src="png\skbd logo1.png" alt="School Logo" class="logo">
                <span class="system-name">Sekolah Kebangsaan Bukit Damansara Access Permission System</span>
            </div>

            <div class="buttons">
                <button class="button"><a href="stafflist.jsp" style="text-decoration: none; color: white;">Back</a></button>
            </div>
        </header>
        <div id="sign-up-button">Add New Staff</div>
        <br>
        <form method="post" action="AddStaffServlet">
            <div>
                <label for="firstname">First name:</label>
                <input type="text" placeholder="Enter your First Name" id="firstname" name="first-name" required onkeypress="allowOnlyAlphabeticInput(event)">
            </div>
            <div>
                <label for="lastname">Last name:</label>
                <input type="text" placeholder="Enter your Last Name" id="lastname" name="last-name" required onkeypress="allowOnlyAlphabeticInput(event)">
            </div>
            <div>
                <label for="email">Email Address:</label>
                <input type="email" placeholder="Enter your Email" id="email" name="email" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" required>
            </div>
            <div>
                <label for="phonenumber">Phone Number:</label>
                <input type="tel" placeholder="Enter your Phone Number" id="phonenumber" name="phone-number" onkeypress="allowOnlyNumericInput(event)" maxlength="11" required>
            </div>
            <div class="password-container">
                <label for="password">Password:</label>
                <div style="position: relative;">
                    <input type="password" placeholder="Enter your Password" id="password" name="password" oninput="validatePassword(this)" required>
                    <span class="eye-icon" onclick="togglePasswordVisibility()">&#128065;</span>
                </div>
                <div id="passwordError" style="color: red"></div>
            </div>
            <div>
                <label for="role">Role:</label>
                <select id="role" name="role" required>
                    <option value="teacher">Teacher</option>
                    <option value="security">Security</option>
                </select>
            </div>
            <div class="account-log">
                <button type="submit" id="signup">Submit</button>
            </div>
        </form>
        <script>
            function allowOnlyAlphabeticInput(event) {
                const keyCode = event.keyCode || event.which;
                const keyValue = String.fromCharCode(keyCode);
                const alphabeticRegex = /^[A-Za-z\s]+$/;
                if (!alphabeticRegex.test(keyValue)) {
                    event.preventDefault();
                }
            }

            function allowOnlyNumericInput(event) {
                const keyCode = event.keyCode || event.which;
                const keyValue = String.fromCharCode(keyCode);
                const numericRegex = /^[0-9\b]+$/;
                if (!numericRegex.test(keyValue)) {
                    event.preventDefault();
                }
            }

            function validatePassword(input) {
                var password = input.value;
                var passwordError = document.getElementById("passwordError");
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


