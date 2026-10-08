-- =====================================================
-- HỆ THỐNG AUTORIDE - RE-DESIGNED DATABASE SCHEMA & DML
-- Author: Data Architect
-- File: autoride_db.sql
-- =====================================================

-- -----------------------------------------------------
-- BƯỚC 1: KHỞI TẠO CƠ SỞ DỮ LIỆU & BẢNG CARS
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS autoride_db;
USE autoride_db;

-- Tạo bảng Cars nếu chưa có
CREATE TABLE IF NOT EXISTS Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL
);

-- Tạo bảng Rentals bản Legacy (để đảm bảo script chạy mượt mà từ đầu)
CREATE TABLE IF NOT EXISTS Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME,
    status VARCHAR(50) DEFAULT 'BOOKED',
    FOREIGN KEY (car_id) REFERENCES Cars(car_id)
);

-- -----------------------------------------------------
-- BƯỚC 2: NÂNG CẤP DDL (MÔ HÌNH HÓA THEO ĐÚNG NGHIỆP VỤ)
-- -----------------------------------------------------

-- 1. Chuẩn hóa cột status và bổ sung 3 cột tài chính vào Rentals
ALTER TABLE Rentals
    MODIFY COLUMN status ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'BOOKED',
    ADD COLUMN security_deposit DECIMAL(12, 2) NOT NULL DEFAULT 0.00 AFTER return_date,
    ADD COLUMN late_fee DECIMAL(12, 2) NOT NULL DEFAULT 0.00 AFTER security_deposit,
    ADD COLUMN damage_fee DECIMAL(12, 2) NOT NULL DEFAULT 0.00 AFTER late_fee;

-- 2. Tạo bảng Inspections (Biên bản kiểm tra xe)
CREATE TABLE IF NOT EXISTS Inspections (
    inspection_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    damage_description TEXT,
    inspector_name VARCHAR(100) NOT NULL,
    CONSTRAINT fk_inspections_rentals 
        FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- BƯỚC 3: MÔ PHỎNG VẬN HÀNH DML (CHẠY THỬ NGHIỆP VỤ REAL-WORLD)
-- -----------------------------------------------------

-- 1. Thêm xe mẫu
INSERT INTO Cars (model_name, license_plate) 
VALUES ('Toyota Camry 2024', '30K-888.88');

-- 2. Khách "Nguyen Van A" đặt và nhận xe (Trạng thái ACTIVE, cọc 10,000,000 VNĐ)
INSERT INTO Rentals (car_id, customer_name, rent_date, status, security_deposit)
VALUES (1, 'Nguyen Van A', '2026-10-01 08:00:00', 'ACTIVE', 10000000.00);

-- 3. Khách trả xe: Nhân viên kiểm tra phát hiện vỡ đèn pha -> Tạo biên bản Inspections
INSERT INTO Inspections (rental_id, inspection_date, damage_description, inspector_name)
VALUES (1, '2026-10-03 10:00:00', 'Vỡ đèn pha bên trái do va quẹt', 'Tran Van B (Inspector)');

-- 4. Cập nhật hợp đồng Rentals: Chuyển COMPLETED, trễ 0đ, phạt hư hỏng 2,000,000 VNĐ
UPDATE Rentals
SET return_date = '2026-10-03 10:00:00',
    status = 'COMPLETED',
    late_fee = 0.00,
    damage_fee = 2000000.00
WHERE rental_id = 1;

-- -----------------------------------------------------
-- BƯỚC 4: TRUY VẤN TÍNH TOÁN TIỀN HOÀN TRẢ (REFUND)
-- -----------------------------------------------------
SELECT 
    r.rental_id AS 'Mã HĐ',
    r.customer_name AS 'Khách hàng',
    c.model_name AS 'Tên xe',
    c.license_plate AS 'Biển số',
    FORMAT(r.security_deposit, 0) AS 'Tiền cọc (VNĐ)',
    FORMAT(r.late_fee, 0) AS 'Phí trễ (VNĐ)',
    FORMAT(r.damage_fee, 0) AS 'Phí hư hỏng (VNĐ)',
    FORMAT((r.security_deposit - r.late_fee - r.damage_fee), 0) AS 'Tiền hoàn trả (Refund VNĐ)',
    i.damage_description AS 'Ghi chú hư hỏng'
FROM Rentals r
JOIN Cars c ON r.car_id = c.car_id
LEFT JOIN Inspections i ON r.rental_id = i.rental_id
WHERE r.rental_id = 1;
