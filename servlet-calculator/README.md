# Ứng dụng Calculator

Ứng dụng Java Web dùng Servlet và JSP để thực hiện phép cộng, trừ, nhân, chia trên Tomcat 10.1+.

## Chạy ứng dụng

Đóng gói từ thư mục dự án:

```sh
mvn clean package
```

Triển khai `target/servlet-calculator.war` lên Tomcat 10.1+ rồi mở `http://localhost:8080/servlet-calculator/`.

Servlet kiểm tra dữ liệu đầu vào và hiển thị lỗi khi chia cho 0 hoặc khi dữ liệu không hợp lệ.
