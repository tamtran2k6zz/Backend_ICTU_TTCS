-- [Thực hành] Tạo bảng trong CSDL
-- Cơ sở dữ liệu: QuanLyDiemThi
-- File: quan_ly_diem_thi.sql

-- Bước 1: Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS QuanLyDiemThi
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Bước 2: Sử dụng cơ sở dữ liệu
USE QuanLyDiemThi;

-- Bước 3: Tạo bảng HocSinh
CREATE TABLE IF NOT EXISTS HocSinh (
    MaHS VARCHAR(20) PRIMARY KEY,
    TenHS VARCHAR(50),
    NgaySinh DATETIME,
    Lop VARCHAR(20),
    GT VARCHAR(20)
);

-- Bước 4: Tạo bảng MonHoc (khóa chính MaMH VARCHAR(50) khớp với kiểu dữ liệu bảng BangDiem)
CREATE TABLE IF NOT EXISTS MonHoc (
    MaMH VARCHAR(50) PRIMARY KEY,
    TenMH VARCHAR(50),
    MaGV VARCHAR(20)
);

-- Bước 5: Tạo bảng BangDiem (bảng liên kết n-n giữa HocSinh và MonHoc)
CREATE TABLE IF NOT EXISTS BangDiem (
    MaHS VARCHAR(20),
    MaMH VARCHAR(50),
    DiemThi INT,
    NgayKT DATETIME,
    PRIMARY KEY (MaHS, MaMH),
    FOREIGN KEY (MaHS) REFERENCES HocSinh(MaHS),
    FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
);

-- Bước 6: Tạo bảng GiaoVien
CREATE TABLE IF NOT EXISTS GiaoVien (
    MaGV VARCHAR(20) PRIMARY KEY,
    TenGV VARCHAR(50),
    SDT VARCHAR(10)
);

-- Bước 7: Bổ sung ràng buộc khóa ngoại cho bảng MonHoc tham chiếu đến GiaoVien
ALTER TABLE MonHoc ADD CONSTRAINT FK_MaGV FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV);

-- -----------------------------------------------------------------------------
-- PHẦN DỮ LIỆU MẪU KIỂM THỬ (TEST DATA)
-- -----------------------------------------------------------------------------

-- Chèn dữ liệu Giáo viên
INSERT INTO GiaoVien (MaGV, TenGV, SDT) VALUES
('GV01', 'Nguyễn Văn An', '0912345678'),
('GV02', 'Trần Thị Mai', '0987654321');

-- Chèn dữ liệu Môn học
INSERT INTO MonHoc (MaMH, TenMH, MaGV) VALUES
('MH01', 'Toán Học', 'GV01'),
('MH02', 'Ngữ Văn', 'GV02');

-- Chèn dữ liệu Học sinh
INSERT INTO HocSinh (MaHS, TenHS, NgaySinh, Lop, GT) VALUES
('HS01', 'Lê Hoàng Nam', '2006-05-15 00:00:00', '12A1', 'Nam'),
('HS02', 'Phạm Mỹ Linh', '2006-09-20 00:00:00', '12A1', 'Nữ');

-- Chèn dữ liệu Bảng điểm
INSERT INTO BangDiem (MaHS, MaMH, DiemThi, NgayKT) VALUES
('HS01', 'MH01', 9, '2024-05-10 08:00:00'),
('HS01', 'MH02', 8, '2024-05-12 08:00:00'),
('HS02', 'MH01', 10, '2024-05-10 08:00:00');

-- Truy vấn kiểm tra kết quả điểm của học sinh
SELECT 
    hs.MaHS,
    hs.TenHS,
    mh.TenMH,
    gv.TenGV AS GiaoVienPhuTrach,
    bd.DiemThi,
    bd.NgayKT
FROM BangDiem bd
JOIN HocSinh hs ON bd.MaHS = hs.MaHS
JOIN MonHoc mh ON bd.MaMH = mh.MaMH
LEFT JOIN GiaoVien gv ON mh.MaGV = gv.MaGV;
