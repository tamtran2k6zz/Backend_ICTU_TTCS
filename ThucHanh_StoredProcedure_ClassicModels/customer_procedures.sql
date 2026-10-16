-- Chay trong MySQL Workbench voi database classicmodels da nap du lieu.
USE classicmodels;

-- Tao va goi procedure liet ke tat ca khach hang.
DELIMITER //
DROP PROCEDURE IF EXISTS findAllCustomers//

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers;
END//
DELIMITER ;

CALL findAllCustomers();

-- MySQL khong co CREATE OR REPLACE PROCEDURE; xoa va tao lai de cap nhat.
DELIMITER //
DROP PROCEDURE IF EXISTS findAllCustomers//

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = 175;
END//
DELIMITER ;

CALL findAllCustomers();
