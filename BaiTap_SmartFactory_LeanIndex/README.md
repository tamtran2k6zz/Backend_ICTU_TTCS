# SmartFactory — Thiết kế lean index

## Chạy demo

1. Trên CSDL thực hành mới, chạy `smartfactory_demo_setup.sql` một lần. Nó tạo 100.000 dòng log cùng fat covering index.
2. Chạy `smartfactory_reindex.sql` một lần. So sánh `Index_length`/`index_mb` và hai kết quả EXPLAIN trước, sau.
3. Ghi số đo thực tế vào `index_tradeoff_report.md`.

Trên hệ thống đã có bảng legacy đúng schema và `idx_fat_covering`, bỏ bước setup và chỉ chạy script chuyển index. DDL này tác động lên bảng thật, nên xuất số liệu/backup trước khi áp dụng production.

Plan trước dự kiến có `key = idx_fat_covering` và `Extra = Using index`. Plan sau dự kiến có `key = idx_lean_search`, `type = range`, không có `Using index` vì phải đọc clustered row để lấy temperature, humidity, status. Optimizer phụ thuộc thống kê và kích thước dữ liệu; kiểm tra output thật.

Dataset demo có cảm biến 105 với log từ đầu tháng 6/2026; truy vấn từ 20/6 trả nhiều dòng để EXPLAIN thấy phạm vi. Dữ liệu mẫu không tái hiện lưu lượng hàng chục nghìn bản ghi/giây. Số giảm 70%, tăng tốc năm lần và mili giây trong đề là minh họa, không phải kết quả đã benchmark.

## Nội dung nộp

- `smartfactory_reindex.sql`
- `index_tradeoff_report.md`
- `ai_prompt_log.md`
- `SmartFactory_Submission.zip`
