# [Thực hành] Tạo bảng trên MySQL Workbench

## 1. Mục tiêu
- Luyện tập và thực hiện thành thạo các thao tác tạo Cơ sở dữ liệu và Bảng (Table) bằng câu lệnh SQL trên MySQL Workbench.
- Hiểu và áp dụng các kiểu dữ liệu cơ bản (`INT`, `VARCHAR`).

---

## 2. Mô tả bài toán
- Tạo một CSDL mới tên là `demo`.
- Chọn CSDL `demo` làm CSDL hoạt động (`USE demo;`).
- Tạo bảng `Student` gồm các trường (thuộc tính):
  - `id`: Kiểu số nguyên (`INT`).
  - `name`: Kiểu chuỗi ký tự độ dài tối đa 200 ký tự (`VARCHAR(200)`).
  - `age`: Kiểu số nguyên (`INT`).
  - `country`: Kiểu chuỗi ký tự độ dài tối đa 50 ký tự (`VARCHAR(50)`).

---

## 3. Các bước thực hiện chi tiết

### Bước 1: Mở trình soạn thảo SQL (Query Tab)
- Mở **MySQL Workbench** và kết nối tới server MySQL cục bộ.
- Nhấn chọn biểu tượng **New Query Tab** (hoặc nhấn `Ctrl + T`).

### Bước 2: Viết các câu lệnh SQL
Nhập đoạn script SQL sau vào tab truy vấn:
```sql
-- Tạo CSDL tên demo
CREATE DATABASE IF NOT EXISTS demo;

-- Chọn CSDL demo để thao tác
USE demo;

-- Tạo bảng Student
CREATE TABLE IF NOT EXISTS Student (
    id INT,
    name VARCHAR(200),
    age INT,
    country VARCHAR(50)
);
```

### Bước 3: Chạy các câu lệnh
- Để chạy từng câu lệnh: Đặt con trỏ chuột tại dòng lệnh muốn chạy và nhấn tổ hợp phím `Ctrl + Enter`.
- Để chạy toàn bộ file: Nhấn biểu tượng **Tia sét** (Execute) hoặc tổ hợp phím `Ctrl + Shift + Enter`.

### Bước 4: Kiểm tra kết quả
- Xem panel **Action Output** bên dưới: xuất hiện dấu tích màu xanh báo câu lệnh thực thi thành công.
- Kiểm tra cấu trúc bảng vừa tạo:
  ```sql
  DESCRIBE Student;
  ```
- Chuột phải vào vùng danh sách **Schemas** ở khung bên trái và chọn **Refresh All**, bạn sẽ thấy schema `demo` chứa table `Student`.
