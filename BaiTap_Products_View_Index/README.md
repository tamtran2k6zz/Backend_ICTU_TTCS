# [Bài tập] View, Index, Stored Procedure

## Cách chạy

1. Chạy `setup_demo.sql` một lần trên MySQL. Script tạo CSDL riêng `demo_products_db`, bảng `Products` và 1.000 sản phẩm; ngoài khóa chính chưa có index phụ.
2. Chạy `index_and_view.sql` một lần để so sánh EXPLAIN trước/sau khi tạo index, rồi tạo, sửa và xóa view.
3. Chạy `product_procedures.sql` để tạo bốn stored procedure.
4. Chạy `product_procedure_demo.sql` để gọi thủ tục thêm, cập nhật, xóa sản phẩm. `getAllProducts()` trả cả 1.000 dòng nên lệnh gọi được để comment; bỏ comment nếu muốn xem toàn bộ.

Script không xóa dữ liệu sẵn có. Chọn CSDL thực hành mới: bộ setup chạy một lần, còn file index tạo named indexes và cũng nên chạy một lần. Các thủ tục có thể tạo lại an toàn bằng `DROP PROCEDURE IF EXISTS`. View được xóa ở cuối bài như yêu cầu.

## Nội dung

- Unique index `idx_product_code` trên `productCode`.
- Composite index `idx_product_name_price` trên `(productName, productPrice)`.
- Hai cặp `EXPLAIN` để so sánh plan tra cứu theo mã duy nhất và theo tên/giá; xem `type`, `possible_keys`, `key`, `rows`, `Extra`.
- View ban đầu chiếu bốn cột, sau đó định nghĩa lại chỉ lấy sản phẩm đang hoạt động, rồi xóa.
- `getAllProducts()`, `addProduct(...)`, `updateProduct(...)`, `deleteProduct(...)`.

Dữ liệu mẫu có đủ độ lớn để optimizer thấy các chỉ mục, nhưng kết quả EXPLAIN phụ thuộc phiên bản, thống kê và selectivity. `rows` là ước lượng; bảng nhỏ có thể khiến optimizer chọn table scan.

## Nộp bài

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/products-view-index-procedures/BaiTap_Products_View_Index
