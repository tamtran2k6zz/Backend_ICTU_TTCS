# PayFlow — Tối ưu báo cáo bằng EXPLAIN và index

## Cách chạy

1. MySQL 8.0, CSDL thực hành chưa có bảng Transactions: chạy `setup_demo.sql` một lần. File tạo schema và 100.004 dòng mô phỏng; không xóa dữ liệu có sẵn.
2. Chạy `payflow_optimized.sql` một lần để lấy plan cũ, tạo index, lấy plan mới và đối chiếu tổng tiền. Nếu index đã tồn tại, chỉ chọn chạy các câu SELECT/EXPLAIN cần thiết.
3. `totals_match` phải là 1. Khoảng nửa mở nhận đúng đầu tháng 6, loại đầu tháng 7 và loại WITHDRAW.

Trên CSDL đã có bảng và dữ liệu đúng cấu trúc đề bài, bỏ bước tạo dữ liệu mẫu. File tối ưu không tạo lại bảng và không chỉnh sửa số tiền. Câu đối chiếu legacy quét nhiều dữ liệu, chỉ dùng khi kiểm tra trong môi trường phù hợp.

Khoảng báo cáo là tháng 6/2026 theo đề; DATETIME không tự đổi múi giờ. Các mốc phải cùng quy ước thời gian với created_at. Giữ nguyên SUM: nếu không có giá trị amount khác NULL thỏa điều kiện, kết quả vẫn NULL như truy vấn cũ.

## Kiểm tra thực tế

MySQL 8.0.46: plan đổi từ ALL (rows 99.855) sang range (rows 241), dùng idx_type_date. Tổng hai truy vấn đều 15.837,20, totals_match = 1. Xem `actual_explain.txt` để đọc output gốc. Số rows là ước lượng của optimizer.

`actual_explain.png` là ảnh xuất từ output CLI thực tế, không phải ảnh chụp Console. Đề yêu cầu ảnh chụp Console; nếu cần đúng hình thức này, mở file SQL và chụp hai bảng EXPLAIN trong Workbench.

## Gói bài

Gói `PayFlow_Submission.zip` chứa SQL, phân tích EXPLAIN dưới 200 từ, nhật ký AI và bằng chứng kiểm tra. Dữ liệu mô phỏng nhỏ hơn 5 triệu dòng của bối cảnh; không đưa ra số đo production.

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/payflow-explain-index/BaiTap_PayFlow_EXPLAIN_Index
