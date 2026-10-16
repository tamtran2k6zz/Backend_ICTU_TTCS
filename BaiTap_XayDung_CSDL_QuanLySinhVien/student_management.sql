-- [Bài tập] Xây dựng cơ sở dữ liệu quản lý sinh viên
-- File: student_management.sql

-- 1. Khởi tạo CSDL student_management nếu chưa tồn tại
CREATE DATABASE IF NOT EXISTS `student_management`
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `student_management`;

-- 2. Tạo bảng Student (kế thừa từ bài thực hành trước)
CREATE TABLE IF NOT EXISTS `Student` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `age` INT,
    `country` VARCHAR(50)
);

-- 3. Tạo bảng Class (Lớp học)
CREATE TABLE IF NOT EXISTS `Class` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL
);

-- 4. Tạo bảng Teacher (Giáo viên)
CREATE TABLE IF NOT EXISTS `Teacher` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(150) NOT NULL,
    `age` INT,
    `country` VARCHAR(100)
);

-- 5. Xem thông tin cấu trúc các bảng
DESCRIBE `Class`;
DESCRIBE `Teacher`;

-- 6. Dữ liệu mẫu kiểm thử
INSERT INTO `Class` (`name`) VALUES 
('C0124G1'), 
('C0224I1');

INSERT INTO `Teacher` (`name`, `age`, `country`) VALUES 
('Thầy Nguyễn Văn Nam', 35, 'Việt Nam'), 
('Cô Trần Thị Hương', 30, 'Việt Nam');

-- 7. Truy vấn kiểm tra
SELECT * FROM `Class`;
SELECT * FROM `Teacher`;
