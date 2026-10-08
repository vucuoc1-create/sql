-- ========================================================
-- KHỞI TẠO CƠ SỞ DỮ LIỆU VÀ DỮ LIỆU MẪU
-- ========================================================
CREATE DATABASE IF NOT EXISTS flashmart_db;
USE flashmart_db;

-- 1. Tạo bảng
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY, 
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Products (
    product_id INT PRIMARY KEY, 
    product_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY, 
    customer_id INT, 
    product_id INT
);

-- 2. Chèn dữ liệu mẫu
TRUNCATE TABLE Orders;
TRUNCATE TABLE Customers;
TRUNCATE TABLE Products;

INSERT INTO Customers VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie'); 
INSERT INTO Products VALUES (101, 'Laptop'), (102, 'Mouse'), (103, 'Keyboard'); 
INSERT INTO Orders VALUES (1001, 1, 101), (1002, 1, 102), (1003, 2, 101);

-- ========================================================
-- TRUY VẤN ĐÃ SỬA LỖI (FIXED QUERIES)
-- ========================================================

-- BÁO CÁO 1 (CHO MARKETING): Danh sách tất cả khách hàng và số lượng đơn đã mua
-- Đã sửa: Dùng LEFT JOIN kết hợp COUNT(o.order_id) để giữ lại Charlie với total_orders = 0
SELECT 
    c.customer_id, 
    c.name, 
    COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- BÁO CÁO 2 (CHO KHO VẬN): Danh sách sản phẩm chưa từng được bán (Anti-Join)
-- Đã sửa: Dùng LEFT JOIN từ Products sang Orders kết hợp WHERE o.order_id IS NULL
SELECT 
    p.product_id, 
    p.product_name
FROM Products p
LEFT JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;
