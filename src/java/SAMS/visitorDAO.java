/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package SAMS;

/**
 *
 * @author usee
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class visitorDAO {

    private static final String dbUrl = "jdbc:mysql://localhost:3306/school_access_management";
    private static final String dbUsername = "admin";
    private static final String dbPassword = "admin";

    public boolean insertUser(User user) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            String sql = "INSERT INTO visitor (visitorFirstName, visitorLastName, visitorEmail, visitorPhone, visitorPassword) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, user.getFirstName());
            statement.setString(2, user.getLastName());
            statement.setString(3, user.getEmail());
            statement.setString(4, user.getPhoneNumber());
            statement.setString(5, user.getPassword());

            int rowsAffected = statement.executeUpdate();

            conn.close();

            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isUserExists(String email) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            String sql = "SELECT * FROM visitor WHERE visitorEmail = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, email);

            ResultSet resultSet = statement.executeQuery();

            boolean userExists = resultSet.next();

            conn.close();

            return userExists;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
