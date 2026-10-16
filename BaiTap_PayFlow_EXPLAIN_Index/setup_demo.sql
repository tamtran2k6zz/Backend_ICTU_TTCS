-- Du lieu mo phong 100,004 dong, khong phai 5 trieu giao dich that.
-- Chi chay mot lan tren CSDL thuc hanh chua co bang Transactions.
CREATE DATABASE IF NOT EXISTS payflow_db
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE payflow_db;
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20),
    created_at DATETIME
) ENGINE = InnoDB;

INSERT INTO Transactions (user_id, amount, transaction_type, created_at)
WITH digits AS (
    SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
    UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
    UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
)
SELECT MOD(n, 1000) + 1,
       CAST(MOD(n, 10000) / 100 AS DECIMAL(15,2)),
       CASE MOD(n, 3) WHEN 0 THEN 'DEPOSIT' WHEN 1 THEN 'WITHDRAW' ELSE 'TRANSFER' END,
       DATE_ADD('2020-01-01 00:00:00', INTERVAL n HOUR)
FROM (
    SELECT a.d + 10*b.d + 100*c.d + 1000*d.d + 10000*e.d AS n
    FROM digits AS a CROSS JOIN digits AS b CROSS JOIN digits AS c
    CROSS JOIN digits AS d CROSS JOIN digits AS e
) AS numbers;

-- Kiem tra bien thang va loai giao dich: chi dong 20.00 duoc tinh.
INSERT INTO Transactions (user_id, amount, transaction_type, created_at) VALUES
(1001, 10.00, 'DEPOSIT', '2026-05-31 23:59:59'),
(1001, 20.00, 'DEPOSIT', '2026-06-01 00:00:00'),
(1001, 30.00, 'DEPOSIT', '2026-07-01 00:00:00'),
(1001, 40.00, 'WITHDRAW', '2026-06-15 12:00:00');
ANALYZE TABLE Transactions;
