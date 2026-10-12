-- =====================================================================
-- BÀI TẬP: GIẢI CỨU HỆ THỐNG IOT SMARTFACTORY (TỐI ƯU INDEX)
-- =====================================================================

CREATE DATABASE IF NOT EXISTS smartfactory_db;
USE smartfactory_db;

-- 1. Kiểm tra dung lượng Data và Index TRƯỚC khi tối ưu hóa
SELECT 
    TABLE_NAME AS 'Ten_Bang',
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS 'Dung_Luong_Data_MB',
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS 'Dung_Luong_Index_MB',
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS 'Tong_Dung_Luong_MB'
FROM 
    information_schema.TABLES 
WHERE 
    TABLE_SCHEMA = 'smartfactory_db' 
    AND TABLE_NAME = 'SensorLogs';

-- 2. Xóa bỏ "Fat Index" gây thắt cổ chai luồng Ghi (Write Bottleneck) và phung phí ổ cứng
ALTER TABLE SensorLogs DROP INDEX idx_fat_covering;

-- 3. Tạo "Lean Index" (Chỉ mục tinh gọn) chỉ chứa các trường dùng để lọc và sắp xếp (WHERE & ORDER BY)
CREATE INDEX idx_lean_search ON SensorLogs(sensor_id, recorded_at);

-- 4. Chạy EXPLAIN để kiểm tra hiệu năng truy vấn Dashboard sau khi tối ưu
EXPLAIN 
SELECT temperature, humidity, status 
FROM SensorLogs 
WHERE sensor_id = 105 AND recorded_at >= '2026-06-20';

-- 5. Kiểm tra lại dung lượng SAU khi chuyển sang Lean Index
SELECT 
    TABLE_NAME AS 'Ten_Bang',
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS 'Dung_Luong_Data_MB',
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS 'Dung_Luong_Index_MB',
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS 'Tong_Dung_Luong_MB'
FROM 
    information_schema.TABLES 
WHERE 
    TABLE_SCHEMA = 'smartfactory_db' 
    AND TABLE_NAME = 'SensorLogs';
