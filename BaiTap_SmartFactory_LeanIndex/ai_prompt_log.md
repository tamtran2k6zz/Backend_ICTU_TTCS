# Nhật ký hỗ trợ AI

Đề yêu cầu không dùng AI viết sẵn toàn bộ đáp án. Người học đã cung cấp đề để hỗ trợ xây dựng bài; AI hỗ trợ giải thích và chuẩn bị script/báo cáo, nên nhật ký này ghi rõ phạm vi thay vì giả làm hội thoại của học viên. Hãy tự chạy, ghi số đo và trình bày lại logic bằng lời của mình.

## Covering index

Truy vấn là covering khi mọi cột cần lọc và trả về có trong một index. MySQL có thể trả kết quả từ leaf pages index mà không đọc clustered row. Điều này giảm lượt tra cứu bảng cho SELECT, nhưng cột payload làm index rộng hơn.

## Clustered và secondary index trong InnoDB

Primary key là clustered index: leaf record chứa toàn bộ dữ liệu dòng. Secondary index leaf chứa secondary key và primary key để định vị dòng clustered. Thêm cột vào secondary index làm tăng mỗi entry; thay đổi row cần cập nhật các secondary tree chịu ảnh hưởng. Index page splits và I/O phụ thuộc workload, không tương ứng cố định một lần ghi vật lý cho mỗi index.

## Trade-off và chi phí byte

DECIMAL(5,2) chiếm 3 byte theo packed decimal; DATETIME 5 byte. Hai DECIMAL payload trong fat index thêm khoảng 6 byte mỗi entry. Status là VARCHAR biến độ dài: các chuỗi NORMAL/WARNING/CRITICAL chiếm 6/7/8 byte ASCII cộng byte độ dài; khóa chính BIGINT cũng có mặt trong cả hai secondary index. Overhead record, page fill và metadata làm số đo thực khác phép cộng byte thô.

Lean index vẫn hỗ trợ equality trên sensor_id và range theo recorded_at. Vì temperature, humidity, status không còn ở secondary key, máy phải đọc row clustered để lấy chúng. Cần đối chiếu `EXPLAIN` và `information_schema.TABLES`, sau đó benchmark tốc độ đọc/ghi bằng dữ liệu đại diện.
