-- =====================================================================
-- BÀI TẬP: VIEW, INDEX, STORED PROCEDURE TRONG MYSQL
-- =====================================================================

-- BƯỚC 1 & 2: TẠO CƠ SỞ DỮ LIỆU, BẢNG PRODUCTS VÀ CHÈN DỮ LIỆU MẪU
CREATE DATABASE IF NOT EXISTS store_management;
USE store_management;

DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(10,2) NOT NULL,
    productAmount INT NOT NULL,
    productDescription TEXT,
    productStatus VARCHAR(50)
);

-- Chèn dữ liệu mẫu vào bảng Products
INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus) VALUES
('P001', 'Laptop Dell Inspiron', 15000000.00, 10, 'Laptop văn phòng core i5', 'Active'),
('P002', 'MacBook Air M2', 28000000.00, 5, 'Laptop Apple mỏng nhẹ', 'Active'),
('P003', 'IPhone 15 Pro', 25000000.00, 8, 'Điện thoại thông minh cao cấp', 'Active'),
('P004', 'Chuột không dây Logitech', 350000.00, 50, 'Chuột văn phòng kết nối không dây', 'Active'),
('P005', 'Bàn phím cơ ATK', 1200000.00, 20, 'Bàn phím cơ gaming', 'OutOfStock');


-- BƯỚC 3: TẠO INDEX VÀ KHẢO SÁT HIỆU NĂNG BẰNG EXPLAIN
-- Tạo Unique Index trên cột productCode
CREATE UNIQUE INDEX idx_productCode ON Products(productCode);

-- Tạo Composite Index (Index kết hợp) trên 2 cột productName và productPrice
CREATE INDEX idx_name_price ON Products(productName, productPrice);

-- Khảo sát câu lệnh truy vấn trước và sau khi có Index bằng EXPLAIN
EXPLAIN SELECT * FROM Products WHERE productCode = 'P001';
EXPLAIN SELECT * FROM Products WHERE productName = 'Laptop Dell Inspiron' AND productPrice = 15000000.00;


-- BƯỚC 4: QUẢN LÝ VIEW
-- 1. Tạo View lấy các thông tin: productCode, productName, productPrice, productStatus
CREATE VIEW view_products AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

-- Xem dữ liệu từ View
SELECT * FROM view_products;

-- 2. Tiến hành sửa đổi View (Cập nhật thêm điều kiện hoặc thay đổi cột)
CREATE OR REPLACE VIEW view_products AS
SELECT productCode, productName, productPrice, productStatus, productAmount
FROM Products
WHERE productPrice > 1000000.00;

-- 3. Xoá View khi không còn dùng đến
DROP VIEW IF EXISTS view_products;


-- BƯỚC 5: TẠO STORED PROCEDURE
-- 1. Stored Procedure lấy tất cả thông tin của tất cả sản phẩm
DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Products;
END //
DELIMITER ;

-- Gọi thử procedure:
CALL GetAllProducts();


-- 2. Stored Procedure thêm một sản phẩm mới
DELIMITER //
CREATE PROCEDURE InsertProduct(
    IN p_code VARCHAR(50),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_amount INT,
    IN p_desc TEXT,
    IN p_status VARCHAR(50)
)
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (p_code, p_name, p_price, p_amount, p_desc, p_status);
END //
DELIMITER ;

-- Gọi thử procedure thêm sản phẩm:
CALL InsertProduct('P006', 'Tai nghe Bluetooth Sony', 2000000.00, 15, 'Tai nghe chống ồn', 'Active');


-- 3. Stored Procedure sửa thông tin sản phẩm theo id
DELIMITER //
CREATE PROCEDURE UpdateProductById(
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_amount INT,
    IN p_status VARCHAR(50)
)
BEGIN
    UPDATE Products
    SET productName = p_name,
        productPrice = p_price,
        productAmount = p_amount,
        productStatus = p_status
    WHERE Id = p_id;
END //
DELIMITER ;

-- Gọi thử procedure sửa sản phẩm có Id = 1:
CALL UpdateProductById(1, 'Laptop Dell Inspiron 15', 15500000.00, 12, 'Active');


-- 4. Stored Procedure xoá sản phẩm theo id
DELIMITER //
CREATE PROCEDURE DeleteProductById(
    IN p_id INT
)
BEGIN
    DELETE FROM Products WHERE Id = p_id;
END //
DELIMITER ;

-- Gọi thử procedure xóa sản phẩm có Id = 5:
CALL DeleteProductById(5);
