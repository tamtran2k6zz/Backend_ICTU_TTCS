package com.codegym.dao;

import com.codegym.model.User;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
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
    private static final String LIST_USERS = "{CALL list_users(?, ?)}";
    private static final String DELETE_USER = "{CALL delete_user(?, ?)}";
    private static final String UPDATE_USER = "{CALL update_user(?, ?, ?, ?, ?)}";
    private static final String SQL_INSERT_EMPLOYEE =
            "INSERT INTO Employee (name, salary, created_Date) VALUES (?, ?, ?)";
    private static final String SQL_UPDATE_EMPLOYEE =
            "UPDATE Employee SET salary = ? WHERE name = ?";
    private static final String SQL_TABLE_CREATE_EMPLOYEE = "CREATE TABLE Employee ("
            + "id INT NOT NULL AUTO_INCREMENT, "
            + "name VARCHAR(120) NOT NULL, "
            + "salary DECIMAL(15, 2) NOT NULL, "
            + "created_Date TIMESTAMP, "
            + "PRIMARY KEY (id))";
    private static final String SQL_TABLE_DROP_EMPLOYEE = "DROP TABLE IF EXISTS Employee";

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
    public void addUserTransaction(User user, int[] permissionIds) throws SQLException {
        try (Connection connection = getConnection()) {
            connection.setAutoCommit(false);
            try {
                int userId;
                try (PreparedStatement statement = connection.prepareStatement(
                        INSERT_USER, java.sql.Statement.RETURN_GENERATED_KEYS)) {
                    statement.setString(1, user.getName());
                    statement.setString(2, user.getEmail());
                    statement.setString(3, user.getCountry());
                    statement.executeUpdate();

                    try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                        if (!generatedKeys.next()) {
                            throw new SQLException("MySQL did not return the generated user ID.");
                        }
                        userId = generatedKeys.getInt(1);
                    }
                }

                user.setId(userId);
                if (permissionIds != null && permissionIds.length > 0) {
                    try (PreparedStatement statement = connection.prepareStatement(
                            "INSERT INTO user_permission (user_id, permission_id) VALUES (?, ?)")) {
                        for (int permissionId : permissionIds) {
                            statement.setInt(1, userId);
                            statement.setInt(2, permissionId);
                            statement.addBatch();
                        }
                        statement.executeBatch();
                    }
                }

                connection.commit();
            } catch (SQLException failure) {
                rollback(connection, failure);
                throw failure;
            } catch (RuntimeException failure) {
                rollback(connection, failure);
                throw failure;
            }
        }
    }

    @Override
    public void insertUpdateWithoutTransaction() {
        try (Connection connection = getConnection();
             Statement statement = connection.createStatement()) {
            // Keep JDBC's default auto-commit enabled: each successful INSERT is saved immediately.
            statement.execute(SQL_TABLE_DROP_EMPLOYEE);
            statement.execute(SQL_TABLE_CREATE_EMPLOYEE);

            try (PreparedStatement insert = connection.prepareStatement(SQL_INSERT_EMPLOYEE);
                 PreparedStatement update = connection.prepareStatement(SQL_UPDATE_EMPLOYEE)) {
                insert.setString(1, "Quynh");
                insert.setBigDecimal(2, new BigDecimal("10.00"));
                insert.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
                insert.executeUpdate();

                insert.setString(1, "Ngan");
                insert.setBigDecimal(2, new BigDecimal("20.00"));
                insert.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
                insert.executeUpdate();

                // Intentional parameter-index mistake from the exercise. Parameter 1 stays unset,
                // so executeUpdate throws after the two auto-committed INSERT statements.
                update.setBigDecimal(2, new BigDecimal("999.99"));
                update.setString(2, "Quynh");
                update.executeUpdate();
            }
        } catch (SQLException exception) {
            System.out.println("Đã bắt được lỗi trong quá trình thực thi SQL:");
            exception.printStackTrace();
        }
    }

    @Override
    public void insertUpdateUseTransaction() throws SQLException {
        executeEmployeeTransaction(false);
    }

    @Override
    public void insertUpdateUseTransactionWithFailure() throws SQLException {
        executeEmployeeTransaction(true);
    }

    private void executeEmployeeTransaction(boolean failUpdate) throws SQLException {
        try (Connection connection = getConnection()) {
            // MySQL DDL implicitly commits, so reset the demo table before opening the transaction.
            try (Statement statement = connection.createStatement()) {
                statement.execute(SQL_TABLE_DROP_EMPLOYEE);
                statement.execute(SQL_TABLE_CREATE_EMPLOYEE);
            }

            connection.setAutoCommit(false);
            try (PreparedStatement insert = connection.prepareStatement(SQL_INSERT_EMPLOYEE);
                 PreparedStatement update = connection.prepareStatement(SQL_UPDATE_EMPLOYEE)) {
                insert.setString(1, "Quynh");
                insert.setBigDecimal(2, new BigDecimal("10.00"));
                insert.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
                insert.executeUpdate();

                insert.setString(1, "Ngan");
                insert.setBigDecimal(2, new BigDecimal("20.00"));
                insert.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
                insert.executeUpdate();

                if (failUpdate) {
                    // Intentional missing parameter 1 to demonstrate rollback after both INSERTs.
                    update.setBigDecimal(2, new BigDecimal("999.99"));
                    update.setString(2, "Quynh");
                } else {
                    update.setBigDecimal(1, new BigDecimal("999.99"));
                    update.setString(2, "Quynh");
                }
                update.executeUpdate();
                connection.commit();
            } catch (SQLException | RuntimeException failure) {
                rollback(connection, failure);
                throw failure;
            }
        }
    }

    @Override
    public List<User> selectAllUsers(String country, String sortOrder) throws SQLException {
        String direction = "DESC".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC";
        try (Connection connection = getConnection();
             CallableStatement statement = connection.prepareCall(LIST_USERS)) {
            statement.setString(1, country == null || country.isBlank() ? null : country.trim());
            statement.setString(2, direction);
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
             CallableStatement statement = connection.prepareCall(DELETE_USER)) {
            statement.setInt(1, id);
            statement.registerOutParameter(2, java.sql.Types.INTEGER);
            statement.execute();
            return statement.getInt(2) > 0;
        }
    }

    @Override
    public boolean updateUser(User user) throws SQLException {
        try (Connection connection = getConnection();
             CallableStatement statement = connection.prepareCall(UPDATE_USER)) {
            statement.setInt(1, user.getId());
            statement.setString(2, user.getName());
            statement.setString(3, user.getEmail());
            statement.setString(4, user.getCountry());
            statement.registerOutParameter(5, java.sql.Types.INTEGER);
            statement.execute();
            return statement.getInt(5) > 0;
        }
    }

    private User mapUser(ResultSet resultSet) throws SQLException {
        return new User(
                resultSet.getInt("id"),
                resultSet.getString("name"),
                resultSet.getString("email"),
                resultSet.getString("country"));
    }

    private void rollback(Connection connection, Throwable originalFailure) {
        try {
            connection.rollback();
        } catch (SQLException rollbackFailure) {
            originalFailure.addSuppressed(rollbackFailure);
        }
    }
}
