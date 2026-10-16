-- Tao CSDL demo rieng voi 1.000 san pham de so sanh EXPLAIN.
-- Chay mot lan tren database moi; khong xoa database/bang dang ton tai.
CREATE DATABASE IF NOT EXISTS demo_products_db
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE demo_products_db;

CREATE TABLE IF NOT EXISTS Products (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(30) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(10,2) NOT NULL,
    productAmount INT NOT NULL DEFAULT 0,
    productDescription TEXT,
    productStatus TINYINT(1) NOT NULL DEFAULT 1
) ENGINE = InnoDB;

INSERT INTO Products
    (productCode, productName, productPrice, productAmount, productDescription, productStatus)
WITH digits AS (
    SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
    UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
    UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
), numbers AS (
    SELECT a.d + 10*b.d + 100*c.d AS n
    FROM digits AS a CROSS JOIN digits AS b CROSS JOIN digits AS c
)
SELECT CONCAT('P', LPAD(n + 1, 6, '0')),
       CONCAT('Product ', LPAD(n, 5, '0')),
       CAST(MOD(n, 500) + 1 AS DECIMAL(10,2)),
       MOD(n, 1000),
       CONCAT('Demo product description ', n),
       IF(MOD(n, 10) = 0, 0, 1)
FROM numbers
WHERE n < 1000;
