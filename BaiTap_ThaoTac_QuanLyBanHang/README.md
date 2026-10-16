# [Bài tập] Thao tác với CSDL Quản lý bán hàng

## Chuẩn bị dữ liệu

Chạy [quan_ly_ban_hang.sql](../BaiTap_CSDL_QuanLyBanHang/quan_ly_ban_hang.sql) từ bài xây dựng CSDL trước trên CSDL thực hành có bốn bảng rỗng. File đã có đầy đủ câu lệnh tạo bảng và INSERT đúng dữ liệu đề này: 3 khách hàng, 3 hóa đơn, 5 sản phẩm, 7 chi tiết hóa đơn. Chỉ nạp dữ liệu một lần để tránh trùng khóa chính.

Sau đó mở và chạy toàn bộ [sales_queries.sql](sales_queries.sql) trong MySQL Workbench. Nếu đã có đúng dữ liệu mẫu, chỉ chạy file truy vấn.

## Quy ước tên

Cấu trúc kế thừa dùng `Orders` thay cho `Order` (từ khóa SQL), `cName` thay cho `Name` và `oTotalPrice` cho tổng tiền lưu trong hóa đơn. Truy vấn đầu dùng alias `oPrice` theo yêu cầu đề; ba giá trị này là NULL đúng dữ liệu đầu vào. Truy vấn cuối tính tổng từ chi tiết, không cập nhật cột tổng tiền đã lưu.

## Kết quả mong đợi

- Câu 1: 3 hóa đơn với ngày 2006-03-21, 2006-03-23, 2006-03-16 và oPrice = NULL.
- Câu 2a: 2 khách hàng Minh Quan và Ngoc Oanh.
- Câu 2b: 6 cặp khách hàng–sản phẩm: Minh Quan mua May Giat, Dieu Hoa, Quat; Ngoc Oanh mua May Giat, Dieu Hoa, Bep Dien. DISTINCT tránh lặp May Giat của Minh Quan qua hai hóa đơn.
- Câu 3: Hong Ha. NOT EXISTS kiểm tra khách không có chi tiết mua hàng, kể cả trường hợp có hóa đơn rỗng.
- Câu 4: tổng tiền như bảng dưới. LEFT JOIN giữ cả hóa đơn rỗng, trả tổng 0 bằng COALESCE.

| oID | oDate | oPrice | Phép tính |
| --- | --- | --- | --- |
| 1 | 2006-03-21 00:00:00 | 60 | 3 × 3 + 7 × 7 + 2 × 1 |
| 2 | 2006-03-23 00:00:00 | 32 | 1 × 3 + 4 × 2 + 3 × 7 |
| 3 | 2006-03-16 00:00:00 | 24 | 8 × 3 |

Đơn vị tiền giữ nguyên như đề bài. Sản phẩm Tu Lanh chưa được mua.

## Kiểm tra thực tế

Đã chạy file tạo bảng và nạp dữ liệu kế thừa, sau đó chạy toàn bộ truy vấn trên MySQL 8.0.46 trong instance thực hành tạm. Kết quả khớp các bảng trên. Output được lưu tại [actual_results.txt](actual_results.txt).

## Nộp bài

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/sales-management-queries/BaiTap_ThaoTac_QuanLyBanHang
