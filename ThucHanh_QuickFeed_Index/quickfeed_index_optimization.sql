USE quickfeed_db;

-- Kich thuoc truoc toi uu (MB); SHOW TABLE STATUS cung hien Index_length byte.
SHOW TABLE STATUS LIKE 'Posts';
SELECT TABLE_SCHEMA, TABLE_NAME,
       ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
       ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
       ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'Posts';

-- Chi bo ba index co gia tri thap / khong phu hop voi tim kiem van ban.
ALTER TABLE Posts DROP INDEX idx_content;
ALTER TABLE Posts DROP INDEX idx_post_type;
ALTER TABLE Posts DROP INDEX idx_is_visible;

ANALYZE TABLE Posts;

-- Kich thuoc sau toi uu.
SHOW TABLE STATUS LIKE 'Posts';
SELECT TABLE_SCHEMA, TABLE_NAME,
       ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
       ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
       ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'Posts';

-- Xac nhan con PK, idx_user_id va idx_created_at.
SHOW INDEX FROM Posts;
