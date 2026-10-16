# [Thực hành] Stored Procedure trên classicmodels

## Chuẩn bị

Cần MySQL classicmodels sample database đã được import và đang có bảng `customers` cùng cột `customerNumber`. Trong MySQL Workbench, mở một SQL tab kết nối tới server rồi chạy [customer_procedures.sql](customer_procedures.sql) toàn bộ.

File lần lượt tạo và gọi `findAllCustomers()` để lấy toàn bộ khách; sau đó xóa, tạo lại cùng tên procedure với điều kiện `customerNumber = 175` và gọi lại. Result Grid đầu có danh sách khách hàng, result grid cuối chỉ có khách 175 (nếu dữ liệu classicmodels đã nạp đúng).

`DELIMITER //` giúp client nhận hết thân `BEGIN ... END` như một lệnh tạo procedure; dấu `;` bên trong vẫn kết thúc từng câu SQL. Sau khi định nghĩa xong, delimiter được trả về `;`.

Chạy lại toàn bộ script an toàn: mỗi lần tạo đều có `DROP PROCEDURE IF EXISTS`. Việc chạy lại vẫn trả danh sách khách hàng đầy đủ ở lần gọi đầu rồi trả khách 175 ở lần gọi thứ hai.

## Nộp bài

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/mysql-stored-procedure-practice/ThucHanh_StoredProcedure_ClassicModels
