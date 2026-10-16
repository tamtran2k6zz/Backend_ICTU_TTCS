-- [Bài tập] Luyện tập các hàm thông dụng trong SQL
USE QuanLySinhVien;

-- 1. Môn có Credit lớn nhất, giữ tất cả trường hợp đồng hạng.
SELECT SubId, SubName, Credit, Status
FROM Subject
WHERE Credit = (SELECT MAX(Credit) FROM Subject)
ORDER BY SubId;

-- 2. Môn có điểm thi cao nhất trong bảng Mark, giữ các môn đồng hạng.
SELECT DISTINCT S.SubId, S.SubName, S.Credit, S.Status
FROM Subject AS S
JOIN Mark AS M ON M.SubId = S.SubId
WHERE M.Mark = (SELECT MAX(Mark) FROM Mark)
ORDER BY S.SubId;

-- 3. Điểm trung bình mỗi sinh viên, sắp xếp giảm dần.
SELECT S.StudentId, S.StudentName, AVG(M.Mark) AS AverageMark
FROM Student AS S
JOIN Mark AS M ON M.StudentId = S.StudentId
GROUP BY S.StudentId, S.StudentName
ORDER BY AverageMark DESC, S.StudentId ASC;
