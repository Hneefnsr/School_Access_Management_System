/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package SAMS;

/**
 *
 * @author usee
 */
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getMethod().equals("POST")) {
            String firstName = request.getParameter("first-name");
            String lastName = request.getParameter("last-name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phoneNumber = request.getParameter("phone-number");

            User user = new User();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPassword(password);
            user.setPhoneNumber(phoneNumber);

            visitorDAO userDAO = new visitorDAO();
            // Check if the user already exists
            if (userDAO.isUserExists(email)) {
                // User already exists, redirect back to signup page with an error message
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Error: The account is already registered.");

                response.sendRedirect("signup.jsp"); // Replace with the actual signup page URL
            } else {
                // User does not exist, proceed with registration
                boolean success = userDAO.insertUser(user);

                if (success) {
                    HttpSession session = request.getSession();
                    session.setAttribute("visitorFirstName", firstName);
                    session.setAttribute("visitorLastName", lastName);
                    session.setAttribute("visitorEmail", email);
                    session.setAttribute("visitorPhone", phoneNumber);
                    session.setAttribute("visitorPassword", password);

                    // Set success message in the session
                    String successMessage = "Your account has been successfully created!";
                    session.setAttribute("successMessage", successMessage);

                    response.sendRedirect("login.jsp");
                } else {
                    response.getWriter().println("An error occurred while saving user data.");
                }
            }
        }
    }
}
