-- [Thực hành] Quản lý đơn đặt hàng
-- File: order_management_schema.sql
-- Triển khai lược đồ CSDL từ mô hình ERD đã chuẩn hóa

CREATE DATABASE IF NOT EXISTS `order_management`
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE `order_management`;

-- 1. Bảng Đơn vị khách (Khách hàng / Đơn vị đặt hàng)
CREATE TABLE IF NOT EXISTS `DON_VI_KHACH` (
    `MaDV` VARCHAR(20) PRIMARY KEY,
    `TenDV` VARCHAR(255) NOT NULL,
    `DiaChi` VARCHAR(255),
    `DienThoai` VARCHAR(20)
);

-- 2. Bảng Hàng hóa
CREATE TABLE IF NOT EXISTS `HANG` (
    `MaHang` VARCHAR(20) PRIMARY KEY,
    `TenHang` VARCHAR(255) NOT NULL,
    `DVTinh` VARCHAR(50),
    `MoTaHang` TEXT
);

-- 3. Bảng Người đặt hàng
CREATE TABLE IF NOT EXISTS `NGUOI_DAT` (
    `MaND` VARCHAR(20) PRIMARY KEY,
    `HoTenND` VARCHAR(150) NOT NULL,
    `MaDV` VARCHAR(20),
    CONSTRAINT `fk_nguoi_dat_don_vi` FOREIGN KEY (`MaDV`) REFERENCES `DON_VI_KHACH` (`MaDV`)
);

-- 4. Bảng Người nhận hàng
CREATE TABLE IF NOT EXISTS `NGUOI_NHAN` (
    `MaNN` VARCHAR(20) PRIMARY KEY,
    `HoTenNN` VARCHAR(150) NOT NULL,
    `MaDV` VARCHAR(20),
    CONSTRAINT `fk_nguoi_nhan_don_vi` FOREIGN KEY (`MaDV`) REFERENCES `DON_VI_KHACH` (`MaDV`)
);

-- 5. Bảng Người giao hàng
CREATE TABLE IF NOT EXISTS `NGUOI_GIAO` (
    `MaNG` VARCHAR(20) PRIMARY KEY,
    `HoTenNG` VARCHAR(150) NOT NULL
);

-- 6. Bảng Nơi giao hàng
CREATE TABLE IF NOT EXISTS `NOI_GIAO` (
    `MaDDG` VARCHAR(20) PRIMARY KEY,
    `TenNoiGiao` VARCHAR(255) NOT NULL
);

-- 7. Bảng Đơn đặt hàng
CREATE TABLE IF NOT EXISTS `DON_DAT_HANG` (
    `SoDH` VARCHAR(20) PRIMARY KEY,
    `NgayDat` DATE NOT NULL,
    `MaND` VARCHAR(20),
    CONSTRAINT `fk_don_dat_nguoi_dat` FOREIGN KEY (`MaND`) REFERENCES `NGUOI_DAT` (`MaND`)
);

-- 8. Bảng Chi tiết đặt hàng
CREATE TABLE IF NOT EXISTS `CHI_TIET_DAT_HANG` (
    `SoDH` VARCHAR(20),
    `MaHang` VARCHAR(20),
    `SoLuong` INT NOT NULL,
    PRIMARY KEY (`SoDH`, `MaHang`),
    CONSTRAINT `fk_ctdh_don_hang` FOREIGN KEY (`SoDH`) REFERENCES `DON_DAT_HANG` (`SoDH`),
    CONSTRAINT `fk_ctdh_hang` FOREIGN KEY (`MaHang`) REFERENCES `HANG` (`MaHang`)
);

-- 9. Bảng Phiếu giao hàng
CREATE TABLE IF NOT EXISTS `PHIEU_GIAO_HANG` (
    `SoPG` VARCHAR(20) PRIMARY KEY,
    `NgayGiao` DATE NOT NULL,
    `MaNG` VARCHAR(20),
    `MaNN` VARCHAR(20),
    `MaDDG` VARCHAR(20),
    CONSTRAINT `fk_pgh_nguoi_giao` FOREIGN KEY (`MaNG`) REFERENCES `NGUOI_GIAO` (`MaNG`),
    CONSTRAINT `fk_pgh_nguoi_nhan` FOREIGN KEY (`MaNN`) REFERENCES `NGUOI_NHAN` (`MaNN`),
    CONSTRAINT `fk_pgh_noi_giao` FOREIGN KEY (`MaDDG`) REFERENCES `NOI_GIAO` (`MaDDG`)
);

-- 10. Bảng Chi tiết giao hàng
CREATE TABLE IF NOT EXISTS `CHI_TIET_GIAO_HANG` (
    `SoPG` VARCHAR(20),
    `MaHang` VARCHAR(20),
    `SoLuong` INT NOT NULL,
    `DonGia` DECIMAL(15, 2) NOT NULL,
    `ThanhTien` DECIMAL(15, 2) GENERATED ALWAYS AS (`SoLuong` * `DonGia`) STORED,
    PRIMARY KEY (`SoPG`, `MaHang`),
    CONSTRAINT `fk_ctgh_phieu_giao` FOREIGN KEY (`SoPG`) REFERENCES `PHIEU_GIAO_HANG` (`SoPG`),
    CONSTRAINT `fk_ctgh_hang` FOREIGN KEY (`MaHang`) REFERENCES `HANG` (`MaHang`)
);
