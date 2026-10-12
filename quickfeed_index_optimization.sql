-- =====================================================================
-- BÀI THỰC HÀNH: TỐI ƯU HÓA INDEX VÀ GIẢI CỨU HỆ THỐNG QUICKFEED
-- =====================================================================

CREATE DATABASE IF NOT EXISTS quickfeed_db;
USE quickfeed_db;

-- 1. Kiểm tra dung lượng Data và Index TRƯỚC khi tối ưu hóa
SELECT 
    TABLE_NAME AS 'Ten_Bang',
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS 'Dung_Luong_Data_MB',
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS 'Dung_Luong_Index_MB',
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS 'Tong_Dung_Luong_MB'
FROM 
    information_schema.TABLES 
WHERE 
    TABLE_SCHEMA = 'quickfeed_db' 
    AND TABLE_NAME = 'Posts';

-- 2. Thực hiện "phẫu thuật cắt bỏ" các Index vô giá trị, tốn tài nguyên và gây chậm lệnh INSERT
-- Xóa Index trên cột TEXT dài (gây phình to cây B-Tree vô ích)
ALTER TABLE Posts DROP INDEX idx_content;

-- Xóa Index trên cột có Cardinality thấp (post_type chỉ có 3 giá trị)
ALTER TABLE Posts DROP INDEX idx_post_type;

-- Xóa Index trên cột kiểu BOOLEAN (is_visible chỉ có 0 hoặc 1)
ALTER TABLE Posts DROP INDEX idx_is_visible;

-- Lưu ý: Giữ lại idx_user_id (độ phân biệt cao cho query tìm theo user) 
-- và idx_created_at (phục vụ sắp xếp Newsfeed theo thời gian).

-- 3. Kiểm tra lại dung lượng SAU khi dọn dẹp Index
SELECT 
    TABLE_NAME AS 'Ten_Bang',
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS 'Dung_Luong_Data_MB',
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS 'Dung_Luong_Index_MB',
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS 'Tong_Dung_Luong_MB'
FROM 
    information_schema.TABLES 
WHERE 
    TABLE_SCHEMA = 'quickfeed_db' 
    AND TABLE_NAME = 'Posts';
