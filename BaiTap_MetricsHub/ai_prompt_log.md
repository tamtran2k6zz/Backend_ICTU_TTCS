# AI prompt log

## Prompt 1 — Chọn công cụ dàn trang

**Prompt:** Với dashboard có thanh điều hướng, các ô KPI kích thước khác nhau và ba thẻ giá, nên phân chia Flexbox, CSS Grid và Bootstrap thế nào? Nêu lý do ngắn gọn.

**Tóm tắt phản hồi:** Dùng Flexbox cho thanh điều hướng một chiều có thể xuống dòng; CSS Grid cho dashboard cần kiểm soát cả hàng và cột, đặc biệt khi widget có kích thước khác nhau; dùng lưới 12 cột và Card của Bootstrap cho ba gói giá để tận dụng breakpoint và cách xếp cột đã có.

## Prompt 2 — Phản biện responsive

**Prompt:** Kiểm tra chiến lược responsive này: navbar flex-wrap, dashboard Grid 4 cột → 2 cột → 1 cột, giá dùng `col-12 col-md-4`. Những trường hợp nào có thể gây tràn ngang?

**Tóm tắt phản hồi:** Nội dung dài trong flex item hoặc grid item có thể ép cột rộng hơn vùng xem. Dùng `min-width: 0`, `minmax(0, 1fr)`, `overflow-wrap: anywhere` cho nhãn dài; ở mobile bỏ các thiết lập span của widget để mọi card thành một cột. Bootstrap cung cấp bố cục giá responsive mà không cần tự viết thêm grid CSS.

## Prompt 3 — Log phần triển khai

**Prompt:** Tạo bản ghi prompt ngắn gọn cho bài thực hành MetricsHub; chỉ ghi lại các quyết định đã dùng, không khẳng định số liệu hiệu năng chưa đo.

**Tóm tắt phản hồi:** Ghi lại hai prompt về lựa chọn layout và kiểm tra responsive. Báo cáo chỉ mô tả cấu trúc, không đưa ra tuyên bố đo đạc hiệu năng.
