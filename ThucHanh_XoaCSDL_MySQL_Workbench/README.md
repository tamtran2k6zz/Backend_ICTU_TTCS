# [Thực hành] Xóa CSDL trên MySQL Workbench

## 1. Mục tiêu
- Luyện tập và thực hiện thành thạo các thao tác xóa Cơ sở dữ liệu (Database / Schema).
- Nắm vững 2 cách xóa:
  1. Xóa trực tiếp qua giao diện người dùng (GUI) của MySQL Workbench.
  2. Xóa bằng câu lệnh SQL (`DROP DATABASE`).

> [!WARNING]
> Thao tác xóa CSDL (`DROP DATABASE`) là vĩnh viễn và không thể hoàn tác (`ROLLBACK`). Toàn bộ bảng, dữ liệu và các cấu trúc bên trong sẽ bị xóa hoàn toàn. Luôn sao lưu (backup/dump) dữ liệu quan trọng trước khi thực hiện.

---

## 2. Hướng dẫn chi tiết

### Cách 1: Xóa CSDL sử dụng giao diện MySQL Workbench (GUI)

- **Bước 1**: Khởi động **MySQL Workbench** và đăng nhập vào kết nối MySQL bằng tài khoản `root`.
- **Bước 2**: Tại danh sách **Schemas** ở khung bên trái:
  - Tìm schema muốn xóa (ví dụ: `my_database`).
  - Nhấp chuột phải vào tên schema và chọn **Drop Schema...**.
- **Bước 3**: Cửa sổ xác nhận xuất hiện với 3 lựa chọn:
  - **Review SQL**: Xem lại câu lệnh SQL sẽ chạy trước khi xóa.
  - **Drop Now**: Tiến hành xóa ngay lập tức.
  - **Cancel**: Hủy thao tác.
  -> Nhấn chọn **Drop Now**.
- **Bước 4**: Kiểm tra trạng thái tại khung **Action Output** ở phía dưới:
  - Nếu xuất hiện icon dấu tích xanh kèm thông báo thực thi thành công, CSDL đã được xóa khỏi danh sách Schemas.

---

### Cách 2: Xóa CSDL bằng câu lệnh SQL trên MySQL Workbench

- **Bước 1**: Nhấn vào biểu tượng **New Query Tab** (hoặc nhấn `Ctrl + T`) để mở cửa sổ soạn thảo truy vấn SQL mới.
- **Bước 2**: Nhập câu lệnh SQL:
  ```sql
  -- Câu lệnh cơ bản
  DROP DATABASE `my_database`;

  -- Câu lệnh khuyên dùng (tránh lỗi nếu database không tồn tại)
  DROP DATABASE IF EXISTS `my_database`;
  ```
- **Bước 3**: Chạy câu lệnh bằng cách nhấn vào biểu tượng **Tia sét** (**Execute**) hoặc nhấn tổ hợp phím `Ctrl + Enter`.
- **Bước 4**: Kiểm tra panel **Action Output**:
  - Dòng kết quả báo tích xanh: lệnh chạy thành công.
  - Chuột phải vào vùng danh sách **Schemas** và chọn **Refresh All** để cập nhật lại danh sách.
