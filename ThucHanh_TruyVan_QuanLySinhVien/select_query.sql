-- [Thực hành] Truy vấn dữ liệu với CSDL Quản lý sinh viên
USE QuanLySinhVien;

-- 1. Hiển thị danh sách tất cả các học viên.
SELECT *
FROM Student;

-- 2. Hiển thị danh sách các học viên đang theo học.
SELECT *
FROM Student
WHERE Status = TRUE;

-- 3. Hiển thị các môn học có thời gian học nhỏ hơn 10 giờ.
SELECT *
FROM Subject
WHERE Credit < 10;

-- 4. Hiển thị danh sách học viên lớp A1.
SELECT S.StudentId, S.StudentName, C.ClassName
FROM Student AS S
JOIN Class AS C ON S.ClassId = C.ClassID
WHERE C.ClassName = 'A1';

-- 5. Hiển thị điểm môn CF của các học viên.
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student AS S
JOIN Mark AS M ON S.StudentId = M.StudentId
JOIN Subject AS Sub ON M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';
