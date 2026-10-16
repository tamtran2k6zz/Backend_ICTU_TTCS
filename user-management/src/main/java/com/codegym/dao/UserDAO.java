package com.codegym.dao;

import com.codegym.model.User;

import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * JDBC implementation of {@link IUserDAO} for a MySQL users table.
 */
public class UserDAO implements IUserDAO {
    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/demo?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";

    private static final String INSERT_USER =
            "INSERT INTO users (name, email, country) VALUES (?, ?, ?)";
    private static final String SELECT_USER_BY_ID =
            "SELECT id, name, email, country FROM users WHERE id = ?";
    private static final String SELECT_ALL_USERS =
            "SELECT id, name, email, country FROM users";
    private static final String DELETE_USER = "DELETE FROM users WHERE id = ?";
    private static final String UPDATE_USER =
            "UPDATE users SET name = ?, email = ?, country = ? WHERE id = ?";

    private final String jdbcUrl = setting("DB_URL", DEFAULT_URL);
    private final String jdbcUsername = setting("DB_USERNAME", "root");
    private final String jdbcPassword = setting("DB_PASSWORD", "");

    private String setting(String name, String defaultValue) {
        String value = System.getenv(name);
        return value == null || value.isBlank() ? defaultValue : value;
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
    }

    @Override
    public void insertUser(User user) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(INSERT_USER)) {
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getCountry());
            statement.executeUpdate();
        }
    }

    @Override
    public User selectUser(int id) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_USER_BY_ID)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? mapUser(resultSet) : null;
            }
        }
    }

    @Override
    public User getUserById(int id) throws SQLException {
        String call = "{CALL get_user_by_id(?)}";
        try (Connection connection = getConnection();
             CallableStatement statement = connection.prepareCall(call)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (!resultSet.next()) {
                    return null;
                }
                return new User(
                        id,
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("country"));
            }
        }
    }

    @Override
    public void insertUserStore(User user) throws SQLException {
        String call = "{CALL insert_user(?, ?, ?)}";
        try (Connection connection = getConnection();
             CallableStatement statement = connection.prepareCall(call)) {
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getCountry());
            statement.executeUpdate();
        }
    }

    @Override
    public List<User> selectAllUsers(String country, String sortOrder) throws SQLException {
        boolean filterByCountry = country != null && !country.isBlank();
        String direction = "DESC".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC";
        String sql = SELECT_ALL_USERS
                + (filterByCountry ? " WHERE country LIKE ?" : "")
                + " ORDER BY name " + direction + ", id ASC";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            if (filterByCountry) {
                statement.setString(1, "%" + country.trim() + "%");
            }
            try (ResultSet resultSet = statement.executeQuery()) {
                List<User> users = new ArrayList<>();
                while (resultSet.next()) {
                    users.add(mapUser(resultSet));
                }
                return users;
            }
        }
    }

    @Override
    public boolean deleteUser(int id) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_USER)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        }
    }

    @Override
    public boolean updateUser(User user) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_USER)) {
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getCountry());
            statement.setInt(4, user.getId());
            return statement.executeUpdate() > 0;
        }
    }

    private User mapUser(ResultSet resultSet) throws SQLException {
        return new User(
                resultSet.getInt("id"),
                resultSet.getString("name"),
                resultSet.getString("email"),
                resultSet.getString("country"));
    }
}
