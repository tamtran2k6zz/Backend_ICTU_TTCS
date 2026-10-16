-- Chay tren CSDL classicmodels da nap du lieu.
USE classicmodels;

-- Tao view gom ma, ten va so dien thoai khach hang.
CREATE OR REPLACE VIEW customer_views AS
SELECT customerNumber, customerName, phone
FROM customers;

-- Doc du lieu thong qua view.
SELECT *
FROM customer_views
ORDER BY customerNumber;

-- Thay dinh nghia view: chi hien thi khach hang o Nantes.
CREATE OR REPLACE VIEW customer_views AS
SELECT customerNumber, customerName, contactFirstName,
       contactLastName, phone
FROM customers
WHERE city = 'Nantes';

-- Kiem tra view sau khi thay dinh nghia.
SELECT *
FROM customer_views
ORDER BY customerNumber;

-- Thuc hanh xoa view neu khong can nua (bo comment de chay).
-- DROP VIEW IF EXISTS customer_views;
