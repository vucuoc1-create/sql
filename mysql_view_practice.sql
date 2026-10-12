-- =====================================================================
-- BÀI THỰC HÀNH: VIEW TRONG MYSQL
-- =====================================================================

-- 1. Tạo View có tên customer_views truy vấn dữ liệu từ bảng customers
CREATE VIEW customer_views AS
SELECT customerNumber, customerName, phone
FROM customers;

-- 2. Truy vấn dữ liệu từ bảng ảo (View) vừa tạo
SELECT * FROM customer_views;


-- 3. Cập nhật View (Sử dụng CREATE OR REPLACE VIEW)
-- Thêm các cột contactFirstName, contactLastName và điều kiện lọc theo thành phố 'Nantes'
CREATE OR REPLACE VIEW customer_views AS
SELECT customerNumber, customerName, contactFirstName, contactLastName, phone
FROM customers
WHERE city = 'Nantes';

-- Kiểm tra lại dữ liệu của View sau khi cập nhật
SELECT * FROM customer_views;


-- 4. Xóa View khi không còn sử dụng đến
DROP VIEW customer_views;
