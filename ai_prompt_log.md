# AI Prompt Log - Tìm hiểu về thuật toán JOIN trong MySQL

### User Prompt 1:
> Trong cơ sở dữ liệu MySQL, mặc định từ khóa JOIN (khi không ghi rõ LEFT hay RIGHT) sẽ hoạt động như thế nào? Nó sẽ bỏ qua hay giữ lại các bản ghi không có sự trùng khớp ở cả hai bảng?

### AI Assistant Summary:
> Từ khóa `JOIN` mặc định trong MySQL hoạt động như một `INNER JOIN`. Nó chỉ trả về các bản ghi có sự trùng khớp (khớp khóa ngoại/khóa chính) giữa cả hai bảng. Tất cả các bản ghi ở bảng trái không có tương ứng ở bảng phải (hoặc ngược lại) sẽ bị loại bỏ hoàn toàn khỏi tập kết quả.

---

### User Prompt 2:
> Hãy phân tích hiệu năng (Performance) của việc dùng LEFT JOIN kết hợp IS NULL (Anti-Join) so với việc dùng subquery NOT IN khi muốn tìm kiếm các bản ghi không tồn tại trong bảng khác.

### AI Assistant Summary:
> Trong MySQL, `LEFT JOIN ... WHERE IS NULL` thường có hiệu năng tốt hơn hoặc bằng `NOT IN`. Nếu cột kiểm tra trong câu lệnh `NOT IN` chứa giá trị `NULL`, `NOT IN` có thể trả về tập kết quả rỗng hoàn toàn hoặc buộc MySQL phải thực hiện quét toàn bộ bảng (Full Table Scan). Mệnh đề `LEFT JOIN ... IS NULL` giúp MySQL Optimizer dễ dàng áp dụng chiến lược tìm kiếm thông qua chỉ mục (Index Lookup).
