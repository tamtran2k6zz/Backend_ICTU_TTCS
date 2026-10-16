-- Chay tren moi truong thuc hanh. Khong xoa database/bang hien co.
CREATE DATABASE IF NOT EXISTS company
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE company;

CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
) ENGINE = InnoDB;

DELIMITER //
DROP TRIGGER IF EXISTS update_department//
CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';
    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';
    ELSE
        SET NEW.department = 'Support';
    END IF;
END//
DELIMITER ;
