-- [Thực hành] Xoá CSDL trên MySQL Workbench
-- File: drop_database.sql

-- 1. Câu lệnh xoá cơ sở dữ liệu cơ bản theo yêu cầu
DROP DATABASE `my_database`;

-- 2. Câu lệnh an toàn (Best Practice): kiểm tra tồn tại trước khi xoá tránh lỗi runtime
DROP DATABASE IF EXISTS `my_database`;

-- 3. Xoá cơ sở dữ liệu my_database1 đã tạo ở bài trước nếu cần dọn dẹp
DROP DATABASE IF EXISTS `my_database1`;

-- 4. Kiểm tra lại danh sách các cơ sở dữ liệu sau khi xoá
SHOW DATABASES;
