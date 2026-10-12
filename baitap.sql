-- =====================================================================
-- BÀI THỰC HÀNH: CHỈ MỤC TRONG MYSQL (MYSQL INDEX)
-- =====================================================================

-- Bước 1: Khảo sát hiệu năng trước khi đánh Index (kiểm tra truy vấn)
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- Bước 2: Tạo Index đơn (Single-column Index) trên cột customerName
ALTER TABLE customers ADD INDEX idx_customerName(customerName);

-- Kiểm tra lại hiệu năng sau khi đã tạo index
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- Bước 3: Tạo Index phức hợp (Composite Index) trên nhiều cột (ví dụ: họ và tên liên lạc)
ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);

-- Kiểm tra truy vấn sử dụng Index phức hợp
EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean' OR contactFirstName = 'King';

-- Bước 4: Xóa Index khi không còn cần thiết nữa
ALTER TABLE customers DROP INDEX idx_full_name;
