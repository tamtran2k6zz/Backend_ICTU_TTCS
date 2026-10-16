# Nhật ký hỗ trợ AI

Người dùng gửi đề qua file và yêu cầu triển khai theo quy ước làm bài, commit, push. AI đã soạn SQL, sinh dữ liệu mô phỏng và kiểm tra. Các mục dưới là chủ đề được AI phân tích trong phiên, không phải lịch sử câu hỏi tự thực hành của học viên. Đề giới hạn việc dùng AI viết đáp án; cần công khai phạm vi hỗ trợ này khi nộp.

## SARGable nghĩa là gì?

Điều kiện có thể dùng cấu trúc index để giới hạn vùng tìm kiếm. YEAR/MONTH trên cột không trực tiếp tạo khoảng tìm kiếm cho index thông thường trên ngày. Đổi sang >= đầu tháng và < đầu tháng sau tạo khoảng liên tiếp; không cần đoán ngày cuối tháng hay độ chính xác phần giây. Không thể khẳng định mọi điều kiện có hàm đều buộc ALL: còn functional index, phần tiền tố index khác và lựa chọn optimizer.

## Vì sao (transaction_type, created_at)?

Điều kiện bằng trên loại giao dịch xác định một phần tiền tố, rồi khoảng ngày giới hạn phần tiếp theo. Không áp dụng máy móc quy tắc “cardinality cao nhất đứng trước”; cần xét dạng điều kiện và các truy vấn khác. Xem [Range Optimization](https://dev.mysql.com/doc/refman/8.0/en/range-optimization.html).

## Đọc EXPLAIN thế nào?

ALL quét bảng; index quét index; range đọc khoảng; ref tra cứu theo khóa không duy nhất; const đọc tối đa một dòng theo điều kiện khóa duy nhất. possible_keys là ứng viên, key là lựa chọn, rows là ước lượng, không phải số dòng đã đo. Using index là covering; Using index condition là đẩy điều kiện xuống storage engine, vẫn có thể đọc bản ghi bảng để lấy amount. Xem [EXPLAIN Output](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html).

## Đo thời gian thế nào?

EXPLAIN ANALYZE trên MySQL 8.0.18+ thực thi câu lệnh, báo thời gian và số dòng thực tế. Dùng môi trường thử nghiệm; profiling là cơ chế cũ đã deprecated. Cần so sánh cùng dữ liệu, tải và trạng thái cache, không suy diễn thời gian môi trường mẫu thành SLA production. Xem [EXPLAIN Statement](https://dev.mysql.com/doc/refman/8.0/en/explain.html).

## Index seek, scan và B-tree?

B-tree giữ khóa có thứ tự. Seek là cách gọi thao tác tìm điểm bắt đầu; range scan tiếp tục qua các khóa thuộc khoảng. MySQL EXPLAIN dùng các type ở trên chứ không hiển thị nhãn “Index Seek”. Quét bảng có thể rẻ hơn nếu bảng nhỏ hoặc cần phần lớn dòng.

## WHERE trước SELECT và tác động của index?

Thứ tự logic đơn giản: FROM/JOIN → WHERE → GROUP BY → HAVING → SELECT → DISTINCT → ORDER BY → LIMIT. Kế hoạch vật lý có thể đổi cách đọc và đẩy bộ lọc; thứ tự logic không phải danh sách thao tác CPU cố định.

Index tăng dung lượng, chi phí ghi và áp lực cache; tạo index có thể chờ metadata lock và tiêu tốn I/O. Index (type,date) không covering cho SUM(amount). Chỉ cân nhắc thêm amount sau khi đo đánh đổi đọc/ghi.

## SELECT có khóa cả bảng không?

Không thể kết luận từ CPU 100%. SELECT nhất quán thông thường của InnoDB thường dùng MVCC; cần kiểm tra engine, isolation level, locking read, metadata lock và resource contention. Tối ưu plan không chứng minh đã khắc phục toàn bộ sự cố đồng thời của production.
