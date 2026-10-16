# JSP Pure Dictionary

Ứng dụng JSP tra cứu từ Anh – Việt, chạy trên Tomcat 10.1 trở lên.

## Chạy ứng dụng

Từ thư mục dự án, đóng gói ứng dụng bằng Maven:

```sh
mvn clean package
```

Triển khai `target/jsp-pure-dictionary.war` lên Tomcat 10.1+. Sau khi khởi động Tomcat, mở `http://localhost:8080/jsp-pure-dictionary/`.

Từ mẫu có sẵn: `hello`, `how`, `book`, `computer`, `student`. Tra cứu không phân biệt chữ hoa, chữ thường.
