# QuickFeed — Dọn index dư thừa

## Chạy thử độc lập

1. Trên CSDL thực hành sạch, chạy `quickfeed_demo_setup.sql` một lần. Script tạo 50.000 bài mẫu và toàn bộ năm index phụ của tình huống legacy.
2. Chạy toàn bộ `quickfeed_index_optimization.sql` một lần. So sánh hai kết quả `SHOW TABLE STATUS` và `information_schema.TABLES`; ba lệnh `DROP INDEX` cần chạy đúng một lần.
3. Ghi số MB từ hai kết quả `information_schema.TABLES` vào bảng trong `storage_performance_report.md`.

Không chạy setup trên database QuickFeed có dữ liệu cần giữ: DDL demo tạo bảng `Posts` và các index mẫu, và không phải công cụ migration. Trên hệ thống đã có bảng legacy, dùng riêng `quickfeed_index_optimization.sql` sau khi xác nhận đúng schema và chụp số liệu trước khi chạy.

## Kế hoạch index

| Index | Quyết định | Lý do |
| --- | --- | --- |
| `idx_user_id` | Giữ | Hỗ trợ lọc bài theo người dùng. |
| `idx_content` | Xóa | Prefix B-tree trên TEXT tốn chỗ, không phải tìm kiếm toàn văn. |
| `idx_post_type` | Xóa | Chỉ ba giá trị, độ chọn lọc thấp theo workload mẫu. |
| `idx_is_visible` | Xóa | Boolean hai giá trị; nhóm phổ biến thường không chọn lọc. |
| `idx_created_at` | Giữ | Hỗ trợ lọc/sắp xếp newsfeed theo thời gian. |

Đây là quyết định theo workload trong đề. Trước khi xóa trên production, phải kiểm tra mọi truy vấn, kế hoạch thực thi và khả năng khôi phục. Dung lượng InnoDB có thể được tái sử dụng trong tablespace mà không làm file vật lý nhỏ đi ngay.

## Nội dung nộp

- `quickfeed_index_optimization.sql`: đo lưu trữ, drop đúng ba index, đo lại và kiểm tra index còn lại.
- `storage_performance_report.md`: báo cáo so sánh dung lượng và đánh đổi Read/Write. Điền số liệu sau khi chạy script.
- `ai_prompt_log.md`: ghi lại nội dung AI đã hỗ trợ.
- `QuickFeed_Submission.zip`: gói ba file nộp cùng setup demo và hướng dẫn.

