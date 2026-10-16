-- Bo du lieu doc lap 100,001 khach hang de quan sat EXPLAIN.
-- Chi chay mot lan tren instance thuc hanh sach.
CREATE DATABASE IF NOT EXISTS index_practice_db
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE index_practice_db;

CREATE TABLE customers (
    customerNumber INT NOT NULL PRIMARY KEY,
    customerName VARCHAR(50) NOT NULL,
    contactFirstName VARCHAR(50) NOT NULL,
    contactLastName VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

INSERT INTO customers (customerNumber, customerName, contactFirstName, contactLastName)
WITH digits AS (
    SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
    UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
    UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
), numbers AS (
    SELECT a.d + 10*b.d + 100*c.d + 1000*d.d + 10000*e.d AS n
    FROM digits AS a CROSS JOIN digits AS b CROSS JOIN digits AS c
    CROSS JOIN digits AS d CROSS JOIN digits AS e
)
SELECT n + 1,
       CONCAT('Customer ', LPAD(n + 1, 6, '0')),
       ELT(MOD(n, 4) + 1, 'Jean', 'King', 'Alex', 'Taylor'),
       ELT(MOD(FLOOR(n / 4), 4) + 1, 'King', 'Jean', 'Smith', 'Lee')
FROM numbers;

INSERT INTO customers (customerNumber, customerName, contactFirstName, contactLastName)
VALUES (100001, 'Land of Toys Inc.', 'Julie', 'King');
ANALYZE TABLE customers;
