# Danh sách khách hàng với JSTL

Ứng dụng JSP hiển thị danh sách khách hàng mẫu bằng JSTL trên Tomcat 10.1+.

## Chạy ứng dụng

Đóng gói từ thư mục dự án:

```sh
mvn clean package
```

Triển khai `target/customer-list-jstl.war` lên Tomcat 10.1+ và mở `http://localhost:8080/customer-list-jstl/`.

Trang dùng JSTL 3 (`jakarta.tags.core`) và escape nội dung hiển thị bằng `<c:out>`.
