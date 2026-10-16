# Nhật ký Tương tác Kỹ thuật với AI (AI Prompt Log)
**Dự án**: AutoRide - Bốc Hơi Lợi Nhuận & Chuẩn Hóa CSDL  
**Vai trò**: Data Architect  

---

## Lần tương tác 1: Tối ưu kiểu dữ liệu cho bài toán tài chính & Xử lý giá trị NULL
- **Prompt của Học viên**:
  > *"Khi thiết kế các cột tài chính như `security_deposit`, `late_fee`, `damage_fee` trong MySQL, tôi nên dùng FLOAT hay DECIMAL? Đồng thời, nếu một hợp đồng không bị phạt (giá trị có thể là NULL hoặc 0), việc để NULL ảnh hưởng thế nào đến phép tính hoàn cọc `security_deposit - late_fee - damage_fee`?"*
- **Tóm tắt phản hồi từ AI**:
  - **Lựa chọn kiểu dữ liệu**: Bắt buộc sử dụng `DECIMAL(12, 2)` (hoặc `DECIMAL(10, 2)`). Tuyệt đối không dùng `FLOAT` hay `DOUBLE` vì biểu diễn số học dấu chấm động nhị phân gây ra sai số làm tròn khi thực hiện phép tính kế toán.
  - **Xử lý NULL**: Trong SQL, bất kỳ số nào cộng/trừ với `NULL` đều cho kết quả là `NULL` (`1000 - NULL = NULL`). Do đó:
    - Cách 1: Thiết lập thuộc tính cột là `NOT NULL DEFAULT 0.00`.
    - Cách 2: Sử dụng hàm `COALESCE(late_fee, 0)` hoặc `IFNULL(late_fee, 0)` khi viết câu lệnh truy vấn tính toán.

---

## Lần tương tác 2: Đánh giá Quan hệ 1-1 vs 1-N cho Bảng Biên bản Kiểm tra xe (Inspections)
- **Prompt của Học viên**:
  > *"Tại sao việc tách dữ liệu kiểm tra xe ra một bảng riêng `Inspections` lại tốt hơn việc thêm trực tiếp cột `damage_description` vào bảng `Rentals`? Nên thiết kế quan hệ giữa `Rentals` và `Inspections` là 1-1 hay 1-N?"*
- **Tóm tắt phản hồi từ AI**:
  - **Lợi ích tách bảng (Normalization)**:
    - Tuân thủ nguyên tắc Single Responsibility: Bảng `Rentals` quản lý giao dịch thuê xe (thời gian, khách hàng, chi phí), còn `Inspections` ghi lại nghiệp vụ kỹ thuật/vận hành (thực trạng cơ khí, hình ảnh, nhân viên kiểm tra).
    - Tránh lãng phí bộ nhớ và ô dữ liệu thưa (Sparse table): Nếu phần lớn hợp đồng xe trả về nguyên vẹn, cột `damage_description` trong `Rentals` sẽ luôn mang giá trị `NULL`.
  - **Về Cardinality**:
    - Trong thực tế chuyên nghiệp, một hợp đồng thuê xe có thể có 2 lần kiểm tra: **Kiểm tra lúc giao xe (Check-out)** và **Kiểm tra lúc nhận lại xe (Check-in)** để so sánh độ chênh lệch hư hại. Do đó thiết kế quan hệ 1-N (hoặc 1-1 nếu quy định chặt chẽ cho lần trả xe) cho phép hệ thống mở rộng linh hoạt.

---

## Lần tương tác 3: Cơ chế Database Trigger chặn kiểm tra xe trái phép
- **Prompt của Học viên**:
  > *"Nếu muốn quy định: Khi hợp đồng đang ở trạng thái `BOOKED` (khách chưa nhận xe) thì không ai được phép insert dữ liệu vào bảng `Inspections` cho hợp đồng đó. Tôi nên dùng cơ chế nào ở tầng MySQL?"*
- **Tóm tắt phản hồi từ AI**:
  - Dùng **`BEFORE INSERT TRIGGER`** trên bảng `Inspections`.
  - Trigger sẽ truy vấn cột `status` trong `Rentals` theo `NEW.rental_id`. Nếu `status = 'BOOKED'`, trigger sẽ hủy thao tác và trả về mã lỗi bằng `SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khách chưa nhận xe (BOOKED), không thể thực hiện kiểm tra trả xe!';`.
