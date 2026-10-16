# [Thực hành] Truy vấn dữ liệu với CSDL Quản lý sinh viên

Luyện tập `SELECT`, điều kiện `WHERE` và phép nối `JOIN` trong MySQL.

## Cách chạy

1. Sử dụng CSDL `QuanLySinhVien` đã tạo và thêm dữ liệu ở bài trước. Nếu chưa có, chạy [create_tables.sql](../ThucHanh_ThemDuLieu_QuanLySinhVien/create_tables.sql), sau đó chạy [insert_data.sql](../ThucHanh_ThemDuLieu_QuanLySinhVien/insert_data.sql) một lần trên các bảng rỗng.
2. Mở [select_query.sql](select_query.sql) trong MySQL Workbench.
3. Chạy toàn bộ file để xem 5 bảng kết quả, hoặc chọn từng câu truy vấn và thực thi.

Các câu truy vấn chỉ đọc dữ liệu. `Status = TRUE` tương ứng với học viên đang học; `Credit` là trường được dùng để lọc thời gian học theo đề bài.

## Kết quả mong đợi với dữ liệu bài trước

| Câu | Yêu cầu | Kết quả |
| --- | --- | --- |
| 1 | Tất cả học viên | 3 học viên: Hung, Hoa, Manh |
| 2 | Học viên đang theo học | 2 học viên: Hung, Hoa |
| 3 | Môn học có Credit < 10 | CF (5), C (6), HDJ (5) |
| 4 | Học viên lớp A1 | Hung và Hoa, cùng lớp A1 |
| 5 | Điểm môn CF | Hung: 8; Hoa: 10 |

Thứ tự các dòng không được bảo đảm khi câu truy vấn không có `ORDER BY`.

## Nộp bài

Link thư mục bài thực hành trên GitHub:

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/student-management-select-query/ThucHanh_TruyVan_QuanLySinhVien
