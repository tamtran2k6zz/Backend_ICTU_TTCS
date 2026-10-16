# Nhật ký Tương tác AI (AI Prompt Log)
**Dự án**: HealthSync Clinic - Database Refactoring  
**Mục đích**: Ghi nhận quá trình cộng tác, trao đổi kỹ thuật với AI để giải quyết các vấn đề thiết kế cơ sở dữ liệu và bảo đảm tính toàn vẹn dữ liệu.

---

## Lần tương tác 1: Phân tích Anti-pattern cột Boolean và Giải pháp Vòng đời (Lifecycle Status)
- **Prompt của Học viên**:
  > *"Trong thiết kế cơ sở dữ liệu quan hệ, tại sao việc dùng một cột `is_active` (kiểu TINYINT/BOOLEAN) để theo dõi vòng đời của một Đơn hàng/Lịch hẹn lại là một thiết kế tồi (Anti-pattern)? Tôi nên thay thế bằng cấu trúc nào để phản ánh 5 trạng thái: PENDING, CONFIRMED, CHECKED_IN, COMPLETED, CANCELLED?"*
- **Tóm tắt phản hồi từ AI**:
  - Dùng cờ Boolean chỉ biểu diễn được 2 giá trị nhị phân (Đúng/Sai), hoàn toàn không thể thể hiện được máy trạng thái (Finite State Machine).
  - Gây mất dấu vết dòng đời: Không biết được một bản ghi `is_active = FALSE` là do đã hủy, đã hoàn thành xong, hay bị từ chối duyệt.
  - **Khuyến nghị**: Sử dụng kiểu dữ liệu `ENUM('PENDING', 'CONFIRMED', 'CHECKED_IN', 'COMPLETED', 'CANCELLED')` trong MySQL để kiểm soát chặt danh mục trạng thái hợp lệ ngay tại tầng Database, tối ưu hóa bộ nhớ (lưu trữ nội bộ dưới dạng 1-byte integer) và tăng tốc độ indexing.

---

## Lần tương tác 2: Lựa chọn Kiểu Dữ liệu Tài chính (DECIMAL vs FLOAT/DOUBLE)
- **Prompt của Học viên**:
  > *"Khi thiết kế cột `deposit_amount` và `penalty_fee` trong MySQL phục vụ tính toán tài chính và đối soát kế toán, tôi nên dùng kiểu dữ liệu FLOAT, DOUBLE hay DECIMAL? Tại sao?"*
- **Tóm tắt phản hồi từ AI**:
  - `FLOAT` và `DOUBLE` là các kiểu dữ liệu số thực dấu chấm động theo chuẩn IEEE 754, sử dụng biểu diễn nhị phân gần đúng, dẫn đến **lỗi làm tròn số (floating-point rounding errors)** khi cộng trừ tiền bạc (ví dụ: `0.1 + 0.2 = 0.30000000000000004`).
  - `DECIMAL(M, D)` là kiểu số học chính xác cố định (Fixed-point), lưu trữ số dưới dạng chuỗi byte nhị phân chính xác tuyệt đối, không có sai số làm tròn.
  - **Khuyến nghị**: Sử dụng `DECIMAL(12, 2)` (hỗ trợ tới hàng trăm tỷ đồng và 2 chữ số thập phân cho xu/cent) để đảm bảo tính toàn vẹn tài chính 100% khi kế toán kiểm toán.

---

## Lần tương tác 3: Ngăn chặn kê đơn thuốc trái phép bằng Database Trigger
- **Prompt của Học viên**:
  > *"Dựa vào ERD hiện tại, nếu một lịch hẹn đang ở trạng thái PENDING (chưa khám), nhưng có người cố tình INSERT một đơn thuốc vào bảng Prescriptions, làm thế nào để chặn hành động này ở tầng cơ sở dữ liệu MySQL mà không phụ thuộc hoàn toàn vào code Backend?"*
- **Tóm tắt phản hồi từ AI**:
  - Tầng ứng dụng (Backend) có thể bị bypass qua SQL injection hoặc lỗi logic. Giải pháp phòng thủ chiều sâu (Defense-in-Depth) tốt nhất tại tầng database là tạo một **BEFORE INSERT TRIGGER** trên bảng `Prescriptions`.
  - Trong Trigger, truy vấn trạng thái lịch hẹn tương ứng từ `Appointments`. Nếu `status != 'COMPLETED'`, phát tín hiệu lỗi bằng lệnh `SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Chỉ được phép kê đơn thuốc cho lịch hẹn đã hoàn thành (COMPLETED)!';`.
