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
import java.sql.Time;
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

            String checkInTime = request.getParameter("checkInTime_" + requestID);
            String checkOutTime = request.getParameter("checkOutTime_" + requestID);

            String selectQuery = "SELECT * FROM record WHERE requestID = ?";
            PreparedStatement selectStatement = connection.prepareStatement(selectQuery);
            selectStatement.setInt(1, requestID);
            ResultSet resultSet = selectStatement.executeQuery();

            if (resultSet.next()) {
                // Record exists, update it
                String updateQuery = "UPDATE record SET checkInTime = ?, checkOutTime = ? WHERE requestID = ?";
                PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
                updateStatement.setTime(1, checkInTime != null && !checkInTime.isEmpty() ? Time.valueOf(checkInTime + ":00") : null);
                updateStatement.setTime(2, checkOutTime != null && !checkOutTime.isEmpty() ? Time.valueOf(checkOutTime + ":00") : null);
                updateStatement.setInt(3, requestID);
                updateStatement.executeUpdate();
                updateStatement.close();
            } else {
                // Record does not exist, insert it
                String insertQuery = "INSERT INTO record (requestID, checkInTime, checkOutTime) VALUES (?, ?, ?)";
                PreparedStatement insertStatement = connection.prepareStatement(insertQuery);
                insertStatement.setInt(1, requestID);
                insertStatement.setTime(2, checkInTime != null && !checkInTime.isEmpty() ? Time.valueOf(checkInTime + ":00") : null);
                insertStatement.setTime(3, checkOutTime != null && !checkOutTime.isEmpty() ? Time.valueOf(checkOutTime + ":00") : null);
                insertStatement.executeUpdate();
                insertStatement.close();
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

        response.sendRedirect("visitorlist.jsp");
    }
}
