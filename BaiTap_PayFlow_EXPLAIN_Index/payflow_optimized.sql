USE payflow_db;

-- 1. Plan cu, truoc khi tao index. EXPLAIN khong chay truy van tong tien.
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND YEAR(created_at) = 2026
  AND MONTH(created_at) = 6;

-- 2. Equality truoc, range sau. Chi tao index mot lan.
CREATE INDEX idx_type_date ON Transactions(transaction_type, created_at);
ANALYZE TABLE Transactions;

-- 3. Plan moi: khoang nua mo giu dung bien thang.
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';

-- 4. Bao cao thang 6/2026: giu SUM va DECIMAL nhu truy van goc.
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';

-- 5. Doi chieu gia tri tai cung mot snapshot, khong bi lech do ghi dong thoi.
SELECT legacy.total_deposit AS legacy_total,
       optimized.total_deposit AS optimized_total,
       legacy.total_deposit <=> optimized.total_deposit AS totals_match
FROM (
    SELECT SUM(amount) AS total_deposit
    FROM Transactions
    WHERE transaction_type = 'DEPOSIT'
      AND YEAR(created_at) = 2026 AND MONTH(created_at) = 6
) AS legacy
CROSS JOIN (
    SELECT SUM(amount) AS total_deposit
    FROM Transactions
    WHERE transaction_type = 'DEPOSIT'
      AND created_at >= '2026-06-01 00:00:00'
      AND created_at < '2026-07-01 00:00:00'
) AS optimized;

-- MySQL >= 8.0.18: bo comment de do thoi gian; lenh nay THUC SU chay truy van.
-- EXPLAIN ANALYZE
-- SELECT SUM(amount) FROM Transactions
-- WHERE transaction_type = 'DEPOSIT'
--   AND created_at >= '2026-06-01 00:00:00'
--   AND created_at < '2026-07-01 00:00:00';
