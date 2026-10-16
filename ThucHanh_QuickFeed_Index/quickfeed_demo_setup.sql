-- Tao bo demo doc lap 50.000 bai viet. Chay mot lan tren CSDL thuc hanh sach.
CREATE DATABASE IF NOT EXISTS quickfeed_db
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE quickfeed_db;

CREATE TABLE Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    post_type VARCHAR(10),
    is_visible BOOLEAN DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

INSERT INTO Posts (user_id, content, post_type, is_visible, created_at)
WITH digits AS (
    SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
    UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
    UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
), numbers AS (
    SELECT a.d + 10*b.d + 100*c.d + 1000*d.d + 10000*e.d AS n
    FROM digits AS a CROSS JOIN digits AS b CROSS JOIN digits AS c
    CROSS JOIN digits AS d CROSS JOIN digits AS e
)
SELECT MOD(n, 5000) + 1,
       CONCAT('Post ', n, ' ', REPEAT('quickfeed content ', 30)),
       ELT(MOD(n, 3) + 1, 'TEXT', 'IMAGE', 'VIDEO'),
       IF(MOD(n, 100) = 0, 0, 1),
       DATE_ADD('2024-01-01 00:00:00', INTERVAL n MINUTE)
FROM numbers
WHERE n < 50000;

-- Legacy indexes, bao gom ba index se loai bo va hai index se giu.
CREATE INDEX idx_user_id ON Posts(user_id);
CREATE INDEX idx_content ON Posts(content(255));
CREATE INDEX idx_post_type ON Posts(post_type);
CREATE INDEX idx_is_visible ON Posts(is_visible);
CREATE INDEX idx_created_at ON Posts(created_at);
ANALYZE TABLE Posts;
