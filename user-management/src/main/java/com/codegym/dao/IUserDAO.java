package com.codegym.dao;

import com.codegym.model.User;

import java.sql.SQLException;
import java.util.List;

/** Defines user operations, including stored-procedure-backed list, update, and delete methods. */
public interface IUserDAO {
    void insertUser(User user) throws SQLException;

    User selectUser(int id) throws SQLException;

    User getUserById(int id) throws SQLException;

    void insertUserStore(User user) throws SQLException;

    void addUserTransaction(User user, int[] permissionIds) throws SQLException;

    void insertUpdateWithoutTransaction() throws SQLException;

    void insertUpdateUseTransaction() throws SQLException;

    void insertUpdateUseTransactionWithFailure() throws SQLException;

    List<User> selectAllUsers(String country, String sortOrder) throws SQLException;

    boolean deleteUser(int id) throws SQLException;

    boolean updateUser(User user) throws SQLException;
}
