package com.codegym.service;

import com.codegym.model.Product;

import java.util.List;
import java.util.Optional;

public interface ProductService {
    List<Product> findAll();

    Optional<Product> findById(int id);

    Product create(Product product);

    boolean update(int id, Product product);

    boolean delete(int id);

    List<Product> searchByName(String name);
}
