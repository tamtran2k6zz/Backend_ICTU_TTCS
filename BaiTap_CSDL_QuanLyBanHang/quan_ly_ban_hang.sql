-- [Bài tập] Xây dựng cơ sở dữ liệu quản lý bán hàng
-- Cơ sở dữ liệu: QuanLyBanHang
-- File: quan_ly_ban_hang.sql

-- Bước 1: Tạo cơ sở dữ liệu QuanLyBanHang
CREATE DATABASE IF NOT EXISTS `QuanLyBanHang`
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Bước 2: Sử dụng cơ sở dữ liệu
USE `QuanLyBanHang`;

-- Bước 3: Tạo bảng Customer (Khách hàng)
CREATE TABLE IF NOT EXISTS `Customer` (
    `cID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cName` VARCHAR(50) NOT NULL,
    `cAge` TINYINT CHECK (`cAge` > 0)
);

-- Bước 4: Tạo bảng Orders (Hóa đơn)
CREATE TABLE IF NOT EXISTS `Orders` (
    `oID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cID` INT NOT NULL,
    `oDate` DATETIME NOT NULL,
    `oTotalPrice` INT NULL,
    CONSTRAINT `fk_orders_customer` FOREIGN KEY (`cID`) REFERENCES `Customer` (`cID`) ON DELETE RESTRICT
);

-- Bước 5: Tạo bảng Product (Sản phẩm)
CREATE TABLE IF NOT EXISTS `Product` (
    `pID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `pName` VARCHAR(100) NOT NULL,
    `pPrice` INT NOT NULL CHECK (`pPrice` >= 0)
);

-- Bước 6: Tạo bảng OrderDetail (Chi tiết hóa đơn - Quan hệ N-N giữa Orders và Product)
CREATE TABLE IF NOT EXISTS `OrderDetail` (
    `oID` INT NOT NULL,
    `pID` INT NOT NULL,
    `odQTY` INT NOT NULL CHECK (`odQTY` > 0),
    PRIMARY KEY (`oID`, `pID`),
    CONSTRAINT `fk_orderdetail_orders` FOREIGN KEY (`oID`) REFERENCES `Orders` (`oID`) ON DELETE CASCADE,
    CONSTRAINT `fk_orderdetail_product` FOREIGN KEY (`pID`) REFERENCES `Product` (`pID`) ON DELETE RESTRICT
);

-- -----------------------------------------------------------------------------
-- PHẦN DỮ LIỆU MẪU KIỂM THỬ (TEST DATA)
-- -----------------------------------------------------------------------------

-- Chèn dữ liệu khách hàng
INSERT INTO `Customer` (`cID`, `cName`, `cAge`) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

-- Chèn dữ liệu hóa đơn
INSERT INTO `Orders` (`oID`, `cID`, `oDate`, `oTotalPrice`) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

-- Chèn dữ liệu sản phẩm
INSERT INTO `Product` (`pID`, `pName`, `pPrice`) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

-- Chèn dữ liệu chi tiết hóa đơn
INSERT INTO `OrderDetail` (`oID`, `pID`, `odQTY`) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- -----------------------------------------------------------------------------
-- TRUY VẤN MẪU KIỂM TRA
-- -----------------------------------------------------------------------------

-- Truy vấn chi tiết các mặt hàng mà mỗi khách hàng đã mua kèm thành tiền từng món
SELECT 
    o.oID AS `MaHoaDon`,
    c.cName AS `TenKhachHang`,
    o.oDate AS `NgayMua`,
    p.pName AS `TenSanPham`,
    od.odQTY AS `SoLuong`,
    p.pPrice AS `DonGia`,
    (od.odQTY * p.pPrice) AS `ThanhTien`
FROM `Orders` o
JOIN `Customer` c ON o.cID = c.cID
JOIN `OrderDetail` od ON o.oID = od.oID
JOIN `Product` p ON od.pID = p.pID
ORDER BY o.oID;
