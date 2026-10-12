# Báo cáo Đánh đổi Hiệu năng và Lưu trữ Hệ thống SmartFactory

## 1. Vấn đề "Fat Index" (Covering Index quá đà)
Trong các hệ thống IoT thời gian thực (Real-time), dữ liệu nhiệt độ và độ ẩm liên tục được gửi về từ hàng chục ngàn cảm biến. Việc kỹ sư trước đó nhét toàn bộ các cột dữ liệu thay đổi liên tục (`temperature`, `humidity`, `status`) vào chung một Composite Index (`idx_fat_covering`) gây ra hai hệ lụy nghiêm trọng:
* **Write Penalty (Hình phạt khi Ghi):** Mỗi khi có một bản ghi mới được chèn (`INSERT`), MySQL không chỉ ghi dữ liệu vào bảng chính mà phải thực hiện sắp xếp lại cấu trúc cây B-Tree cồng kềnh chứa toàn bộ các giá trị cảm biến. Điều này làm chậm luồng Ghi trầm trọng, dẫn đến tắc nghẽn dữ liệu (Data Loss).
* **Storage Bloat (Phình to ổ cứng):** Chi phí lưu trữ của Index tăng phi mã, vượt quá cả dung lượng bảng gốc, đẩy chi phí hạ tầng Cloud lên cao.

## 2. Giải pháp chuyển đổi sang "Lean Index" (Chỉ mục tinh gọn)
* **Thiết kế mới:** Thay thế `idx_fat_covering` bằng `idx_lean_search(sensor_id, recorded_at)`.
* **Sự đánh đổi:** 
  - Truy vấn SELECT từ Dashboard sẽ không còn được hưởng trọn vẹn đặc quyền "Covering Index" (cột `Extra` trong lệnh `EXPLAIN` chuyển từ `Using index` sang việc phải thực hiện *Table Lookup* để lấy các giá trị thô).
  - Bù lại, tốc độ `INSERT` của hệ thống được phục hồi mạnh mẽ, giải quyết triệt để tình trạng nghẽn pipeline, đồng thời tiết kiệm hàng chục GB dung lượng lưu trữ SSD.
