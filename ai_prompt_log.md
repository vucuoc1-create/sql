# AI Prompt Log - Tìm hiểu về SARGable và B-Tree Index

### User Prompt 1:
> Trong MySQL, nếu tôi tạo Index cho một cột ngày tháng, nhưng trong mệnh đề WHERE tôi lại viết WHERE YEAR(col) = 2026, tại sao MySQL lại từ chối sử dụng Index và phải quét toàn bộ bảng (Full Table Scan)?

### AI Assistant Summary:
> Khi bọc một hàm (như `YEAR()`, `MONTH()`, `CONCAT()`) xung quanh cột dữ liệu, câu lệnh sẽ trở thành **Non-SARGable** (Search Argument Able). Cấu trúc cây B-Tree của Index sắp xếp dữ liệu theo giá trị thô của cột, chứ không sắp xếp theo kết quả của hàm. Để tìm dòng thỏa mãn, MySQL buộc phải duyệt qua từng dòng trong bảng, chạy hàm đó để lấy kết quả rồi mới so sánh với 2026, dẫn đến hiện tượng Full Table Scan.

---

### User Prompt 2:
> Khi thiết kế một Composite Index trong MySQL cho cột (transaction_type, created_at), thứ tự các cột trong Index có quan trọng không? Tôi nên đặt cột nào đứng trước?

### AI Assistant Summary:
> Thứ tự vô cùng quan trọng theo quy tắc **Leftmost Prefix** (Tiền tố trái nhất). Nên đặt cột có phép so sánh chính xác (Bằng `=`) như `transaction_type` đứng trước, và cột so sánh khoảng (Range `>=`, `<`) như `created_at` đứng sau. Nếu đặt cột Range lên trước, MySQL chỉ có thể dùng Index cho cột Range đó mà bỏ qua các cột đằng sau.
