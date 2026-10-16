-- [Thực hành] Tạo CSDL trên MySQL Workbench
-- File: create_database.sql

-- 1. Tạo cơ sở dữ liệu cơ bản theo yêu cầu
CREATE DATABASE `my_database1`;

-- 2. Phiên bản tối ưu: kiểm tra tồn tại và cấu hình mã hóa UTF-8 hỗ trợ Tiếng Việt
CREATE DATABASE IF NOT EXISTS `my_database` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 3. Lệnh kiểm tra danh sách cơ sở dữ liệu hiện có
SHOW DATABASES;

-- 4. Chọn cơ sở dữ liệu để sử dụng cho các thao tác tiếp theo
USE `my_database1`;
