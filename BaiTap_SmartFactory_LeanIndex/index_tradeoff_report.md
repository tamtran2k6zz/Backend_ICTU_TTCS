# SmartFactory: báo cáo đánh đổi giữa đọc và ghi

Covering index cũ `(sensor_id, recorded_at, temperature, humidity, status)` trả đủ cột cho Dashboard ngay từ index, nên tránh đọc lại clustered row. Đổi lại, mỗi bản ghi secondary index phải mang thêm temperature, humidity, status và khóa chính `log_id`. Lean index `(sensor_id, recorded_at)` giữ điều kiện lọc; `EXPLAIN` vẫn nên dùng `idx_lean_search` với `type = range`, nhưng Dashboard phải tra clustered row để đọc ba cột kết quả. Extra vì thế không còn `Using index`.

Với DECIMAL(5,2), temperature và humidity chiếm 3 byte mỗi giá trị. Các status mẫu ASCII dài 6–8 byte, cộng byte độ dài VARCHAR; tổng payload bổ sung xấp xỉ 14 byte mỗi entry fat index so với lean, chưa kể cấu trúc trang và metadata. Đây là ước lượng từ kiểu dữ liệu, không thay thế `Index_length` thực đo. Ghi nhận `DATA_LENGTH` và `INDEX_LENGTH` ở hai result grid của `smartfactory_reindex.sql` vào bảng:

| Kích thước | Trước | Sau |
| --- | ---: | ---: |
| Data (MB) |  |  |
| Index (MB) |  |  |
| Tổng (MB) |  |  |

Bỏ cột khỏi index giảm dữ liệu cần ghi và lưu trong secondary tree, nhưng có thể tăng random reads khi lấy payload. Không thể khẳng định SELECT chậm chính xác một phần nghìn giây, INSERT nhanh gấp năm hay tiết kiệm 70% nếu chưa benchmark cùng workload và phần cứng. Covering index vẫn hữu ích khi bảng ít ghi và truy vấn đọc lặp lại thường xuyên.
