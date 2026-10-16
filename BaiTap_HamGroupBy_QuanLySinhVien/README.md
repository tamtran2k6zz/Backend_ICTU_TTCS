# [Bài tập] Luyện tập các hàm thông dụng trong SQL

Ba truy vấn dùng `MAX`, `AVG`, `GROUP BY` và sắp xếp kết quả trên CSDL `QuanLySinhVien`.

## Cách chạy

1. Dùng CSDL từ các bài trước. Nếu chưa có, chạy [create_tables.sql](../ThucHanh_ThemDuLieu_QuanLySinhVien/create_tables.sql), sau đó [insert_data.sql](../ThucHanh_ThemDuLieu_QuanLySinhVien/insert_data.sql) một lần trên các bảng rỗng.
2. Mở [aggregate_practice.sql](aggregate_practice.sql) trong MySQL Workbench và chạy từng truy vấn hoặc cả file.

## Kết quả mong đợi với dữ liệu mẫu

- Credit lớn nhất: RDBMS, Credit = 10.
- Môn có điểm thi lớn nhất: C, điểm = 12.
- Điểm trung bình: Hung = 10, Hoa = 10; Hung đứng trước khi hòa điểm theo StudentId. Manh chưa có điểm nên không xuất hiện.

Hai truy vấn đầu lấy tất cả môn đồng hạng nếu có. Truy vấn điểm lớn nhất chỉ xét các môn đã có bản ghi trong Mark. Câu cuối xếp giảm dần theo điểm trung bình và dùng StudentId tăng dần để kết quả đồng hạng có thứ tự ổn định.

## Nộp bài

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/student-management-aggregate-practice/BaiTap_HamGroupBy_QuanLySinhVien
