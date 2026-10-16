# [Thực hành] Truyền tham số vào Stored Procedure

Thực hành ba chế độ tham số MySQL: `IN`, `OUT`, `INOUT` trên CSDL `classicmodels`.

## Cách chạy

1. Nạp classicmodels sample database và kiểm tra bảng `customers` có `customerNumber` và `city`.
2. Mở [parameter_procedures.sql](parameter_procedures.sql) trong MySQL Workbench, chạy toàn bộ script trong một session.
3. Xem các result grid: khách số 175, tổng khách ở Lyon, và giá trị counter cuối là 8.

`getCusById` nhận tham số IN. `GetCustomersCountByCity` gán tham số OUT từ `COUNT` rồi caller đọc user variable `@total`. `SetCounter` nhận user variable INOUT, đọc và cập nhật lại giá trị qua từng lần gọi.

Mỗi procedure được `DROP PROCEDURE IF EXISTS` trước khi tạo lại, nên script có thể chạy lại. `@total` và `@counter` là biến theo session; đừng tách các câu gọi và câu SELECT kết quả sang kết nối khác.

## Nộp bài

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/mysql-stored-procedure-parameters/ThucHanh_StoredProcedure_ThamSo
