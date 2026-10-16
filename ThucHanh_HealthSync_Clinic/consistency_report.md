# Báo cáo Phân tích Khoảng cách Dữ liệu (Gap Analysis Report)
**Dự án**: Phòng khám đa khoa HealthSync  
**Vai trò**: System Analyst & Database Administrator  

---

## 1. Tóm tắt vấn đề (Executive Summary)
Quy trình nghiệp vụ khám chữa bệnh của phòng khám HealthSync được chuyên viên BA đặc tả bằng **UML Activity Diagram** với vòng đời lịch hẹn phức tạp gồm 5 trạng thái (`PENDING` -> `CONFIRMED` -> `CHECKED_IN` -> `COMPLETED` / `CANCELLED`), cơ chế đặt cọc, xử lý hủy lịch phạt tiền cọc, và kê đơn thuốc sau khám. 

Tuy nhiên, bản thiết kế cơ sở dữ liệu cũ (**Legacy Database**) của lập trình viên Backend bị vênh nghiêm trọng so với thực tế, làm gãy vỡ quy trình vận hành và thất thoát tài chính.

---

## 2. Ba điểm "vênh" nghiêm trọng nhất giữa Nghiệp vụ và Thiết kế cũ

### Điểm vênh 1: Sử dụng cờ Boolean (`is_active`) cho vòng đời lịch hẹn đa trạng thái
- **Thực tế nghiệp vụ**: Vòng đời lịch hẹn trải qua 5 trạng thái có thứ tự logic: `PENDING` (chờ cọc) -> `CONFIRMED` (đã nhận cọc) -> `CHECKED_IN` (bệnh nhân tới phòng khám) -> `COMPLETED` (khám xong) hoặc `CANCELLED` (hủy hẹn).
- **Thiết kế cũ**: Chỉ dùng một cột `is_active BOOLEAN DEFAULT TRUE`.
- **Hậu quả**: Không thể phân biệt bệnh nhân đang chờ duyệt, đã đóng cọc, đã tới khám hay đã hoàn tất. Cột boolean chỉ mang tính chất nhị phân bật/tắt (active/inactive), hoàn toàn vô dụng trước một State Machine nghiệp vụ.

### Điểm vênh 2: "Bỏ quên" hoàn toàn dòng tiền (Tiền cọc `deposit_amount` và Phí phạt `penalty_fee`)
- **Thực tế nghiệp vụ**: Quy trình yêu cầu bệnh nhân đóng tiền cọc khi đặt lịch; nếu hủy lịch sau khi đã xác nhận (`CONFIRMED`), hệ thống phải khấu trừ phí phạt từ tiền cọc và ghi nhận lý do hủy (`cancel_reason`).
- **Thiết kế cũ**: Không có bất kỳ trường nào lưu trữ số tiền cọc, số tiền phạt, hay lý do hủy.
- **Hậu quả**: Phòng khám thất thoát dòng tiền, bộ phận Kế toán không thể đối soát doanh thu cuối tháng từ nguồn thu phạt cọc, và phòng khám không có dữ liệu để giải quyết khiếu nại của bệnh nhân.

### Điểm vênh 3: Vắng mặt bảng Đơn thuốc (`Prescriptions`) sau khi khám hoàn tất
- **Thực tế nghiệp vụ**: Khi trạng thái chuyển sang `COMPLETED`, Bác sĩ khám bệnh bắt buộc phải kê đơn thuốc kèm theo lịch hẹn đó.
- **Thiết kế cũ**: Không hề tồn tại bảng `Prescriptions` hay bất kỳ mối quan hệ nào để lưu trữ thông tin thuốc, liều dùng, và ngày cấp.
- **Hậu quả**: Toàn bộ nghiệp vụ khám chữa bệnh bị chặn đứng tại khâu xuất viện/kê đơn; vi phạm quy định pháp lý y tế về hồ sơ bệnh án và quản lý đơn thuốc.

---

## 3. Đề xuất giải pháp khắc phục
1. Tái cấu trúc bảng `Appointments`:
   - Thay `is_active` bằng `status ENUM('PENDING', 'CONFIRMED', 'CHECKED_IN', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING'`.
   - Bổ sung `deposit_amount DECIMAL(12,2) DEFAULT 0.00`, `penalty_fee DECIMAL(12,2) DEFAULT 0.00`, và `cancel_reason VARCHAR(255) NULL`.
2. Tạo mới bảng `Prescriptions`:
   - Khóa chính `prescription_id`, khóa ngoại `appointment_id UNIQUE` (đảm bảo quan hệ 1-1 chặt chẽ với lịch hẹn đã hoàn thành), cột `medication_details TEXT`, và `issued_date DATETIME`.
3. Thiết lập Database Trigger chặn đứng việc kê đơn thuốc cho các lịch hẹn chưa chuyển sang trạng thái `COMPLETED`.
