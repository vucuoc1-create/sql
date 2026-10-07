# [Thực hành] Tạo bảng trên MySQL Workbench

## 🎯 Mục tiêu
Luyện tập thao tác tạo CSDL mới và tạo Bảng (Table) với các thuộc tính cụ thể bằng câu lệnh SQL trên MySQL Workbench.

---

## 📝 Đề bài
1. Tạo một Cơ sở dữ liệu (CSDL) mới có tên là `demo`.
2. Tạo bảng `Student` bên trong CSDL `demo` chứa các trường (thuộc tính):
   - `id`: kiểu số nguyên (`int`)
   - `name`: kiểu chuỗi ký tự (`varchar(200)`)
   - `age`: kiểu số nguyên (`int`)
   - `country`: kiểu chuỗi ký tự (`varchar(50)`)

---

## 💻 Các bước thực hiện bằng câu lệnh SQL

### Bước 1: Mở Query Tab
1. Mở MySQL Workbench và kết nối tới Server.
2. Tạo một file soạn thảo mới bằng cách bấm vào biểu tượng **New Query Tab** (hình trang giấy có tia sét) hoặc nhấn tổ hợp phím `Ctrl + T`.

### Bước 2: Viết mã SQL
Nhập đoạn mã lệnh SQL sau vào cửa sổ soạn thảo:

```sql
-- 1. Tạo CSDL có tên là demo
CREATE DATABASE IF NOT EXISTS demo;

-- 2. Chọn CSDL demo để thao tác
USE demo;

-- 3. Tạo bảng Student với các thuộc tính yêu cầu
CREATE TABLE IF NOT EXISTS Student (
    id INT,
    name VARCHAR(200),
    age INT,
    country VARCHAR(50)
);
