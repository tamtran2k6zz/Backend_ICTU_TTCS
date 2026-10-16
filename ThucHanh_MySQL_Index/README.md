# [Thực hành] Chỉ mục trong MySQL

## Chạy thử độc lập

1. Trong MySQL Workbench, chạy `setup_demo.sql` trên môi trường thực hành mới. File tạo `index_practice_db.customers` với 100.001 dòng mô phỏng và chưa có index phụ.
2. Chạy từng phần trong `index_practice.sql` theo thứ tự. So sánh `type`, `possible_keys`, `key`, `rows` và `Extra` trước, sau khi tạo index.
3. Lệnh cuối cùng minh họa `DROP INDEX`; bỏ comment chỉ khi muốn xóa index ghép.

## Chạy trên classicmodels

Khi đã nạp classicmodels, mở `index_practice.sql`, đổi `USE index_practice_db;` thành `USE classicmodels;` và chạy các phần phù hợp. Bảng classicmodels có `customerNumber`, `customerName`, `contactFirstName`, `contactLastName`. Ví dụ customerName phải viết đúng `Land Of Toys Inc.` theo dữ liệu thực tế. Không chạy `setup_demo.sql` trên database đó.

`customerName` có thể dài 50 ký tự trong classicmodels. `idx_full_name` là composite index theo đúng thứ tự `(contactFirstName, contactLastName)`; truy vấn OR cùng cột first name có thể dùng tiền tố đầu của index. Nên kiểm tra `key` và `rows` trên chính phiên bản, dữ liệu và thống kê đang dùng.

## Kết quả mẫu

Với 100.001 dòng mô phỏng, truy vấn customerName trước index dự kiến dùng `type = ALL`; sau index sẽ dùng `idx_customerName` (thường `ref`) và ước tính rất ít dòng. Số `rows` là ước lượng của optimizer, không phải thời gian đo. Với bảng nhỏ hoặc điều kiện khớp nhiều dòng, optimizer có thể chọn scan toàn bảng.

`EXPLAIN` cho biết kế hoạch và ước lượng, không chứng minh tốc độ thực thi. Index tăng dung lượng và chi phí ghi; chỉ thêm index theo truy vấn thực tế. `EXPLAIN ANALYZE` thực thi câu lệnh để đo thực tế, dùng trong môi trường thử nghiệm.

Sau khi tự chạy các truy vấn, có thể lưu hai bảng EXPLAIN từ MySQL Workbench làm bằng chứng so sánh.

## Nộp bài

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/mysql-index-practice/ThucHanh_MySQL_Index
