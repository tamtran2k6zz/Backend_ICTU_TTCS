-- [Thực hành] Sử dụng các hàm thông dụng trong SQL
USE QuanLySinhVien;

-- 1. Số lượng sinh viên ở từng địa chỉ (bao gồm nhóm NULL nếu có).
SELECT Address, COUNT(StudentId) AS StudentCount
FROM Student
GROUP BY Address
ORDER BY Address;

-- 2. Điểm trung bình các môn đã có điểm của mỗi học viên.
SELECT S.StudentId, S.StudentName, AVG(M.Mark) AS AverageMark
FROM Student AS S
JOIN Mark AS M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
ORDER BY S.StudentId;

-- 3. Học viên có điểm trung bình lớn hơn 15.
SELECT S.StudentId, S.StudentName, AVG(M.Mark) AS AverageMark
FROM Student AS S
JOIN Mark AS M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(M.Mark) > 15
ORDER BY S.StudentId;

-- 4. Mọi học viên đồng hạng có điểm trung bình cao nhất.
SELECT S.StudentId, S.StudentName, AVG(M.Mark) AS AverageMark
FROM Student AS S
JOIN Mark AS M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(M.Mark) >= ALL (
    SELECT AVG(M2.Mark)
    FROM Mark AS M2
    GROUP BY M2.StudentId
)
ORDER BY S.StudentId;
