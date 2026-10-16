# User Management with JSP, Servlet, JDBC, and MySQL

Ứng dụng MVC trên Tomcat 10.1+ có các chức năng xem danh sách, thêm, sửa, xóa User; lọc theo country và sắp xếp theo name tăng hoặc giảm dần. Các thao tác thêm User và tìm User theo ID gọi MySQL Stored Procedure bằng JDBC `CallableStatement`; các thao tác JDBC còn lại dùng `PreparedStatement`.

## Cơ sở dữ liệu

Chạy `database/schema.sql` trong MySQL để tạo database `demo`, bảng `users` và dữ liệu mẫu.

Sau đó chạy `database/stored-procedures.sql` để tạo `get_user_by_id` và `insert_user`. Form sửa dùng `get_user_by_id`; `insert_user` được giữ lại từ bài Stored Procedure trước.

Chạy tiếp `database/transaction-schema.sql` để tạo bảng `permission`, bảng liên kết `user_permission` và các quyền mẫu. Khi thêm User, ứng dụng ghi User và các quyền đã chọn trong cùng một transaction JDBC; lỗi ở bước gán quyền sẽ rollback cả hai thao tác.

`UserDAO` đọc cấu hình từ biến môi trường:

- `DB_URL` (mặc định `jdbc:mysql://localhost:3306/demo` với các tùy chọn UTF-8)
- `DB_USERNAME` (mặc định `root`)
- `DB_PASSWORD` (mặc định rỗng)

Đặt các biến này theo cấu hình MySQL cục bộ trước khi khởi động Tomcat. Không commit mật khẩu thật vào Git.

## Demo SQL không sử dụng transaction

Mở `/users?action=test-without-tran` hoặc chọn **Chạy demo không Transaction** trên trang danh sách. Demo tạo lại bảng `Employee`, thêm Quynh và Ngan, sau đó cố tình chạy một UPDATE thiếu tham số. JDBC giữ auto-commit mặc định, nên hai INSERT đã hoàn tất vẫn còn trong bảng dù UPDATE thất bại. Lỗi được in trong log của Tomcat; kiểm tra kết quả bằng `SELECT * FROM Employee;`.

Endpoint này chủ động xóa và tạo lại riêng bảng `Employee` mỗi lần chạy để dữ liệu minh họa có kết quả ổn định. Chỉ chạy trong database demo của bài thực hành.

## Demo SQL có sử dụng transaction

- `/users?action=test-use-tran` cố tình để thiếu tham số UPDATE. Hai INSERT được rollback; bảng `Employee` trống và lỗi được ghi vào log.
- `/users?action=test-use-tran-success` chạy cùng quy trình với tham số UPDATE đúng, sau đó commit. `Quynh` có lương `999.99`, `Ngan` có lương `20.00`.

Cả hai URL đều xóa và tạo lại riêng bảng `Employee` trước giao dịch để kết quả có thể lặp lại. Mỗi lần chạy sẽ thay thế nội dung hiện có của bảng này.

## Đóng gói và chạy

```sh
mvn clean package
```

Triển khai `target/user-management.war` lên Tomcat 10.1+ và mở `http://localhost:8080/user-management/users`.
