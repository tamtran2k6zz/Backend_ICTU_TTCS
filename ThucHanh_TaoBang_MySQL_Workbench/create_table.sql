-- [Thực hành] Tạo bảng trên MySQL Workbench
-- File: create_table.sql

-- Bước 1: Tạo cơ sở dữ liệu tên demo
CREATE DATABASE IF NOT EXISTS demo;

-- Bước 2: Sử dụng cơ sở dữ liệu demo
USE demo;

-- Bước 3: Tạo bảng Student với các trường thuộc tính theo đề bài
CREATE TABLE IF NOT EXISTS Student (
    id INT,
    name VARCHAR(200),
    age INT,
    country VARCHAR(50)
);

-- Bước 4: Kiểm tra thông tin cấu trúc bảng vừa tạo
DESCRIBE Student;

-- (Tùy chọn) Thêm dữ liệu mẫu kiểm thử
INSERT INTO Student (id, name, age, country) VALUES
(1, 'Nguyen Van A', 20, 'Vietnam'),
(2, 'John Doe', 22, 'USA');

-- Xem dữ liệu trong bảng Student
SELECT * FROM Student;
