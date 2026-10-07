-- 1. Tạo CSDL student-management nếu chưa tồn tại
CREATE DATABASE IF NOT EXISTS `student-management`;

-- 2. Chọn CSDL student-management để làm việc
USE `student-management`;

-- 3. Tạo bảng Class
CREATE TABLE IF NOT EXISTS `Class` (
    `id` INT,
    `name` VARCHAR(255)
);

-- 4. Tạo bảng Teacher
CREATE TABLE IF NOT EXISTS `Teacher` (
    `id` INT,
    `name` VARCHAR(255),
    `age` INT,
    `country` VARCHAR(100)
);