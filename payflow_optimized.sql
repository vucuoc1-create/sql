-- ========================================================
-- HỆ THỐNG PAYFLOW - SCRIPT TỐI ƯU HÓA HIỆU NĂNG
-- ========================================================
USE payflow_db;

-- 1. Tạo Composite Index chuẩn B-Tree trên 2 cột lọc
-- Đặt transaction_type lên trước (Độ lọc ref) và created_at đằng sau (Phục vụ truy vấn khoảng range)
CREATE INDEX idx_type_date ON Transactions(transaction_type, created_at);

-- 2. Truy vấn đã được Refactor (Viết lại chuẩn SARGable)
-- Loại bỏ hàm YEAR() và MONTH() bọc quanh cột created_at
-- Thay bằng so sánh khoảng thời gian [Bắt đầu tháng, Đầu tháng sau)
EXPLAIN 
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT' 
  AND created_at >= '2026-06-01 00:00:00' 
  AND created_at < '2026-07-01 00:00:00';
