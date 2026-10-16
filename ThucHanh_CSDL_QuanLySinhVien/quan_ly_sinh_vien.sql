-- [Thực hành] Tạo CSDL quản lý sinh viên
-- Cơ sở dữ liệu: QuanLySinhVien
-- File: quan_ly_sinh_vien.sql

-- Bước 1: Tạo cơ sở dữ liệu có tên là QuanLySinhVien
CREATE DATABASE IF NOT EXISTS QuanLySinhVien
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Bước 2: Chọn Database QuanLySinhVien để thao tác
USE QuanLySinhVien;

-- Bước 3: Tạo bảng Class với các trường ClassId, ClassName, StartDate, Status
CREATE TABLE IF NOT EXISTS Class (
    ClassID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME NOT NULL,
    Status BIT
);

-- Bước 4: Tạo bảng Student với các thuộc tính và khóa ngoại liên kết tới bảng Class
CREATE TABLE IF NOT EXISTS Student (
    StudentId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    Phone VARCHAR(20),
    Status BIT,
    ClassId INT NOT NULL,
    CONSTRAINT fk_student_class FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);

-- Bước 5: Tạo bảng Subject với các ràng buộc CHECK và DEFAULT
CREATE TABLE IF NOT EXISTS Subject (
    SubId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit TINYINT NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status BIT DEFAULT 1
);

-- Bước 6: Tạo bảng Mark với ràng buộc CHECK, DEFAULT, UNIQUE và 2 khóa ngoại
CREATE TABLE IF NOT EXISTS Mark (
    MarkId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId INT NOT NULL,
    StudentId INT NOT NULL,
    Mark FLOAT DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    CONSTRAINT fk_mark_subject FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    CONSTRAINT fk_mark_student FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

-- -----------------------------------------------------------------------------
-- PHẦN DỮ LIỆU MẪU KIỂM THỬ (TEST DATA)
-- -----------------------------------------------------------------------------

-- Chèn dữ liệu lớp học
INSERT INTO Class (ClassName, StartDate, Status) VALUES
('A1', '2023-12-20', 1),
('A2', '2023-12-22', 1),
('B3', current_date(), 0);

-- Chèn dữ liệu sinh viên
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId) VALUES
('Hung', 'Ha Noi', '0912111111', 1, 1),
('Hoa', 'Hai phong', NULL, 1, 1),
('Manh', 'HCM', '0123123123', 0, 2);

-- Chèn dữ liệu môn học
INSERT INTO Subject (SubName, Credit, Status) VALUES
('CF', 5, 1),
('C', 6, 1),
('HDJ', 5, 1),
('RDBMS', 10, 1);

-- Chèn dữ liệu điểm thi
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes) VALUES
(1, 1, 8, 1),
(1, 2, 10, 2),
(2, 1, 12, 1);

-- Truy vấn kiểm tra bảng điểm sinh viên
SELECT 
    s.StudentID,
    s.StudentName,
    c.ClassName,
    sub.SubName,
    m.Mark,
    m.ExamTimes
FROM Student s
JOIN Class c ON s.ClassId = c.ClassID
JOIN Mark m ON s.StudentID = m.StudentID
JOIN Subject sub ON m.SubId = sub.SubId;
