/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package SAMS;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/AddStaffServlet")
public class AddStaffServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String firstName = request.getParameter("first-name");
        String lastName = request.getParameter("last-name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phone-number");
        String role = request.getParameter("role");

        staffDAO staffDAO = new staffDAO();

        try {
            if (staffDAO.isUserExists(email)) {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Error: The account is already registered.");
                response.sendRedirect("addStaff.jsp");
            } else {
                boolean success = false;
                
                if (role.equalsIgnoreCase("teacher")) {
                    Teacher teacher = new Teacher();
                    teacher.setFirstName(firstName);
                    teacher.setLastName(lastName);
                    teacher.setEmail(email);
                    teacher.setPassword(password);
                    teacher.setPhoneNumber(phoneNumber);
                    try {
                        success = staffDAO.insertTeacher(teacher);
                    } catch (SQLException ex) {
                        Logger.getLogger(AddStaffServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else if (role.equalsIgnoreCase("security")) {
                    Security security = new Security();
                    security.setFirstName(firstName);
                    security.setLastName(lastName);
                    security.setEmail(email);
                    security.setPassword(password);
                    security.setPhoneNumber(phoneNumber);
                    try {
                        success = staffDAO.insertSecurity(security);
                    } catch (SQLException ex) {
                        Logger.getLogger(AddStaffServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                
                if (success) {
                    HttpSession session = request.getSession();
                    session.setAttribute("staffFirstName", firstName);
                    session.setAttribute("staffLastName", lastName);
                    session.setAttribute("staffEmail", email);
                    session.setAttribute("staffPhone", phoneNumber);
                    session.setAttribute("staffPassword", password);
                    
                    String successMessage = "The staff member has been successfully added!";
                    session.setAttribute("successMessage", successMessage);
                    
                    response.sendRedirect("stafflist.jsp");
                } else {
                    response.getWriter().println("An error occurred while saving staff data.");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddStaffServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}


