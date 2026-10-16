# Nhật ký hỗ trợ AI

Đề được cung cấp đầy đủ trong yêu cầu. AI đã hỗ trợ thiết kế script demo, phân tích index và soạn báo cáo; nhật ký này không khẳng định học viên tự thực hiện các cuộc hội thoại riêng.

## Cardinality và index cột ít giá trị

Cardinality là số giá trị riêng biệt trong cột hoặc index. Với bảng có 50.000 dòng mà `is_visible` chỉ có hai giá trị và 99% dòng là 1, lọc `is_visible = 1` vẫn trả gần toàn bảng. Dò index rồi đọc phần lớn dòng có thể tốn hơn quét bảng tuần tự, nên optimizer có thể bỏ index. Selectivity, kích thước bảng và thống kê đều ảnh hưởng quyết định; low cardinality không có nghĩa index luôn vô dụng (ví dụ workload chỉ đọc nhóm hiếm `is_visible = 0`).

## Over-indexing và ghi dữ liệu

Mỗi secondary index chiếm trang dữ liệu và cache, đồng thời cần được cập nhật khi INSERT/UPDATE/DELETE đổi giá trị khóa. Năm secondary index trong script là các cấu trúc cần duy trì riêng, cộng clustered primary key. Bỏ ba index nghĩa là giảm ba index phụ phải xử lý khi chèn row; không nên diễn đạt thành chính xác ba thao tác ghi đĩa vì B-tree có page split, buffer pool và ghi theo lô.

`content(255)` chỉ đánh index một tiền tố, không cung cấp tìm kiếm toàn văn đầy đủ. FULLTEXT phù hợp truy vấn từ khóa/ngôn ngữ, nhưng có semantics và chi phí riêng, nên chỉ thêm khi ứng dụng cần.

## Dung lượng và quyết định bảo toàn

`information_schema.TABLES` cung cấp `DATA_LENGTH` và `INDEX_LENGTH` dạng byte. Với InnoDB đây là số liệu engine ước tính theo trang; sau DROP, trang được trả vào tablespace có thể được tái sử dụng mà không thu nhỏ ngay file tablespace trên hệ điều hành. Kế hoạch chỉ DROP đúng `idx_content`, `idx_post_type`, `idx_is_visible`; giữ primary key, `idx_user_id`, `idx_created_at` theo workload giả định của đề. Cần đo trước/sau trên cùng dữ liệu và xác nhận các truy vấn đọc không bị ảnh hưởng đáng kể.
