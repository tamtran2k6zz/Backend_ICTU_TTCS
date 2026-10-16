# Báo cáo lưu trữ và hiệu năng

Chạy `quickfeed_index_optimization.sql` trên bộ demo 50.000 bài và ghi số MB ở hai result grid vào bảng dưới. Đây là số liệu của instance MySQL được dùng khi nộp, không phải dự đoán cho máy chủ sản xuất. InnoDB cấp phát trang theo đơn vị, nên dung lượng có thể không giảm ngay đúng bằng tổng kích thước ước tính các khóa.

| Đo lường | Trước | Sau |
| --- | ---: | ---: |
| Data length (MB) |  |  |
| Index length (MB) |  |  |
| Tổng (MB) |  |  |
| Index length giảm (MB) | — |  |

Mỗi index phụ cần lưu khóa và tham chiếu dòng trong cấu trúc B-tree. Khi thêm bài, InnoDB phải duy trì từng index liên quan ngoài clustered primary key. Xóa ba index phụ giảm ba cấu trúc phải cập nhật cho mỗi lần INSERT, cùng chi phí lưu trữ và cache; số lần thao tác trang vật lý không cố định là ba vì còn phân trang, split và buffer pool. `idx_user_id` hỗ trợ lọc bài theo người dùng; `idx_created_at` phục vụ truy vấn theo thời gian. `post_type` chỉ có ba giá trị, `is_visible` chỉ có hai nên thường chọn lọc kém; nội dung dài không phù hợp B-tree prefix index như một giải pháp tìm từ khóa. Nếu cần tìm văn bản, xem xét FULLTEXT theo cú pháp và nhu cầu tìm kiếm, rồi đo lại chi phí ghi.

Dung lượng từ `information_schema.TABLES` là số liệu thống kê của engine, không phải phép đo byte đĩa chính xác theo từng index. Việc bỏ index giúp INSERT nhưng có thể làm các truy vấn chỉ lọc theo cột đã bỏ chậm hơn; cần kiểm tra truy vấn thực tế trước khi áp dụng production.
