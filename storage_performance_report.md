# Báo cáo Phân tích Tài nguyên và Hiệu năng Hệ thống QuickFeed

## 1. Nguyên nhân gây sụp đổ hệ thống (Bắt bệnh Over-Indexing)
Trong cơ sở dữ liệu quan hệ sử dụng bộ lưu trữ InnoDB, mỗi Index được duy trì dưới dạng cấu trúc cây tìm kiếm **B-Tree**. Khi lập trình viên cũ tạo Index bừa bãi trên toàn bộ các cột, hệ thống phải đối mặt với hai vấn đề chí mạng:
* **Tải ghi (Write Overhead) & Lỗi Timeout:** Mỗi lần người dùng đăng một bài viết mới (`INSERT`), MySQL không chỉ ghi dữ liệu vào bảng chính mà phải thực hiện cập nhật ngầm đồng thời trên cấu trúc của tất cả 5 cây B-Tree tương ứng với 5 Index. Việc này tiêu tốn rất nhiều chu kỳ CPU và I/O đĩa, dẫn đến hiện tượng nghẽn cổ chai và gây timeout 5–10 giây.
* **Cạn kiệt ổ cứng (Disk Bloat):** Các cột chứa văn bản dài (`TEXT` như `idx_content(255)`) hoặc các cột có độ phân biệt dữ liệu cực kỳ thấp (`Cardinality` thấp như `is_visible` chỉ có 2 trạng thái 0/1) khiến kích thước file Index phình to nhanh chóng, thậm chí vượt qua cả dung lượng của dữ liệu thực tế (`Data Length`).

## 2. Kế hoạch ra quyết định loại bỏ Index (Decision Matrix)
* **`idx_user_id`**: **GIỮ LẠI**. Cột `user_id` có tính phân biệt (Cardinality) cao, thường xuyên được sử dụng để truy vấn bài viết của một cá nhân cụ thể.
* **`idx_created_at`**: **GIỮ LẠI**. Rất cần thiết cho việc phân trang và sắp xếp bảng tin (Newsfeed) theo thời gian thực.
* **`idx_content`**: **XÓA**. Không nên tạo B-Tree Index truyền thống trên cột văn bản dài vì tiêu tốn dung lượng khổng lồ. Nếu cần tìm kiếm từ khóa trong nội dung, nên sử dụng cơ chế `FULLTEXT` Index.
* **`idx_post_type`**: **XÓA**. Chỉ có 3 giá trị (`'TEXT'`, `'IMAGE'`, `'VIDEO'`), độ phân biệt quá thấp, MySQL Query Optimizer sẽ tự động bỏ qua index này và chọn Full Table Scan.
* **`idx_is_visible`**: **XÓA**. Cột kiểu Boolean chỉ có 2 giá trị (0 hoặc 1). Quét toàn bảng (Full Table Scan) đôi khi còn nhanh hơn việc đi qua B-Tree Index trên tập dữ liệu dạng này.

## 3. Đánh giá kết quả tối ưu
Sau khi thực hiện lệnh `DROP INDEX` cho 3 chỉ mục dư thừa, dung lượng của `Index_length` giảm sút rõ rệt (giảm hàng chục đến hàng trăm Megabyte trên các bảng lớn). Thao tác `INSERT` bài viết mới đã phục hồi tốc độ tức thì do giảm tải được 3 lần cập nhật cấu trúc cây B-Tree ngầm mỗi khi ghi dữ liệu.
