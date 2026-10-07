# [Thực hành] Tạo bảng trên MySQL Workbench

## 🎯 Mục tiêu
Thực hành tạo cơ sở dữ liệu mới và tạo bảng thông qua câu lệnh SQL trên MySQL Workbench.

---

## 💻 Mã nguồn SQL (`demo.sql`)

```sql
-- Tạo cơ sở dữ liệu tên demo
CREATE DATABASE IF NOT EXISTS demo;

-- Chọn cơ sở dữ liệu demo
USE demo;

-- Tạo bảng Student với các trường: id, name, age, country
CREATE TABLE IF NOT EXISTS Student (
    id INT,
    name VARCHAR(200),
    age INT,
    country VARCHAR(50)
);
