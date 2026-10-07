-- 1. Tạo CSDL mới tên là demo
CREATE DATABASE IF NOT EXISTS demo;

-- 2. Sử dụng CSDL demo
USE demo;

-- 3. Tạo bảng Student với các trường thuộc tính theo đúng yêu cầu đề bài
CREATE TABLE IF NOT EXISTS Student (
    id INT,
    name VARCHAR(200),
    age INT,
    country VARCHAR(50)
);