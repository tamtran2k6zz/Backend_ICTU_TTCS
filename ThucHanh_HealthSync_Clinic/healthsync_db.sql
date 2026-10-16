-- =============================================================================
-- HỆ THỐNG PHÒNG KHÁM ĐA KHOA HEALTHSYNC (OPTIMIZED DATABASE)
-- Tác giả: System Analyst & Database Administrator
-- Mục tiêu: Khắc phục toàn bộ data gaps so với UML Activity Diagram
-- =============================================================================

CREATE DATABASE IF NOT EXISTS healthsync_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE healthsync_db;

-- -----------------------------------------------------------------------------
-- 1. TẠO CÁC BẢNG CƠ BẢN
-- -----------------------------------------------------------------------------

-- Bảng Bệnh nhân (Patients)
CREATE TABLE IF NOT EXISTS Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Bác sĩ (Doctors)
CREATE TABLE IF NOT EXISTS Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(50) NOT NULL
);

-- Bảng Lịch hẹn (Appointments) - TÁI CẤU TRÚC CHUẨN HÓA 100% THEO ACTIVITY DIAGRAM
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Appointments;

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    
    -- Thay thế cờ Boolean bằng ENUM chuẩn phản ánh máy trạng thái 5 bước
    status ENUM('PENDING', 'CONFIRMED', 'CHECKED_IN', 'COMPLETED', 'CANCELLED') 
        NOT NULL DEFAULT 'PENDING',
        
    -- Sử dụng DECIMAL(12,2) để lưu trữ dòng tiền chính xác, không sai số làm tròn
    deposit_amount DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    penalty_fee DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    
    -- Ghi nhận lý do hủy phục vụ kiểm toán và phân tích chất lượng dịch vụ
    cancel_reason VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_appointments_patient FOREIGN KEY (patient_id) 
        REFERENCES Patients(patient_id) ON DELETE RESTRICT,
    CONSTRAINT fk_appointments_doctor FOREIGN KEY (doctor_id) 
        REFERENCES Doctors(doctor_id) ON DELETE RESTRICT
);

-- Bảng Đơn thuốc (Prescriptions) - BỔ SUNG ĐẦY ĐỦ KHÓA CHÍNH VÀ NGOẠI
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE, -- Đảm bảo mỗi lịch hẹn hoàn tất có duy nhất 1 đơn thuốc chính thức (1-1)
    medication_details TEXT NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    issued_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_prescriptions_appointment FOREIGN KEY (appointment_id) 
        REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- -----------------------------------------------------------------------------
-- 2. BẢO VỆ TOÀN VẸN NGHIỆP VỤ: DATABASE TRIGGER
-- Ngăn chặn kê đơn thuốc trái phép khi lịch hẹn CHƯA ở trạng thái 'COMPLETED'
-- -----------------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_before_insert_prescription;

DELIMITER $$
CREATE TRIGGER trg_before_insert_prescription
BEFORE INSERT ON Prescriptions
FOR EACH ROW
BEGIN
    DECLARE current_app_status VARCHAR(20);
    
    SELECT status INTO current_app_status
    FROM Appointments
    WHERE appointment_id = NEW.appointment_id;
    
    IF current_app_status IS NULL OR current_app_status != 'COMPLETED' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi nghiệp vụ: Chỉ có thể kê đơn thuốc cho lịch hẹn đã hoàn thành (COMPLETED)!';
    END IF;
END$$
DELIMITER ;

-- -----------------------------------------------------------------------------
-- 3. MÔ PHỎNG VẬN HÀNH DỮ LIỆU THỰC TẾ (DML SCENARIOS)
-- -----------------------------------------------------------------------------

-- Chèn dữ liệu ban đầu
INSERT INTO Patients (patient_id, full_name, phone) VALUES 
(1, 'Trần Minh Hoàng', '0901234567'),
(2, 'Lê Thị Thu Thảo', '0987654321');

INSERT INTO Doctors (doctor_id, full_name, specialty) VALUES 
(1, 'BS. CKI Nguyễn Văn Bình', 'Nội khoa'),
(2, 'ThS. BS Trần Phương Mai', 'Tim mạch');

-- KỊCH BẢN 1: QUY TRÌNH KHÁM THÀNH CÔNG VÀ KÊ ĐƠN
-- 1. Bệnh nhân đặt lịch, trạng thái PENDING với tiền cọc 500.000 VNĐ
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status, deposit_amount)
VALUES (101, 1, 1, '2026-10-18 09:00:00', 'PENDING', 500000.00);

-- 2. Hệ thống xác nhận đã thanh toán tiền cọc -> CONFIRMED
UPDATE Appointments 
SET status = 'CONFIRMED' 
WHERE appointment_id = 101;

-- 3. Bệnh nhân tới phòng khám, lễ tân check-in -> CHECKED_IN
UPDATE Appointments 
SET status = 'CHECKED_IN' 
WHERE appointment_id = 101;

-- 4. Bác sĩ hoàn thành khám bệnh -> COMPLETED
UPDATE Appointments 
SET status = 'COMPLETED' 
WHERE appointment_id = 101;

-- 5. Bác sĩ kê đơn thuốc cho lịch hẹn 101
INSERT INTO Prescriptions (appointment_id, diagnosis, medication_details, issued_date)
VALUES (101, 'Viêm họng cấp / Viêm phế quản nhẹ', '1. Paracetamol 500mg: 2 viên/ngày\n2. Amoxicillin 500mg: 2 viên/ngày (uống sau ăn)\n3. Vitamin C 500mg: 1 viên/ngày', NOW());


-- KỊCH BẢN 2: BỆNH NHÂN HỦY LỊCH SAU KHI ĐÃ CONFIRMED (PHẠT TIỀN CỌC)
-- 1. Bệnh nhân đặt lịch và cọc 300.000 VNĐ -> Trạng thái CONFIRMED
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status, deposit_amount)
VALUES (102, 2, 2, '2026-10-19 14:30:00', 'CONFIRMED', 300000.00);

-- 2. Bệnh nhân gọi điện báo hủy vì bận đột xuất -> Cập nhật CANCELLED, phạt 150.000 VNĐ
UPDATE Appointments 
SET status = 'CANCELLED',
    cancel_reason = 'Bận việc đột xuất không thể sắp xếp thời gian',
    penalty_fee = 150000.00
WHERE appointment_id = 102;

-- -----------------------------------------------------------------------------
-- 4. TRUY VẤN KIỂM ĐỊNH VÀ BÁO CÁO TÀI CHÍNH
-- -----------------------------------------------------------------------------

-- Truy vấn 1: Danh sách bệnh nhân đã khám hoàn tất kèm đơn thuốc
SELECT 
    a.appointment_id,
    p.full_name AS patient_name,
    d.full_name AS doctor_name,
    a.appointment_date,
    a.status,
    pr.diagnosis,
    pr.medication_details,
    pr.issued_date
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Prescriptions pr ON a.appointment_id = pr.appointment_id
WHERE a.status = 'COMPLETED';

-- Truy vấn 2: Báo cáo đối soát tài chính phòng khám (Doanh thu cọc, Tiền phạt hủy lịch)
SELECT 
    a.appointment_id,
    p.full_name AS patient_name,
    a.status,
    a.deposit_amount,
    a.penalty_fee,
    (a.deposit_amount - a.penalty_fee) AS refund_to_patient,
    a.cancel_reason
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id;
