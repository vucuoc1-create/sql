# [Bài tập] Xây dựng cơ sở dữ liệu quản lý sinh viên

## 🎯 Mục tiêu
Thực hành tạo các bảng trong Cơ sở dữ liệu quản lý sinh viên bằng MySQL Workbench.

---

## 📝 Yêu cầu bài tập
1. Sử dụng/tạo Cơ sở dữ liệu: `student-management`
2. Tạo bảng **Class** gồm các trường:
   - `id`: kiểu số nguyên (`INT`)
   - `name`: kiểu chuỗi (`VARCHAR(255)`)
3. Tạo bảng **Teacher** gồm các trường:
   - `id`: kiểu số nguyên (`INT`)
   - `name`: kiểu chuỗi (`VARCHAR(255)`)
   - `age`: kiểu số nguyên (`INT`)
   - `country`: kiểu chuỗi (`VARCHAR(100)`)

---

## 💻 Code SQL thực thi (`student_management.sql`)

```sql
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
