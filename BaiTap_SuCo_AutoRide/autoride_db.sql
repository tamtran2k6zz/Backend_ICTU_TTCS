-- =============================================================================
-- HỆ THỐNG QUẢN LÝ CHO THUÊ XE TỰ LÁI AUTORIDE (OPTIMIZED DATABASE)
-- Tác giả: Data Architect
-- Mục tiêu: Chuẩn hóa dữ liệu, khắc phục lỗi bốc hơi lợi nhuận và đồng bộ với Activity Diagram
-- =============================================================================

CREATE DATABASE IF NOT EXISTS autoride_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE autoride_db;

-- -----------------------------------------------------------------------------
-- 1. TẠO CÁC BẢNG CƠ SỞ
-- -----------------------------------------------------------------------------

-- Bảng Xe (Cars)
CREATE TABLE IF NOT EXISTS Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL,
    status ENUM('AVAILABLE', 'RENTED', 'MAINTENANCE') NOT NULL DEFAULT 'AVAILABLE'
);

-- Bảng Hợp đồng thuê xe (Rentals) - TÁI CẤU TRÚC HOÀN TOÀN
DROP TABLE IF EXISTS Inspections;
DROP TABLE IF EXISTS Rentals;

CREATE TABLE Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME NULL,
    
    -- Khóa chặt vòng đời hợp đồng bằng ENUM
    status ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'BOOKED',
    
    -- Các trường tài chính sử dụng DECIMAL(12,2) chuẩn xác, tránh lỗi làm tròn
    security_deposit DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    late_fee DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    damage_fee DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_rentals_cars FOREIGN KEY (car_id) REFERENCES Cars(car_id) ON DELETE RESTRICT
);

-- Bảng Biên bản kiểm tra tình trạng xe (Inspections)
CREATE TABLE Inspections (
    inspection_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    damage_description TEXT NOT NULL,
    inspector_name VARCHAR(100) NOT NULL,
    
    CONSTRAINT fk_inspections_rentals FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id) ON DELETE RESTRICT
);

-- -----------------------------------------------------------------------------
-- 2. TOÀN VẸN NGHIỆP VỤ: DATABASE TRIGGER
-- Ngăn chặn tạo biên bản kiểm tra xe khi khách chưa nhận xe (status = 'BOOKED')
-- -----------------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_before_insert_inspection;

DELIMITER $$
CREATE TRIGGER trg_before_insert_inspection
BEFORE INSERT ON Inspections
FOR EACH ROW
BEGIN
    DECLARE current_status VARCHAR(20);
    
    SELECT status INTO current_status
    FROM Rentals
    WHERE rental_id = NEW.rental_id;
    
    IF current_status = 'BOOKED' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi nghiệp vụ: Khách hàng chưa nhận xe (BOOKED), không thể thực hiện kiểm tra trả xe!';
    END IF;
END$$
DELIMITER ;

-- -----------------------------------------------------------------------------
-- 3. MÔ PHỎNG VẬN HÀNH THỰC TẾ (DML SCENARIOS)
-- Kịch bản: Khách "Nguyen Van A" thuê xe, đóng cọc 10.000.000 VNĐ -> Trả xe trễ và vỡ đèn pha
-- -----------------------------------------------------------------------------

-- Chèn dữ liệu xe vào kho
INSERT INTO Cars (car_id, model_name, license_plate) VALUES
(1, 'Toyota Camry 2.5Q', '30G-888.88'),
(2, 'Mazda CX-5 2.0 Premium', '29A-999.99');

-- Bước 1: Khách hàng "Nguyen Van A" thuê xe, đóng cọc 10.000.000đ, trạng thái ACTIVE (đã nhận xe)
INSERT INTO Rentals (rental_id, car_id, customer_name, rent_date, return_date, status, security_deposit)
VALUES (1, 1, 'Nguyen Van A', '2026-10-10 08:00:00', '2026-10-15 18:00:00', 'ACTIVE', 10000000.00);

-- Bước 2: Khách mang xe tới trả. Nhân viên "Tran Van B" kiểm tra phát hiện vỡ đèn pha
INSERT INTO Inspections (rental_id, inspection_date, damage_description, inspector_name)
VALUES (1, '2026-10-15 18:30:00', 'Vỡ cụm đèn pha LED phía trước bên trái, trầy xước cản trước', 'Tran Van B');

-- Bước 3: Cập nhật hợp đồng sang COMPLETED, ghi nhận không trễ hạn (late_fee = 0), phí sửa chữa damage_fee = 2.000.000đ
UPDATE Rentals
SET status = 'COMPLETED',
    return_date = '2026-10-15 18:30:00',
    late_fee = 0.00,
    damage_fee = 2000000.00
WHERE rental_id = 1;

-- -----------------------------------------------------------------------------
-- 4. TRUY VẤN TÍNH TOÁN TIỀN HOÀN CỌC VÀ ĐỐI SOÁT TÀI CHÍNH
-- Công thức: Tiền hoàn trả = Tiền cọc - Phí trễ hạn - Phí sửa chữa
-- -----------------------------------------------------------------------------

SELECT 
    r.rental_id AS `MaHopDong`,
    r.customer_name AS `KhachHang`,
    c.model_name AS `DongXe`,
    c.license_plate AS `BienSo`,
    r.status AS `TrangThai`,
    r.security_deposit AS `TienCoc`,
    r.late_fee AS `PhatTreGio`,
    r.damage_fee AS `BoiThuongHuHong`,
    (r.security_deposit - r.late_fee - r.damage_fee) AS `TienThucTeHoanTra`,
    i.damage_description AS `BienBanKiemTra`,
    i.inspector_name AS `NhanVienKiemTra`
FROM Rentals r
JOIN Cars c ON r.car_id = c.car_id
LEFT JOIN Inspections i ON r.rental_id = i.rental_id
WHERE r.rental_id = 1;
