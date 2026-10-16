# User Management with JSP, Servlet, JDBC, and MySQL

Ứng dụng MVC trên Tomcat 10.1+ có các chức năng xem danh sách, thêm, sửa, xóa User; lọc theo country và sắp xếp theo name tăng hoặc giảm dần. JDBC dùng `PreparedStatement`; hướng sắp xếp được giới hạn ở `ASC`/`DESC`.

## Cơ sở dữ liệu

Chạy `database/schema.sql` trong MySQL để tạo database `demo`, bảng `users` và dữ liệu mẫu.

`UserDAO` đọc cấu hình từ biến môi trường:

- `DB_URL` (mặc định `jdbc:mysql://localhost:3306/demo` với các tùy chọn UTF-8)
- `DB_USERNAME` (mặc định `root`)
- `DB_PASSWORD` (mặc định rỗng)

Đặt các biến này theo cấu hình MySQL cục bộ trước khi khởi động Tomcat. Không commit mật khẩu thật vào Git.

## Đóng gói và chạy

```sh
mvn clean package
```

Triển khai `target/user-management.war` lên Tomcat 10.1+ và mở `http://localhost:8080/user-management/users`.
