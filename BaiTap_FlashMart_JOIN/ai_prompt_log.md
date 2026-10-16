# Nhật ký hỗ trợ AI

## Phạm vi thực tế

Người dùng gửi toàn bộ đề và yêu cầu làm bài qua file đính kèm. AI đã tạo SQL, tài liệu và thực hiện kiểm tra trong phiên này. Nhật ký dưới đây ghi các chủ đề AI phân tích, không giả định học viên đã tự hỏi hoặc tự viết đáp án. Quy trình này khác quy tắc hạn chế AI của đề; học viên cần tự thực hành và giải thích lại trước khi nộp.

## 1. JOIN mặc định giữ những dòng nào?

Trong bài này, JOIN là INNER JOIN, chỉ giữ cặp thỏa ON. Theo tập hợp khóa khách hàng: Customers = {1,2,3}, Orders = {1,2}; giao là {1,2}, nên Charlie bị loại. LEFT JOIN giữ {1,2,3}, bổ sung NULL phía Orders cho khóa 3.

## 2. LEFT JOIN nên dùng COUNT nào?

COUNT(*) đếm mọi dòng; COUNT(o.order_id) chỉ đếm giá trị khác NULL. Dòng bổ sung của Charlie vẫn tồn tại nhưng không có khóa đơn, nên hai phép đếm lần lượt trả 1 và 0. Xem [MySQL Aggregate Functions](https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html).

## 3. Anti-join so với NOT IN?

LEFT JOIN ... IS NULL tìm dòng không có đối tác. Với cột kiểm tra NOT NULL, MySQL có thể dừng dò sau đối tác đầu tiên. Xem [Outer Join Optimization](https://dev.mysql.com/doc/refman/8.0/en/outer-join-optimization.html).

NOT IN dễ sai khi subquery trả NULL: với một khóa không khớp, phép so sánh có thể thành UNKNOWN và bị WHERE loại. NOT EXISTS tránh bẫy này. Không thể kết luận cách nào luôn nhanh hơn; cần EXPLAIN ANALYZE trên dữ liệu đại diện.

## 4. Nested-loop hoạt động thế nào?

Nested-loop lấy từng dòng ngoài và tìm dòng khớp phía trong. Index Orders(customer_id) và Orders(product_id) hỗ trợ tra cứu. Với dữ liệu nhỏ, optimizer vẫn có thể chọn quét bảng. MySQL 8.0.20 bỏ block nested-loop để dùng hash join ở các trường hợp phù hợp; không phải mọi JOIN đều chạy nested-loop. Xem [Nested-Loop Join Algorithms](https://dev.mysql.com/doc/refman/8.0/en/nested-loop-joins.html).

## 5. Nếu đổi sang RIGHT JOIN mà giữ thứ tự bảng?

Customers RIGHT JOIN Orders giữ mọi Orders; Charlie vẫn mất vì không có đơn. Với khóa ngoại hợp lệ của bài, kết quả nhóm khách có đơn giống INNER JOIN.

## 6. CROSS JOIN và nguy cơ nhân bản dòng?

CROSS JOIN tạo tích Descartes: 3 khách × 3 đơn = 9 dòng. Thiếu điều kiện nối hoặc ON luôn đúng có thể tạo tích tương tự. Dữ liệu lớn làm số dòng trung gian tăng mạnh, tốn CPU, bộ nhớ và thời gian; không phải mọi CROSS JOIN đều sai.

## 7. Giả lập FULL OUTER JOIN?

Ghép nhánh LEFT JOIN với nhánh RIGHT JOIN chỉ giữ các dòng không có phía trái bằng UNION ALL. Bộ lọc nhánh thứ hai tránh đếm hai lần phần giao; UNION đơn thuần có thể xóa các dòng trùng hợp lệ. Đây là kiến thức mở rộng, không cần cho hai báo cáo của bài.
