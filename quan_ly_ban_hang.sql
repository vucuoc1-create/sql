-- Chuyển sang cơ sở dữ liệu Quản lý bán hàng
USE QuanLyBanHang;

-- ========================================================
-- 1. THÊM DỮ LIỆU VÀO CÁC BẢNG
-- ========================================================

-- Thêm dữ liệu vào bảng Customer
INSERT INTO Customer (cID, Name, cAge) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

-- Thêm dữ liệu vào bảng Order
INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

-- Thêm dữ liệu vào bảng Product
INSERT INTO Product (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

-- Thêm dữ liệu vào bảng OrderDetail
INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- ========================================================
-- 2. CÁC CÂU TRUY VẤN DỮ LIỆU
-- ========================================================

-- Yêu cầu 1: Hiển thị các thông tin gồm oID, oDate, oTotalPrice của tất cả các hóa đơn trong bảng Order
SELECT oID, oDate, oTotalPrice
FROM `Order`;


-- Yêu cầu 2: Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT C.Name AS CustomerName, P.pName AS ProductName
FROM Customer C
JOIN `Order` O ON C.cID = O.cID
JOIN OrderDetail OD ON O.oID = OD.oID
JOIN Product P ON OD.pID = P.pID;


-- Yêu cầu 3: Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT C.Name
FROM Customer C
LEFT JOIN `Order` O ON C.cID = O.cID
WHERE O.oID IS NULL;


-- Yêu cầu 4: Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn
-- (Giá tiền = SUM(odQTY * pPrice))
SELECT 
    O.oID, 
    O.oDate, 
    SUM(OD.odQTY * P.pPrice) AS oTotalPrice
FROM `Order` O
JOIN OrderDetail OD ON O.oID = OD.oID
JOIN Product P ON OD.pID = P.pID
GROUP BY O.oID, O.oDate;
