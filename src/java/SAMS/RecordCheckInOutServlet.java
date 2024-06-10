/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package SAMS;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RecordCheckInOutServlet")
public class RecordCheckInOutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dbURL = "jdbc:mysql://localhost:3306/school_access_management";
        String dbUser = "admin";
        String dbPassword = "admin";
        Connection connection = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            String action = request.getParameter("action");
            String[] actionParts = action.split("_");
            String actionType = actionParts[0];
            int requestID = Integer.parseInt(actionParts[1]);

            String checkInTime = request.getParameter("checkInTime");
            String checkOutTime = request.getParameter("checkOutTime");

            String selectQuery = "SELECT * FROM record WHERE requestID = ?";
            PreparedStatement selectStatement = connection.prepareStatement(selectQuery);
            selectStatement.setInt(1, requestID);
            ResultSet resultSet = selectStatement.executeQuery();

            if (resultSet.next()) {
                // Record exists, update it
                if ("checkIn".equals(actionType)) {
                    String updateQuery = "UPDATE record SET checkinTime = ? WHERE requestID = ?";
                    PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
                    updateStatement.setString(1, checkInTime);
                    updateStatement.setInt(2, requestID);
                    updateStatement.executeUpdate();
                    updateStatement.close();
                } else if ("checkOut".equals(actionType)) {
                    String updateQuery = "UPDATE record SET checkoutTime = ? WHERE requestID = ?";
                    PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
                    updateStatement.setString(1, checkOutTime);
                    updateStatement.setInt(2, requestID);
                    updateStatement.executeUpdate();
                    updateStatement.close();
                }
            } else {
                // Record does not exist, insert it
                if ("checkIn".equals(actionType)) {
                    String insertQuery = "INSERT INTO record (requestID, checkinTime, securityID) VALUES (?, ?, ?)";
                    PreparedStatement insertStatement = connection.prepareStatement(insertQuery);
                    insertStatement.setInt(1, requestID);
                    insertStatement.setString(2, checkInTime);
                    insertStatement.setInt(3, Integer.parseInt(request.getParameter("securityID")));
                    insertStatement.executeUpdate();
                    insertStatement.close();
                } else if ("checkOut".equals(actionType)) {
                    String insertQuery = "INSERT INTO record (requestID, checkoutTime, securityID) VALUES (?, ?, ?)";
                    PreparedStatement insertStatement = connection.prepareStatement(insertQuery);
                    insertStatement.setInt(1, requestID);
                    insertStatement.setString(2, checkOutTime);
                    insertStatement.setInt(3, Integer.parseInt(request.getParameter("securityID")));
                    insertStatement.executeUpdate();
                    insertStatement.close();
                }
            }

            resultSet.close();
            selectStatement.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Redirect back to visitorlist.jsp
        response.sendRedirect("visitorlist.jsp");
    }

}
