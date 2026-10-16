-- Chay voi database classicmodels da duoc nap du lieu.
USE classicmodels;

-- IN: nhan ma khach hang va tra thong tin khach.
DELIMITER //
DROP PROCEDURE IF EXISTS getCusById//
CREATE PROCEDURE getCusById(IN cusNum INT)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = cusNum;
END//

-- OUT: tra so khach hang theo thanh pho.
DROP PROCEDURE IF EXISTS GetCustomersCountByCity//
CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END//

-- INOUT: doc gia tri counter hien tai, cong inc roi ghi lai cho caller.
DROP PROCEDURE IF EXISTS SetCounter//
CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END//
DELIMITER ;

-- Goi IN; classicmodels sample co khach hang 175.
CALL getCusById(175);

-- Goi OUT bang user variable va doc ket qua sau CALL.
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total AS customers_in_lyon;

-- Goi INOUT nhieu lan; gia tri duoc giu trong cung session.
SET @counter = 1;
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 5);
SELECT @counter AS counter_result; -- 8
