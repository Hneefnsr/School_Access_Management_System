<%-- 
    Document   : homepage
    Created on : Jan 6, 2024, 12:01:01 AM
    Author     : usee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Homepage</title>
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
                justify-content: space-between;
                align-items: center;
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

            .description-container {
                margin-top: 30px;
                display: flex;
                align-items: center;
                color:#ccccff;
            }

            .description {
                margin-left: 40px;
                max-width: 50%;
                font-size: 20px;
                /* Adjusted font-size */
                text-align: left;
                backdrop-filter: blur(1000px);
            }

            .buttons {
                margin-right: 30px;
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

            .system-name {
                font-family: 'Georgia', serif;
                font-size: 45px;
                text-align: center;
                margin-right: 4%;

            }

            .front {
                max-width: 45%;
                /* Adjusted max-width */
            }

            footer {
                color: gray;
                text-align: center;
                position: fixed;
                bottom: 0;
                width: 100%;
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
                <button class="button"><a href="signup.jsp" style="text-decoration: none; color: white;">Register</a></button>
                <button class="button"><a href="login.jsp" style="text-decoration: none; color: white;">Log In</a></button>
            </div>
        </header>

        <div class="description-container">
            <span class="description">
                <h1>Secure Access, Safe Education: Revolutionizing School Safety.</h1>
                <p>Elevating safety and control, the School Access Management System transforms access procedures, ensuring
                    the well-being of students, staff, and the educational atmosphere. With efficient check-ins, the system
                    not only reinforces security but also mitigates potential risks, fostering a protected and
                    well-regulated educational environment.</p>
            </span>
            <img src="png\skbd front.jpg" class="front">
        </div>

    </body>
    <footer>
        <p>&copy; 2024 Sekolah Kebangsaan Bukit Damansara. All rights reserved.</p>
    </footer>

</html>