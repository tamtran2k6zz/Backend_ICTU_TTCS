-- [Bài tập] Chuyển đổi ERD sang mô hình quan hệ
-- File: quan_ly_vat_tu.sql
-- CSDL Quản lý xuất nhập vật tư và đơn đặt hàng

CREATE DATABASE IF NOT EXISTS `quan_ly_vat_tu`
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE `quan_ly_vat_tu`;

-- 1. Bảng Nhà cung cấp (NHACC)
CREATE TABLE IF NOT EXISTS `NHACC` (
    `MaNCC` VARCHAR(20) PRIMARY KEY,
    `TenNCC` VARCHAR(255) NOT NULL,
    `DiaChi` VARCHAR(255)
);

-- 2. Bảng Số điện thoại Nhà cung cấp (Tách từ thuộc tính đa trị SDT)
CREATE TABLE IF NOT EXISTS `SODIENTHOAI_NCC` (
    `MaNCC` VARCHAR(20),
    `SDT` VARCHAR(15),
    PRIMARY KEY (`MaNCC`, `SDT`),
    CONSTRAINT `fk_sdt_nhacc` FOREIGN KEY (`MaNCC`) REFERENCES `NHACC` (`MaNCC`) ON DELETE CASCADE
);

-- 3. Bảng Vật tư (VATTU)
CREATE TABLE IF NOT EXISTS `VATTU` (
    `MaVTU` VARCHAR(20) PRIMARY KEY,
    `TenVTU` VARCHAR(255) NOT NULL
);

-- 4. Bảng Phiếu xuất (PHIEUXUAT)
CREATE TABLE IF NOT EXISTS `PHIEUXUAT` (
    `SoPX` VARCHAR(20) PRIMARY KEY,
    `NgayXuat` DATETIME NOT NULL
);

-- 5. Bảng Chi tiết phiếu xuất (Mối quan hệ N-N giữa PHIEUXUAT và VATTU)
CREATE TABLE IF NOT EXISTS `CHITIETPHIEUXUAT` (
    `SoPX` VARCHAR(20),
    `MaVTU` VARCHAR(20),
    `DGXuat` DECIMAL(15, 2) NOT NULL,
    `SLXuat` INT NOT NULL,
    PRIMARY KEY (`SoPX`, `MaVTU`),
    CONSTRAINT `fk_ctpx_phieuxuat` FOREIGN KEY (`SoPX`) REFERENCES `PHIEUXUAT` (`SoPX`) ON DELETE CASCADE,
    CONSTRAINT `fk_ctpx_vattu` FOREIGN KEY (`MaVTU`) REFERENCES `VATTU` (`MaVTU`) ON DELETE RESTRICT
);

-- 6. Bảng Phiếu nhập (PHIEUNHAP)
CREATE TABLE IF NOT EXISTS `PHIEUNHAP` (
    `SoPN` VARCHAR(20) PRIMARY KEY,
    `NgayNhap` DATETIME NOT NULL
);

-- 7. Bảng Chi tiết phiếu nhập (Mối quan hệ N-N giữa VATTU và PHIEUNHAP)
CREATE TABLE IF NOT EXISTS `CHITIETPHIEUNHAP` (
    `SoPN` VARCHAR(20),
    `MaVTU` VARCHAR(20),
    `DGNhap` DECIMAL(15, 2) NOT NULL,
    `SLNhap` INT NOT NULL,
    PRIMARY KEY (`SoPN`, `MaVTU`),
    CONSTRAINT `fk_ctpn_phieunhap` FOREIGN KEY (`SoPN`) REFERENCES `PHIEUNHAP` (`SoPN`) ON DELETE CASCADE,
    CONSTRAINT `fk_ctpn_vattu` FOREIGN KEY (`MaVTU`) REFERENCES `VATTU` (`MaVTU`) ON DELETE RESTRICT
);

-- 8. Bảng Đơn đặt hàng (DONDH) - Quan hệ 1-N với NHACC
CREATE TABLE IF NOT EXISTS `DONDH` (
    `SoDH` VARCHAR(20) PRIMARY KEY,
    `NgayDH` DATETIME NOT NULL,
    `MaNCC` VARCHAR(20) NOT NULL,
    CONSTRAINT `fk_dondh_nhacc` FOREIGN KEY (`MaNCC`) REFERENCES `NHACC` (`MaNCC`) ON DELETE RESTRICT
);

-- 9. Bảng Chi tiết đơn đặt hàng (Mối quan hệ N-N giữa VATTU và DONDH)
CREATE TABLE IF NOT EXISTS `CHITIETDONDATHANG` (
    `SoDH` VARCHAR(20),
    `MaVTU` VARCHAR(20),
    PRIMARY KEY (`SoDH`, `MaVTU`),
    CONSTRAINT `fk_ctdh_dondh` FOREIGN KEY (`SoDH`) REFERENCES `DONDH` (`SoDH`) ON DELETE CASCADE,
    CONSTRAINT `fk_ctdh_vattu` FOREIGN KEY (`MaVTU`) REFERENCES `VATTU` (`MaVTU`) ON DELETE RESTRICT
);

-- -----------------------------------------------------------------------------
-- DỮ LIỆU MẪU KIỂM THỬ (TEST DATA)
-- -----------------------------------------------------------------------------

INSERT INTO `NHACC` (`MaNCC`, `TenNCC`, `DiaChi`) VALUES
('NCC01', 'Công ty Cổ phần Thép Hòa Phát', 'Hà Nội'),
('NCC02', 'Công ty Xi măng Vicem Hoàng Thạch', 'Hải Dương');

-- Chèn nhiều số điện thoại cho 1 nhà cung cấp (thuộc tính đa trị)
INSERT INTO `SODIENTHOAI_NCC` (`MaNCC`, `SDT`) VALUES
('NCC01', '0243123456'),
('NCC01', '0912999888'),
('NCC02', '0220388899');

INSERT INTO `VATTU` (`MaVTU`, `TenVTU`) VALUES
('VT01', 'Thép cuộn Phi 10'),
('VT02', 'Xi măng PCB40');

INSERT INTO `PHIEUXUAT` (`SoPX`, `NgayXuat`) VALUES
('PX01', '2026-10-15 08:30:00');

INSERT INTO `CHITIETPHIEUXUAT` (`SoPX`, `MaVTU`, `DGXuat`, `SLXuat`) VALUES
('PX01', 'VT01', 18500.00, 500);

INSERT INTO `DONDH` (`SoDH`, `NgayDH`, `MaNCC`) VALUES
('DH01', '2026-10-10 14:00:00', 'NCC01');

INSERT INTO `CHITIETDONDATHANG` (`SoDH`, `MaVTU`) VALUES
('DH01', 'VT01'),
('DH01', 'VT02');
