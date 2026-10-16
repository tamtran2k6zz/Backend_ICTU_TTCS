package com.codegym.dao;

import com.codegym.model.User;

import java.util.List;

/**
 * Declares JDBC data-access operations for user records.
 */
public interface IUserDAO {

    /** Declares insertion of a user record. */
    void insertUser(User user) throws Exception;

    /** Declares retrieval of one user by identifier. */
    User selectUser(int id);

    /** Declares retrieval of all user records. */
    List<User> selectAllUsers();

    /** Declares deletion of a user by identifier. */
    boolean deleteUser(int id) throws Exception;

    /** Declares update of a user record. */
    boolean updateUser(User user) throws Exception;
}
