-- FlashMart: chay mot lan tren CSDL flashmart_db chua co cac bang nay.
CREATE DATABASE IF NOT EXISTS flashmart_db
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE flashmart_db;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
) ENGINE = InnoDB;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
) ENGINE = InnoDB;

-- Giu mo hinh legacy: moi dong Orders la mot don hang, mot san pham.
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    INDEX idx_orders_customer (customer_id),
    INDEX idx_orders_product (product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
) ENGINE = InnoDB;

START TRANSACTION;
INSERT INTO Customers (customer_id, name)
VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO Products (product_id, product_name)
VALUES (101, 'Laptop'), (102, 'Mouse'), (103, 'Keyboard');
INSERT INTO Orders (order_id, customer_id, product_id)
VALUES (1001, 1, 101), (1002, 1, 102), (1003, 2, 101);
COMMIT;

-- Marketing: giu moi khach hang; dem khoa chinh khac NULL cua don hang.
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
FROM Customers AS c
LEFT JOIN Orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;

-- Kho van: chi giu san pham khong co don hang tuong ung (anti-join).
SELECT p.product_id, p.product_name
FROM Products AS p
LEFT JOIN Orders AS o ON p.product_id = o.product_id
WHERE o.order_id IS NULL
ORDER BY p.product_id;
