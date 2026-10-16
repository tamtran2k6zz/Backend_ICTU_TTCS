-- Tao bo demo rieng 100.000 log. Chay mot lan tren CSDL moi.
CREATE DATABASE IF NOT EXISTS smartfactory_db
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smartfactory_db;

CREATE TABLE SensorLogs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    recorded_at DATETIME NOT NULL,
    temperature DECIMAL(5,2),
    humidity DECIMAL(5,2),
    status VARCHAR(20)
) ENGINE = InnoDB;

INSERT INTO SensorLogs (sensor_id, recorded_at, temperature, humidity, status)
WITH digits AS (
    SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
    UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
    UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
), numbers AS (
    SELECT a.d + 10*b.d + 100*c.d + 1000*d.d + 10000*e.d AS n
    FROM digits AS a CROSS JOIN digits AS b CROSS JOIN digits AS c
    CROSS JOIN digits AS d CROSS JOIN digits AS e
)
SELECT MOD(n, 10000) + 1,
       DATE_ADD('2026-06-01 00:00:00', INTERVAL n MINUTE),
       CAST(20 + MOD(n, 1500) / 100.0 AS DECIMAL(5,2)),
       CAST(30 + MOD(n * 7, 7000) / 100.0 AS DECIMAL(5,2)),
       ELT(MOD(n, 3) + 1, 'NORMAL', 'WARNING', 'CRITICAL')
FROM numbers;

-- Index legacy bao phu: lam truy van Dashboard covering nhung ton dung luong.
CREATE INDEX idx_fat_covering
    ON SensorLogs(sensor_id, recorded_at, temperature, humidity, status);
ANALYZE TABLE SensorLogs;
