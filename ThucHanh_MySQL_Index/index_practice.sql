USE index_practice_db;

-- 1. Truoc khi tao index customerName.
EXPLAIN
SELECT * FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- 2. Tao B-tree index tren cot tim kiem va xem lai plan.
CREATE INDEX idx_customerName ON customers (customerName);
ANALYZE TABLE customers;

EXPLAIN
SELECT * FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- 3. Composite index cho ten lien he; index dat first name truoc.
CREATE INDEX idx_full_name ON customers (contactFirstName, contactLastName);
ANALYZE TABLE customers;

-- OR cung mot cot duoc toi uu thanh cac range tren index.
EXPLAIN
SELECT * FROM customers
WHERE contactFirstName = 'Jean' OR contactFirstName = 'King';

-- 4. Xoa composite index de thuc hanh DROP INDEX (bo comment de chay).
-- ALTER TABLE customers DROP INDEX idx_full_name;
