<%-- 
    Document   : login
    Created on : Jan 6, 2024, 5:20:11 PM
    Author     : usee
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-image: url("png/bgRegistration.png");
                background-size:cover;
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
                /* Adjusted margin */
                width: 110px;
                /* Adjusted max-width */
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

            #log-in-button {
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
                background-color:#ccc;
            }
            .error-type{
                font-size: 15px;
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
                border: 1px solid #ccc;
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
                transition-duration: 0.4s;
            }

            button[type="submit"]:hover{
                box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
                background-color:darkblue;
            }

            footer {
                color: gray;
                text-align: center;
                position: relative;
                bottom: 0;
                width: 100%;
            }

            .account-log {
                text-align: center;
            }
            .radio{
                font-size: 15px;
                display:flex;
                white-space: nowrap;
                justify-content: space-between;
                align-items: center;
                padding-bottom: 15px;

            }
            .password-container {
                position: relative;
            }

            .password-container .eye-icon {
                position: absolute;
                right: 10px;
                top: 60%;
                transform: translateY(-50%);
                cursor: pointer;
            }
            .text-danger{
                outline: none;
                text-decoration: none;

            }

            a:hover{
                color: blue;
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
                <button class="button"><a href="homepage.jsp"
                                          style="text-decoration: none; color: white;">Home</a></button>
            </div>

        </header>
        <div id="log-in-button">Log In</div>
        <br>

        <form id="login" method="post" action="LoginServlet" enctype="application/x-www-form-urlencoded">
            <div class="error-type">
                <%
                    // Check for an error parameter in the URL
                    String error = request.getParameter("error");

                    // Display error message based on the error parameter
                    if (error != null && !error.isEmpty()) {
                        out.println("<div style='color: red; text-align: center;'>"
                                + "Invalid email or password. Please try again.</div>");
                    }
                %>
            </div>
            <div>
                <label for="email">Email address:</label>
                <input type="email" placeholder="Enter your Email" id="email" name="email" required>
            </div>
            <div class="password-container">
                <label for="password">Password:</label>
                <input type="password" placeholder="Enter your Password" id="password" name="password" required>
                <span class="eye-icon" onclick="togglePasswordVisibility()">&#128065;</span>
            </div>
            <div class="radio">
                <input type="radio" id="admin" name="user-type" value="admin" required>
                <label for="admin">Administrator</label>
                <input type="radio" id="teacher" name="user-type" value="teacher" required>
                <label for="manager">Teacher</label>
                <input type="radio" id="security" name="user-type" value="security" required>
                <label for="manager">Security</label>
                <input type="radio" id="visitor" name="user-type" value="visitor" required>
                <label for="manager">Visitor</label>
            </div>


            <div class="account-log">
                <button type="submit" id="login">Log In</button>
                <br>

                <p id="account-ask">Don't have an account?</p>
                <a role="button" href="signup.jsp" id="submitSignup" class="text-danger">Sign Up/Register</a>
            </div>
        </form>
        <script>
            function togglePasswordVisibility() {
                const passwordInput = document.getElementById('password');
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                } else {
                    passwordInput.type = 'password';
                }
            }

            document.getElementById('profileForm').addEventListener('submit', function (event) {
                event.preventDefault();
                // Handle form submission here
                console.log('Form submitted');
            });

            document.getElementById('cancelBtn').addEventListener('click', function () {
                // Handle cancel button click here
                console.log('Cancel button clicked');
            });
        </script>
    </body>
    <footer>
        <p>&copy; 2024 Sekolah Kebangsaan Bukit Damansara. All rights reserved.</p>
    </footer>

</html>
