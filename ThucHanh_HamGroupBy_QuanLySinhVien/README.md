# [Thực hành] Sử dụng các hàm thông dụng trong SQL

Thực hành `COUNT`, `AVG`, `GROUP BY` và `HAVING` trên CSDL `QuanLySinhVien`.

## Cách chạy

1. Dùng CSDL từ bài trước. Nếu chưa có, chạy [create_tables.sql](../ThucHanh_ThemDuLieu_QuanLySinhVien/create_tables.sql), sau đó [insert_data.sql](../ThucHanh_ThemDuLieu_QuanLySinhVien/insert_data.sql) một lần trên các bảng rỗng.
2. Mở [group_by_queries.sql](group_by_queries.sql) trong MySQL Workbench và chạy toàn bộ hoặc từng truy vấn.

## Kết quả mong đợi với dữ liệu mẫu

| Yêu cầu | Kết quả |
| --- | --- |
| Số sinh viên theo địa chỉ | Ha Noi: 1; Hai phong: 1; HCM: 1 |
| Điểm trung bình mỗi sinh viên có điểm | Hung: 10; Hoa: 10 |
| Điểm trung bình lớn hơn 15 | Không có dòng nào |
| Điểm trung bình cao nhất | Hung và Hoa, đồng hạng với điểm 10 |

Mark có một điểm cho mỗi cặp môn học và sinh viên, theo dữ liệu mẫu. `AVG` chỉ tính các học viên có điểm; phép `JOIN` giữ đúng cách tính ở đề bài. Nếu thêm sinh viên chưa có điểm, họ không xuất hiện trong hai báo cáo điểm. Truy vấn cuối dùng `>= ALL` để giữ mọi trường hợp đồng hạng. Tên cột địa chỉ được giữ nguyên theo dữ liệu tạo bảng trước; `StudentCount` dùng làm alias dễ đọc thay cho nhãn tiếng Việt.

## Nộp bài

Đã chạy toàn bộ script bằng MySQL 8.0.46 sau khi nạp dữ liệu mẫu vào một instance tạm. Output thực tế được lưu tại [actual_results.txt](actual_results.txt); truy vấn điểm lớn hơn 15 trả tập rỗng, truy vấn cuối trả Hung và Hoa đồng hạng.

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/student-management-group-by/ThucHanh_HamGroupBy_QuanLySinhVien
