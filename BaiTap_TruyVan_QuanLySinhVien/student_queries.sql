-- [Bài tập] Truy vấn dữ liệu với CSDL Quản lý sinh viên
USE QuanLySinhVien;

-- 1. Sinh viên có tên bắt đầu bằng ký tự 'h'.
-- Collation utf8mb4_unicode_ci của bài trước không phân biệt hoa/thường.
SELECT *
FROM Student
WHERE StudentName LIKE 'h%';

-- 2. Lớp học bắt đầu vào tháng 12, không giới hạn năm.
SELECT *
FROM Class
WHERE MONTH(StartDate) = 12;

-- 3. Môn học có Credit từ 3 đến 5, bao gồm hai đầu mút.
SELECT *
FROM Subject
WHERE Credit BETWEEN 3 AND 5;

-- 4. Chuyển sinh viên tên Hung sang lớp có ClassID = 2.
UPDATE Student
SET ClassId = 2
WHERE StudentName = 'Hung';

-- 5. Điểm giảm dần; nếu bằng điểm, tên sinh viên tăng dần.
SELECT S.StudentName, Sub.SubName, M.Mark
FROM Student AS S
JOIN Mark AS M ON S.StudentId = M.StudentId
JOIN Subject AS Sub ON M.SubId = Sub.SubId
ORDER BY M.Mark DESC, S.StudentName ASC;
