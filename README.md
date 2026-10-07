# BÀI THỰC HÀNH: TẠO CƠ SỞ DỮ LIỆU TRÊN MYSQL WORKBENCH

## PHƯƠNG PHÁP 1: Tạo CSDL sử dụng giao diện MySQL Workbench (GUI)
- Bước 1: Mở ứng dụng MySQL Workbench và đăng nhập vào MySQL Connection.
- Bước 2: Tại thanh điều khiển Navigator bên trái, chọn tab SCHEMAS.
- Bước 3: Nhấp chuột phải vào vùng trống trong SCHEMAS, chọn "Create Schema...".
- Bước 4: Nhập tên CSDL mới là `my_database` (hoặc `my_database1`), chọn Collation mặc định và nhấn nút "Apply".
- Bước 5: Tiếp tục nhấn "Apply" ở cửa sổ xem trước câu lệnh SQL và nhấn "Finish" để hoàn tất.

---

## PHƯƠNG PHÁP 2: Tạo CSDL sử dụng câu lệnh SQL trên MySQL Workbench
Mở một Query Tab mới trong MySQL Workbench và chạy câu lệnh SQL sau:

```sql
CREATE DATABASE `my_database1`;
