USE demo_products_db;

-- 1. EXPLAIN truoc index: ca hai truy van co the quet bang.
EXPLAIN
SELECT * FROM Products WHERE productCode = 'P000500';

EXPLAIN
SELECT * FROM Products
WHERE productName = 'Product 00499' AND productPrice = 500.00;

-- 2. Them unique index va composite index theo yeu cau.
CREATE UNIQUE INDEX idx_product_code ON Products (productCode);
CREATE INDEX idx_product_name_price ON Products (productName, productPrice);
ANALYZE TABLE Products;

-- 3. So sanh plan sau index; xem possible_keys, key, type, rows, Extra.
EXPLAIN
SELECT * FROM Products WHERE productCode = 'P000500';

EXPLAIN
SELECT * FROM Products
WHERE productName = 'Product 00499' AND productPrice = 500.00;

-- 4. Tao, truy van, thay dinh nghia va xoa view.
CREATE OR REPLACE VIEW product_views AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

SELECT * FROM product_views ORDER BY productCode LIMIT 10;

CREATE OR REPLACE VIEW product_views AS
SELECT productCode, productName, productPrice, productStatus
FROM Products
WHERE productStatus = 1;

SELECT * FROM product_views ORDER BY productCode LIMIT 10;

DROP VIEW IF EXISTS product_views;
