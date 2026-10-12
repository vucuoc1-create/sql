# Nhật ký Tương tác AI (AI Prompt Log)

## Yêu cầu tra cứu 1: Giải thích khái niệm Covering Index và ưu nhược điểm
* **Prompt gửi AI:** "Giải thích khái niệm Covering Index trong MySQL và tại sao việc lạm dụng nó trong hệ thống ghi dữ liệu liên tục lại gây hại."
* **Tóm tắt phản hồi từ AI:** 
  - Covering Index là chỉ mục chứa tất cả các cột cần thiết cho một truy vấn, giúp MySQL trả về kết quả trực tiếp từ cây B-Tree mà không cần đọc bảng gốc (Clustered Index).
  - Nhược điểm: Tăng chi phí cập nhật (Write Penalty) khi dữ liệu thay đổi liên tục, làm tăng kích thước bộ nhớ RAM (Buffer Pool) và Disk Space.

## Yêu cầu tra cứu 2: Cơ chế phân bổ Clustered Index và Secondary Index trong InnoDB
* **Prompt gửi AI:** "MySQL InnoDB phân bổ dữ liệu giữa Clustered Index và Secondary Index như thế nào tại tầng vật lý?"
* **Tóm tắt phản hồi từ AI:** 
  - Clustered Index lưu trữ toàn bộ các cột của hàng dữ liệu tại các lá (leaf nodes) của cây khóa chính (Primary Key).
  - Secondary Index chỉ lưu giá trị của các cột trong index kèm theo giá trị Primary Key ở phần lá. Do đó, khi truy vấn các cột không nằm trong Secondary Index, MySQL phải thực hiện thêm bước *Bookmark Lookup* (nhảy sang Clustered Index để lấy dữ liệu).

## Yêu cầu tra cứu 3: Tính toán kích thước dữ liệu kiểu dữ liệu trong MySQL
* **Prompt gửi AI:** "Hãy cho tôi biết kích thước tính bằng byte của các kiểu dữ liệu BIGINT, INT, DATETIME, DECIMAL(5,2) và VARCHAR(20) trong MySQL."
* **Tóm tắt phản hồi từ AI:** Cung cấp thông tin chi tiết: `BIGINT` (8 bytes), `INT` (4 bytes), `DATETIME` (5 bytes), `DECIMAL(5,2)` (3 bytes), và `VARCHAR(20)` (biến đổi tùy theo độ dài chuỗi ký tự thực tế cộng thêm 1-2 byte prefix).
