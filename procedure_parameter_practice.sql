-- =====================================================================
-- BÀI THỰC HÀNH: TRUYỀN THAM SỐ VÀO STORED PROCEDURE TRONG MYSQL
-- =====================================================================

-- ---------------------------------------------------------------------
-- PHẦN 1: THAM SỐ LOẠI IN (Tham số đầu vào)
-- ---------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE getCusById (IN cusNum INT(11))
BEGIN
  SELECT * FROM customers WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Cách gọi Store Procedure với tham số IN:
CALL getCusById(175);


-- ---------------------------------------------------------------------
-- PHẦN 2: THAM SỐ LOẠI OUT (Tham số đầu ra)
-- ---------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE GetCustomersCountByCity(
    IN  in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Cách gọi Store Procedure với tham số OUT:
CALL GetCustomersCountByCity('Lyon', @total);

-- Lấy giá trị trả về từ biến OUT:
SELECT @total;


-- ---------------------------------------------------------------------
-- PHẦN 3: THAM SỐ LOẠI INOUT (Vừa vào vừa ra)
-- ---------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Cách gọi Store Procedure với tham số INOUT:
SET @counter = 1;
CALL SetCounter(@counter, 1); -- Kết quả: 2
CALL SetCounter(@counter, 1); -- Kết quả: 3
CALL SetCounter(@counter, 5); -- Kết quả: 8

-- Xem kết quả cuối cùng của biến @counter:
SELECT @counter; -- Kết quả: 8
