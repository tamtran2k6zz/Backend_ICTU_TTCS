# [Thực hành] Thêm dữ liệu vào cơ sở dữ liệu quản lý sinh viên

Sử dụng `INSERT INTO` để thêm dữ liệu vào bốn bảng của CSDL `QuanLySinhVien`.

## Cách chạy trên MySQL Workbench

1. Kết nối tới MySQL, mở và chạy [create_tables.sql](create_tables.sql) nếu chưa có các bảng từ bài trước. File này chỉ tạo CSDL và bảng, không thêm dữ liệu mẫu.
2. Bảo đảm cả bốn bảng đang rỗng. Nếu đã chạy dữ liệu mẫu của bài trước, dùng một CSDL thực hành sạch trước khi tiếp tục.
3. Mở và chạy toàn bộ [insert_data.sql](insert_data.sql) một lần.
4. Xem bốn bảng kết quả từ các câu `SELECT` cuối file.

File chèn dữ liệu chỉ định ID rõ ràng để khớp đề và liên kết khóa ngoại, kể cả khi bộ đếm `AUTO_INCREMENT` đã thay đổi. Chạy lại trên dữ liệu đã chèn sẽ gây lỗi trùng khóa chính. Nếu gặp lỗi trước `COMMIT`, dừng thực thi và chạy `ROLLBACK;` để hủy các lệnh chèn chưa commit trong phiên đó.

## Dữ liệu theo đề bài

| Bảng | Số bản ghi | Nội dung |
| --- | --- | --- |
| Class | 3 | A1: 2008-12-20; A2: 2008-12-22; B3: ngày thực thi SQL |
| Student | 3 | Hung, Hoa, Manh; Hoa có Phone = NULL |
| Subject | 4 | CF (5), C (6), HDJ (5), RDBMS (10) |
| Mark | 3 | (SubId, StudentId, Mark, ExamTimes): (1,1,8,1), (1,2,10,2), (2,1,12,1) |

Số điện thoại của Hung là chuỗi `0912113113` để giữ số 0 đầu. Điểm `12` được giữ nguyên theo đề, phù hợp với ràng buộc từ 0 đến 100 của bài tạo bảng trước. `CURRENT_DATE()` lấy ngày hiện tại theo phiên MySQL.

## Nộp bài

Link thư mục trên nhánh riêng:

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/student-management-insert-into/ThucHanh_ThemDuLieu_QuanLySinhVien
