# [Bài tập] Truy vấn dữ liệu với CSDL Quản lý sinh viên

## Cách chạy

1. Sử dụng CSDL `QuanLySinhVien` của bài trước. Nếu chưa có, chạy [create_tables.sql](../ThucHanh_ThemDuLieu_QuanLySinhVien/create_tables.sql), rồi chạy [insert_data.sql](../ThucHanh_ThemDuLieu_QuanLySinhVien/insert_data.sql) một lần trên các bảng rỗng.
2. Mở [student_queries.sql](student_queries.sql) trong MySQL Workbench và thực thi từng câu hoặc toàn bộ file.
3. Câu 4 cập nhật dữ liệu: chuyển các sinh viên có tên `Hung` sang lớp 2. Lớp này phải tồn tại để thỏa khóa ngoại. Nếu có nhiều sinh viên trùng tên, tất cả đều được cập nhật theo điều kiện đề bài.

Nếu Workbench báo lỗi 1175 do Safe Updates, bỏ chọn **SQL Editor → Safe Updates** trong Preferences, kết nối lại rồi thực thi câu UPDATE trong CSDL thực hành.

## Các yêu cầu và kết quả mong đợi

| Câu | Điều kiện | Kết quả với dữ liệu mẫu |
| --- | --- | --- |
| 1 | `StudentName LIKE 'h%'` | Hung, Hoa |
| 2 | `MONTH(StartDate) = 12` | A1, A2; B3 cũng xuất hiện nếu ngày nạp dữ liệu thuộc tháng 12 |
| 3 | `Credit BETWEEN 3 AND 5` | CF và HDJ, cùng Credit = 5 |
| 4 | `UPDATE ... SET ClassId = 2` | Hung thuộc lớp A2 |
| 5 | `ORDER BY Mark DESC, StudentName ASC` | Bảng bên dưới |

| StudentName | SubName | Mark |
| --- | --- | --- |
| Hung | C | 12 |
| Hoa | CF | 10 |
| Hung | CF | 8 |

`LIKE 'h%'` khớp cả `Hung` và `Hoa` nhờ collation `utf8mb4_unicode_ci` từ bài tạo CSDL. `BETWEEN` bao gồm 3 và 5. Câu cuối chỉ trả các bản ghi có điểm; khi điểm bằng nhau, sắp tên sinh viên tăng dần. Dữ liệu mẫu chưa có điểm trùng nhau.

Có thể kiểm tra câu cập nhật bằng:

```sql
SELECT StudentId, StudentName, ClassId
FROM Student
WHERE StudentName = 'Hung';
```

## Nộp bài

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/student-management-query-exercise/BaiTap_TruyVan_QuanLySinhVien
