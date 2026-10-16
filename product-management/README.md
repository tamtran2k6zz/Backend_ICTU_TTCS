# Product Management MVC

Ứng dụng Java Web quản lý sản phẩm bằng Servlet, JSP, JSTL và service lưu dữ liệu mẫu trong bộ nhớ; tương thích Tomcat 10.1+.

## Chức năng

- Xem danh sách, xem chi tiết, thêm, cập nhật và xóa sản phẩm.
- Tìm kiếm theo tên sản phẩm, không phân biệt chữ hoa/thường.
- Kiểm tra tên, nhà sản xuất và giá trước khi lưu.

## Chạy ứng dụng

```sh
mvn clean package
```

Triển khai `target/product-management.war` lên Tomcat 10.1+ rồi mở `http://localhost:8080/product-management/products`.

Dữ liệu mẫu lưu trong bộ nhớ và được khởi tạo lại khi ứng dụng khởi động lại.
