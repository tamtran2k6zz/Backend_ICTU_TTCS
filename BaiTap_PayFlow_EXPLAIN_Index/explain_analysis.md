# So sánh EXPLAIN

Đo trên MySQL 8.0.46 với 100.004 giao dịch mô phỏng, không phải 5 triệu dòng production.

| Chỉ số | Trước tối ưu | Sau tối ưu |
| --- | --- | --- |
| type | ALL | range |
| possible_keys | NULL | idx_type_date |
| key | NULL | idx_type_date |
| rows | 99.855 | 241 |
| Extra | Using where | Using index condition |

Truy vấn cũ chưa có index phụ và dùng YEAR/MONTH trên created_at. Truy vấn mới dùng index (transaction_type, created_at), điều kiện bằng trên loại và khoảng nửa mở tháng 6/2026. Số dòng ước lượng giảm khoảng 414 lần; rows không phải số dòng thực đo và thay đổi theo thống kê.

SUM(amount) của cả hai bằng 15.837,20; totals_match = 1. Bộ dữ liệu có giao dịch sát hai biên tháng và WITHDRAW trong tháng. Khoảng mới nhận đầu tháng 6, loại đầu tháng 7.

Using index condition không phải covering index: vẫn cần amount từ bảng. Không ép FORCE INDEX; optimizer chọn range tự nhiên. Chưa đo tải ghi đồng thời hoặc chứng minh giảm thời gian 45 giây của hệ thống thật.
