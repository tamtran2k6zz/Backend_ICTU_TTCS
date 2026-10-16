package com.codegym.dao;

import com.codegym.model.User;

import java.sql.SQLException;
import java.util.List;

/** Defines CRUD, country-filter, and name-order operations for users. */
public interface IUserDAO {
    void insertUser(User user) throws SQLException;

    User selectUser(int id) throws SQLException;

    List<User> selectAllUsers(String country, String sortOrder) throws SQLException;

    boolean deleteUser(int id) throws SQLException;

    boolean updateUser(User user) throws SQLException;
}
