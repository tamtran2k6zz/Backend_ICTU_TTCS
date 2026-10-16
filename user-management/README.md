# User Management with JSP, Servlet, JDBC, and MySQL

Maven WAR scaffold cho Tomcat 10.1+; cấu hình sẵn Jakarta Servlet/JSP, JSTL và MySQL Connector/J. Theo yêu cầu của bài, Java và JSP chỉ gồm khung khai báo có chú thích, chưa có xử lý CRUD hay giao diện hoàn chỉnh.

## Khởi tạo MySQL

Chạy `database/schema.sql` trong MySQL để tạo database `demo`, bảng `users` và hai dòng dữ liệu mẫu.

## Đóng gói và triển khai

```sh
mvn clean package
```

Triển khai `target/user-management.war` lên Tomcat 10.1+. URL của servlet là `/users`. Khi tự hoàn thiện `UserDAO`, cấu hình URL, tên người dùng và mật khẩu MySQL phù hợp với máy của bạn; không lưu mật khẩu thật trong Git.
