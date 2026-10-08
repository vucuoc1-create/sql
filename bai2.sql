-- Step 1: Tạo cơ sở dữ liệu QuanLyBanHang
CREATE DATABASE IF NOT EXISTS QuanLyBanHang;
USE QuanLyBanHang;

-- Step 2: Tạo bảng Customer (Khách hàng)
CREATE TABLE Customer (
    cID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cName VARCHAR(50) NOT NULL,
    cAge TINYINT
);

-- Step 3: Tạo bảng Orders (Hóa đơn)
CREATE TABLE Orders (
    oID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cID INT NOT NULL,
    oDate DATETIME NOT NULL,
    oTotalPrice INT DEFAULT 0,
    CONSTRAINT FK_Orders_Customer FOREIGN KEY (cID) REFERENCES Customer(cID) ON DELETE CASCADE
);

-- Step 4: Tạo bảng Product (Sản phẩm)
CREATE TABLE Product (
    pID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pName VARCHAR(50) NOT NULL,
    pPrice INT NOT NULL DEFAULT 0 CHECK (pPrice >= 0)
);

-- Step 5: Tạo bảng OrderDetail (Chi tiết hóa đơn)
CREATE TABLE OrderDetail (
    oID INT NOT NULL,
    pID INT NOT NULL,
    odQTY INT NOT NULL DEFAULT 1 CHECK (odQTY > 0),
    PRIMARY KEY (oID, pID),
    CONSTRAINT FK_OrderDetail_Orders FOREIGN KEY (oID) REFERENCES Orders(oID) ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetail_Product FOREIGN KEY (pID) REFERENCES Product(pID) ON DELETE CASCADE
);
