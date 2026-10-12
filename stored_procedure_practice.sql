-- =====================================================================
-- BÀI THỰC HÀNH: STORED PROCEDURE TRONG MYSQL
-- =====================================================================

-- 1. Tạo Stored Procedure đầu tiên (findAllCustomers)
DELIMITER //

CREATE PROCEDURE findAllCustomers()

BEGIN
  SELECT * FROM customers;
END //

DELIMITER ;

-- Cách gọi procedure findAllCustomers vừa tạo:
CALL findAllCustomers();


-- 2. Xóa Procedure cũ (nếu có) và tạo lại với truy vấn điều kiện (ví dụ: customerNumber = 175)
DELIMITER //

DROP PROCEDURE IF EXISTS `findAllCustomers`//

CREATE PROCEDURE findAllCustomers()

BEGIN
  SELECT * FROM customers WHERE customerNumber = 175;
END //

DELIMITER ;

-- Gọi lại procedure sau khi đã cập nhật:
CALL findAllCustomers();
