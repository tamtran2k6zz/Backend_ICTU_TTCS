# Báo cáo Đối chiếu Nghiệp vụ & Mô hình Dữ liệu (ER - Activity Mapping)
**Dự án**: Nền tảng Cho thuê xe tự lái AutoRide  
**Vai trò**: Data Architect  

---

## 1. Lý do cột `damage_fee` là bắt buộc để đảm bảo tính toàn vẹn hệ thống
Trong quy trình hoàn tất hợp đồng thuê xe (`ACTIVE` -> `COMPLETED`), sự có mặt của cột `damage_fee` là điều kiện tiên quyết mang tính sống còn đối với bài toán tài chính:

1. **Khép kín dòng tiền hoàn cọc**: Nghiệp vụ quy định công thức kế toán:  
   $$\text{Tiền hoàn lại (Refund)} = \text{Tiền cọc} - \text{Phí phạt trễ} - \text{Phí bồi thường hư hỏng}$$  
   Nếu thiếu `damage_fee`, hệ thống bị mất một số trừ cốt tử, dẫn đến việc ứng dụng tự động hoàn trả nguyên vẹn tiền cọc cho khách dù xe bị trầy xước, vỡ linh kiện, gây thất thoát trực tiếp lợi nhuận doanh nghiệp.
2. **Đối soát minh bạch giữa Biên bản và Kế toán**: Cột `damage_fee` tại bảng `Rentals` là cầu nối chuẩn hóa định lượng (số tiền bằng số) từ những mô tả định tính (`damage_description`) tại bảng `Inspections`. Nhờ đó, kế toán viên và khách hàng có thể đối soát minh bạch từng khoản trừ mà không phụ thuộc vào ghi chép thủ công.

---

## 2. Bảng phân tích 3 khoảng trống dữ liệu (Data Gaps) nghiêm trọng của Legacy Database

| STT | Điểm chạm nghiệp vụ (Activity Diagram) | Hiện trạng Legacy Database | Hậu quả thực tế & Rủi ro | Giải pháp khắc phục |
|:---:|:---|:---|:---|:---|
| **1** | Vòng đời hợp đồng có kiểm soát (`BOOKED` -> `ACTIVE` -> `COMPLETED` / `CANCELLED`) | Dùng `status VARCHAR(50) DEFAULT 'BOOKED'` không ràng buộc | Lập trình viên/nhân viên có thể nhập sai chính tả (vd: `'Active'`, `'done'`), phá vỡ logic State Machine | Chuyển sang `ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED')` |
| **2** | Nhánh rẽ tính phạt trễ giờ (`late_fee`) và bồi thường hư hỏng (`damage_fee`) | Hoàn toàn vắng bóng các cột lưu trữ tiền phạt và tiền cọc | Hệ thống không thể tính tiền hoàn cọc; kế toán không thể ghi nhận nguồn thu bù đắp chi phí sửa chữa | Bổ sung `security_deposit`, `late_fee`, `damage_fee` kiểu `DECIMAL(12,2)` |
| **3** | Khâu bàn giao kiểm tra tình trạng xe (Inspection) | Không có bảng lưu biên bản kiểm tra xe | Mất dấu vết lỗi xe (ai kiểm tra, thời điểm nào, vị trí trầy xước ra sao); dễ dẫn đến tranh chấp pháp lý với khách | Tạo mới bảng `Inspections` liên kết khóa ngoại với `Rentals` |
