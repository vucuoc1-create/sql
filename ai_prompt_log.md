# Nhật ký Tương tác AI (AI Prompt Log)

## Yêu cầu tra cứu 1: Đánh giá tác hại của việc tạo Index trên cột TEXT và BOOLEAN
* **Prompt gửi AI:** "Trong MySQL, nếu tôi tạo Index trên một cột chứa văn bản dài (TEXT) và một cột kiểu BOOLEAN (0 và 1), thì điều này gây hại như thế nào đến bộ nhớ RAM, dung lượng Disk và bộ tối ưu hóa (Query Optimizer)?"
* **Tóm tắt phản hồi từ AI:** 
  - Đối với cột `TEXT`: Cây B-Tree bắt buộc phải cắt ngắn (prefix index) hoặc lưu trữ dữ liệu chuỗi lớn, làm tăng kích thước node, chiếm dụng nhiều không gian RAM (Buffer Pool) và Disk Space vô ích.
  - Đối với cột `BOOLEAN`: Cardinality quá thấp (chỉ có 2 giá trị). Khi tỷ lệ dữ liệu trùng lặp chiếm đa số, MySQL Optimizer tính toán rằng việc đọc tuần tự qua Full Table Scan hiệu quả hơn việc nhảy qua cây B-Tree rồi quay lại bảng (Random I/O). Do đó Index này hoàn toàn vô tác dụng nhưng vẫn tốn chi phí bảo trì khi có thao tác INSERT/UPDATE/DELETE.

## Yêu cầu tra cứu 2: Truy vấn thông tin dung lượng từ information_schema
* **Prompt gửi AI:** "Hãy cho tôi xem truy vấn SQL sử dụng bảng information_schema.TABLES để in ra kích thước Data và kích thước Index của bảng 'Posts' tính theo đơn vị Megabyte (MB)."
* **Tóm tắt phản hồi từ AI:** Hướng dẫn sử dụng các cột `DATA_LENGTH` và `INDEX_LENGTH` chia cho `1024 / 1024` kèm hàm `ROUND` để hiển thị trực quan số đo dung lượng theo đơn vị MB.

## Yêu cầu tra cứu 3: Giải pháp thay thế tìm kiếm văn bản dài
* **Prompt gửi AI:** "Nếu muốn tìm kiếm từ khóa bên trong cột content (kiểu TEXT) mà không bị tốn quá nhiều dung lượng như B-Tree Index, tôi nên sử dụng cơ chế nào của MySQL?"
* **Tóm tắt phản hồi từ AI:** Gợi ý sử dụng **`FULLTEXT` Index** kết hợp với hàm tìm kiếm chuyên dụng `MATCH ... AGAINST (...)`, giúp tối ưu hóa việc tìm kiếm văn bản full-text mà không làm phình to cấu trúc B-Tree thông thường.
