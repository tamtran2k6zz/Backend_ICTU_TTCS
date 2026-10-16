package com.codegym.service;

import com.codegym.model.Customer;

import java.util.List;

/**
 * Declares customer-management operations for the service layer.
 */
public interface CustomerService {

    /** Declares retrieval of all customers. */
    List<Customer> findAll();

    /** Declares creation of a customer. */
    void save(Customer customer);

    /** Declares retrieval of a customer by identifier. */
    Customer findById(int id);

    /** Declares replacement of a customer's information. */
    void update(int id, Customer customer);

    /** Declares removal of a customer by identifier. */
    void remove(int id);
}
