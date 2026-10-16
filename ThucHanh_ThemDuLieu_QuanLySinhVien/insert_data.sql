-- [Thực hành] Thêm dữ liệu vào CSDL quản lý sinh viên.
-- Chạy một lần khi bốn bảng đã được tạo và chưa có dữ liệu.
USE QuanLySinhVien;

START TRANSACTION;

INSERT INTO Class (ClassID, ClassName, StartDate, Status)
VALUES (1, 'A1', '2008-12-20', 1);
INSERT INTO Class (ClassID, ClassName, StartDate, Status)
VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO Class (ClassID, ClassName, StartDate, Status)
VALUES (3, 'B3', CURRENT_DATE(), 0);

INSERT INTO Student (StudentId, StudentName, Address, Phone, Status, ClassId)
VALUES (1, 'Hung', 'Ha Noi', '0912113113', 1, 1);
-- Bỏ cột Phone để sử dụng giá trị mặc định NULL.
INSERT INTO Student (StudentId, StudentName, Address, Status, ClassId)
VALUES (2, 'Hoa', 'Hai phong', 1, 1);
INSERT INTO Student (StudentId, StudentName, Address, Phone, Status, ClassId)
VALUES (3, 'Manh', 'HCM', '0123123123', 0, 2);

INSERT INTO Subject (SubId, SubName, Credit, Status)
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);

INSERT INTO Mark (MarkId, SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 1, 8, 1),
       (2, 1, 2, 10, 2),
       (3, 2, 1, 12, 1);

COMMIT;

SELECT ClassID, ClassName, StartDate, Status + 0 AS Status FROM Class ORDER BY ClassID;
SELECT StudentId, StudentName, Address, Phone, Status + 0 AS Status, ClassId
FROM Student ORDER BY StudentId;
SELECT SubId, SubName, Credit, Status + 0 AS Status FROM Subject ORDER BY SubId;
SELECT MarkId, SubId, StudentId, Mark, ExamTimes FROM Mark ORDER BY MarkId;
