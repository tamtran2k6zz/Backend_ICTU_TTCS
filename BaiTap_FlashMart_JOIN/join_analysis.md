# Phân tích JOIN

`JOIN` mặc định là `INNER JOIN`: chỉ giữ cặp khớp, nên Charlie biến mất. `Customers` phải là bảng trái của `LEFT JOIN` để giữ mọi khách hàng. `Products` là bảng trái của báo cáo kho; `WHERE o.order_id IS NULL` chọn sản phẩm không có đơn. Với `INNER JOIN`, khóa chính đơn hàng luôn khác NULL nên bộ lọc này không trả dòng nào.

`COUNT(*)` đếm cả dòng được LEFT JOIN bổ sung khi không có đơn, khiến Charlie có 1. `COUNT(o.order_id)` bỏ qua NULL, trả 0 cho Charlie, 2 cho Alice và 1 cho Bob. Khóa chính không thể NULL nên phân biệt được đơn thực và dòng bổ sung. Nhóm theo cả mã và tên để không gộp khách trùng tên.
