USE smartfactory_db;

-- 1. Dung luong va execution plan truoc khi toi uu.
SHOW TABLE STATUS LIKE 'SensorLogs';
SELECT TABLE_SCHEMA, TABLE_NAME,
       ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
       ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
       ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'SensorLogs';

EXPLAIN
SELECT temperature, humidity, status
FROM SensorLogs
WHERE sensor_id = 105 AND recorded_at >= '2026-06-20';

-- 2. Thay covering index bang index chi gom cot loc/sap xep.
ALTER TABLE SensorLogs DROP INDEX idx_fat_covering;
CREATE INDEX idx_lean_search ON SensorLogs(sensor_id, recorded_at);
ANALYZE TABLE SensorLogs;

-- 3. Do lai storage va kiem tra plan van dung range tren index.
SHOW TABLE STATUS LIKE 'SensorLogs';
SELECT TABLE_SCHEMA, TABLE_NAME,
       ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
       ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
       ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'SensorLogs';

EXPLAIN
SELECT temperature, humidity, status
FROM SensorLogs
WHERE sensor_id = 105 AND recorded_at >= '2026-06-20';

SHOW INDEX FROM SensorLogs;
