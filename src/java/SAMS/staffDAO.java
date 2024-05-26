/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package SAMS;

import java.sql.*;

public class staffDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/school_access_management";
    private String jdbcUsername = "admin";
    private String jdbcPassword = "admin";
    private Connection jdbcConnection;

    protected void connect() throws SQLException {
        if (jdbcConnection == null || jdbcConnection.isClosed()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                jdbcConnection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            } catch (ClassNotFoundException e) {
                throw new SQLException(e);
            }
        }
    }

    protected void disconnect() throws SQLException {
        if (jdbcConnection != null && !jdbcConnection.isClosed()) {
            jdbcConnection.close();
        }
    }

    public boolean insertTeacher(Teacher teacher) throws SQLException {
        String sql = "INSERT INTO teacher (teacherFirstName, teacherLastName, teacherEmail, teacherPassword, teacherPhone) VALUES (?, ?, ?, ?, ?)";
        connect();

        try (PreparedStatement statement = jdbcConnection.prepareStatement(sql)) {
            statement.setString(1, teacher.getFirstName());
            statement.setString(2, teacher.getLastName());
            statement.setString(3, teacher.getEmail());
            statement.setString(4, teacher.getPassword());
            statement.setString(5, teacher.getPhoneNumber());

            boolean rowInserted = statement.executeUpdate() > 0;
            return rowInserted;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }

    public boolean insertSecurity(Security security) throws SQLException {
        String sql = "INSERT INTO security (securityFirstName, securityLastName, securityEmail, securityPassword, securityPhone) VALUES (?, ?, ?, ?, ?)";
        connect();

        try (PreparedStatement statement = jdbcConnection.prepareStatement(sql)) {
            statement.setString(1, security.getFirstName());
            statement.setString(2, security.getLastName());
            statement.setString(3, security.getEmail());
            statement.setString(4, security.getPassword());
            statement.setString(5, security.getPhoneNumber());

            boolean rowInserted = statement.executeUpdate() > 0;
            return rowInserted;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }

    public boolean isUserExists(String email) throws SQLException {
    String sql = "SELECT COUNT(*) FROM teacher WHERE teacherEmail = ? UNION SELECT COUNT(*) FROM security WHERE securityEmail = ?";
    connect();

    try (PreparedStatement statement = jdbcConnection.prepareStatement(sql)) {
        statement.setString(1, email);
        statement.setString(2, email);
        ResultSet rs = statement.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0 || rs.getInt(2) > 0;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        disconnect();
    }
    return false;
}
}

