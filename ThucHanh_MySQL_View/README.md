# [Thực hành] View trong MySQL

## Cách chạy

1. Nạp classicmodels sample database và xác nhận có bảng `customers` với các cột `customerNumber`, `customerName`, `phone`, `contactFirstName`, `contactLastName`, `city`.
2. Mở [customer_views.sql](customer_views.sql) trong MySQL Workbench và chạy toàn bộ.
3. Hai câu `SELECT` lần lượt cho thấy view ban đầu gồm thông tin liên lạc của mọi khách hàng, rồi view đã thay định nghĩa chỉ gồm khách hàng ở Nantes.
4. Để xóa view, chạy lệnh `DROP VIEW IF EXISTS customer_views` ở cuối file.

`CREATE OR REPLACE VIEW` tạo mới view nếu chưa tồn tại và thay định nghĩa nếu đã có. View là một bảng ảo; dữ liệu vẫn được đọc từ `customers`.

Hai định nghĩa đều truy vấn một bảng và không dùng phép gộp hay biểu thức, nên là view đơn giản có thể cập nhật các cột hiển thị của những dòng thỏa điều kiện. Chèn dòng qua view bị giới hạn vì view không chứa đầy đủ các cột bắt buộc của `customers`.

## Nộp bài

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/mysql-view-practice/ThucHanh_MySQL_View
