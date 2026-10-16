# [Thực hành] Trigger trong MySQL

Tạo trigger `BEFORE INSERT` để tự chọn phòng ban dựa trên lương nhân viên.

## Cách chạy

1. Mở [company_trigger.sql](company_trigger.sql) trong MySQL Workbench và chạy toàn bộ. File tạo database/bảng nếu chưa có và thay trigger `update_department` nếu trigger đó đã tồn tại.
2. Mở [demo_employees.sql](demo_employees.sql) và chạy một lần trên bảng chưa có dữ liệu demo. Giá trị `department = 'A'` chỉ là giá trị truyền vào để minh họa; trigger ghi phòng ban theo mức lương.
3. Xem kết quả truy vấn cuối: John Doe thành Sales, Jane Smith thành Support, David Johnson thành Management.

Ngưỡng theo ví dụ: lương từ 5.000 trở lên là Management; từ 3.000 đến dưới 5.000 là Sales; dưới 3.000 là Support. `NEW.department` cho phép trigger `BEFORE INSERT` thay giá trị của dòng sắp được thêm. Đây là quy tắc thực hành, không phải chính sách nhân sự áp dụng thực tế.

Chạy lại file tạo trigger an toàn. File demo INSERT cần chạy một lần; chạy lại sẽ thêm bản ghi mới vì cột `id` tự tăng. Trigger này chỉ chạy khi INSERT, không tự phân loại lại nhân viên khi salary được UPDATE.

## Nộp bài

https://github.com/tamtran2k6zz/Backend_ICTU_TTCS/tree/codex/mysql-trigger-practice/ThucHanh_MySQL_Trigger
