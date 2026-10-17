-- ==========================================================
-- HỆ THỐNG HEALTHSYNC - DATABASE OPTIMIZATION SCRIPT
-- ==========================================================

DROP DATABASE IF EXISTS healthsync_db;
CREATE DATABASE healthsync_db;
USE healthsync_db;

-- 1. Bảng Bệnh nhân (Patients)
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL
);

-- 2. Bảng Bác sĩ (Doctors)
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(50)
);

-- 3. Bảng Lịch hẹn (Appointments)
-- Tái cấu trúc: Loại bỏ is_active BOOLEAN, thêm status ENUM và các thuộc tính tài chính/nghiệp vụ hủy
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('PENDING', 'CONFIRMED', 'CHECKED_IN', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING',
    deposit_amount DECIMAL(10, 2) DEFAULT 0.00,
    penalty_fee DECIMAL(10, 2) DEFAULT 0.00,
    cancel_reason VARCHAR(255) NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- 4. Bảng Đơn thuốc (Prescriptions)
-- Bổ sung bảng quản lý đơn thuốc gắn liền với lịch hẹn hoàn tất
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE NOT NULL,
    medication_details TEXT NOT NULL,
    issued_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- ==========================================================
-- KỊCH BẢN MÔ PHỎNG DỮ LIỆU THỰC TẾ (DML SCRIPTS)
-- ==========================================================

-- Chèn dữ liệu danh mục ban đầu
INSERT INTO Patients (full_name, phone) VALUES 
('Nguyễn Văn An', '0901234567'),
('Trần Thị Bình', '0918765432');

INSERT INTO Doctors (full_name, specialty) VALUES 
('Dr. Hoàng Nam', 'Đa khoa'),
('Dr. Lê Mai', 'Nhi khoa');

-- KỊCH BẢN 1: Luồng khám bệnh thành công trọn vẹn (Bệnh nhân Nguyễn Văn An)
-- 1. Đặt lịch PENDING, cọc 500.000 VNĐ
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, deposit_amount) 
VALUES (1, 1, '2026-06-10 09:00:00', 'PENDING', 500000.00);

-- 2. Hệ thống duyệt cọc -> CONFIRMED
UPDATE Appointments SET status = 'CONFIRMED' WHERE appointment_id = 1;

-- 3. Bệnh nhân đến phòng khám -> CHECKED_IN
UPDATE Appointments SET status = 'CHECKED_IN' WHERE appointment_id = 1;

-- 4. Khám xong -> COMPLETED và kê đơn thuốc
UPDATE Appointments SET status = 'COMPLETED' WHERE appointment_id = 1;

INSERT INTO Prescriptions (appointment_id, medication_details) 
VALUES (1, 'Paracetamol 500mg (10 viên, uống 2 viên/ngày sau ăn), Vitamin C 1000mg (5 viên, uống 1 viên/sáng)');

-- KỊCH BẢN 2: Luồng hủy lịch có phát sinh phí phạt cọc (Bệnh nhân Trần Thị Bình)
-- 1. Đặt lịch và đã xác nhận cọc 300.000 VNĐ -> CONFIRMED
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, deposit_amount) 
VALUES (2, 2, '2026-06-11 10:30:00', 'CONFIRMED', 300000.00);

-- 2. Bệnh nhân hủy lịch -> CANCELLED, phạt 150.000 VNĐ
UPDATE Appointments 
SET status = 'CANCELLED', 
    cancel_reason = 'Bận lịch tác đột xuất', 
    penalty_fee = 150000.00 
WHERE appointment_id = 2;

-- TRUY VẤN KIỂM TRA TÍNH TOÀN VẸN DỮ LIỆU
SELECT 
    a.appointment_id,
    p.full_name AS patient_name,
    d.full_name AS doctor_name,
    a.status,
    a.deposit_amount,
    a.penalty_fee,
    pr.medication_details
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
LEFT JOIN Prescriptions pr ON a.appointment_id = pr.appointment_id;
