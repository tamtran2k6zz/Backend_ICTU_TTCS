# [Bài tập] Xây dựng cơ sở dữ liệu quản lý sinh viên

## 1. Mục tiêu
- Luyện tập và thành thạo kỹ năng thiết kế và tạo các bảng trong cơ sở dữ liệu quản lý sinh viên (`student-management`) trên MySQL Workbench.
- Thực hành cả 2 phương pháp: thông qua giao diện trực quan (**Table Editor GUI**) và bằng câu lệnh truy vấn **SQL**.

---

## 2. Mô tả yêu cầu
Sử dụng CSDL `student-management` (hoặc `student_management`), tạo thêm 2 bảng dữ liệu:
1. **Bảng `Class`**:
   - `id`: Kiểu số nguyên (`INT`), Khóa chính (`PRIMARY KEY`), Tự tăng (`AUTO_INCREMENT`).
   - `name`: Kiểu chuỗi (`VARCHAR(100)`), Tên lớp học, không được rỗng (`NOT NULL`).
2. **Bảng `Teacher`**:
   - `id`: Kiểu số nguyên (`INT`), Khóa chính (`PRIMARY KEY`), Tự tăng (`AUTO_INCREMENT`).
   - `name`: Kiểu chuỗi (`VARCHAR(150)`), Họ và tên giáo viên.
   - `age`: Kiểu số nguyên (`INT`), Tuổi giáo viên.
   - `country`: Kiểu chuỗi (`VARCHAR(100)`), Quốc gia / Quê quán.

---

## 3. Hướng dẫn thực hiện

### Cách 1: Sử dụng giao diện MySQL Workbench (GUI)
1. **Bước 1**: Khởi động MySQL Workbench, kết nối vào server. Nhấp chuột phải vào schema `student-management` (hoặc tạo mới schema nếu chưa có) và chọn **Create Table...**.
2. **Bước 2**: Thiết lập bảng **`Class`**:
   - `Table Name`: Nhập `Class`.
   - Cột 1: Tên `id`, Datatype: `INT`, tích chọn `PK` (Primary Key), `NN` (Not Null), `AI` (Auto Increment).
   - Cột 2: Tên `name`, Datatype: `VARCHAR(100)`.
   - Nhấn **Apply**, kiểm tra mã SQL và tiếp tục nhấn **Apply** -> **Finish**.
3. **Bước 3**: Thiết lập bảng **`Teacher`**:
   - Nhấp chuột phải vào mục **Tables** trong schema `student-management` -> chọn **Create Table...**.
   - `Table Name`: Nhập `Teacher`.
   - Cột 1: `id` (`INT`, `PK`, `NN`, `AI`).
   - Cột 2: `name` (`VARCHAR(150)`).
   - Cột 3: `age` (`INT`).
   - Cột 4: `country` (`VARCHAR(100)`).
   - Nhấn **Apply** -> **Finish** để tạo bảng.

---

### Cách 2: Sử dụng câu lệnh SQL (Khuyên dùng)
Chạy script SQL sau trong cửa sổ **New Query Tab**:

```sql
-- Tạo CSDL nếu chưa có
CREATE DATABASE IF NOT EXISTS `student_management`
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `student_management`;

-- Tạo bảng Class
CREATE TABLE IF NOT EXISTS `Class` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL
);

-- Tạo bảng Teacher
CREATE TABLE IF NOT EXISTS `Teacher` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(150) NOT NULL,
    `age` INT,
    `country` VARCHAR(100)
);
```
