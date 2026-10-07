# [Thực hành] Xoá Cơ sở dữ liệu (CSDL) trên MySQL Workbench

## 🎯 Mục tiêu
Luyện tập các thao tác xóa Cơ sở dữ liệu (Database / Schema) trên MySQL Workbench bằng cả 2 phương pháp: Sử dụng giao diện đồ họa (GUI) và Sử dụng câu lệnh SQL.

⚠️ **Lưu ý quan trọng:** Thao tác xóa CSDL (`DROP`) sẽ xóa vĩnh viễn toàn bộ cấu trúc bảng và dữ liệu bên trong CSDL đó. Cần cẩn trọng và đảm bảo đã sao lưu dữ liệu trước khi thực hiện.

---

## 🛠️ Phương pháp 1: Xoá CSDL bằng giao diện MySQL Workbench (GUI)

### Các bước thực hiện:
1. **Đăng nhập:** Bật MySQL Workbench và đăng nhập vào MySQL Connection bằng tài khoản `root`.
2. **Chọn Schema:** Tại bảng **Navigator** (cột bên trái), chuyển sang tab **SCHEMAS**.
3. **Thực hiện lệnh xóa:** 
   * Nhấp chuột phải vào tên CSDL muốn xóa (ví dụ: `my_database`).
   * Chọn **Drop Schema...**
4. **Xác nhận xóa:** Một cửa sổ thông báo của Workbench xuất hiện:
   * Chọn **Drop Now** để xóa ngay lập tức CSDL.
   * *(Hoặc chọn Review SQL để xem lại câu lệnh DROP DATABASE trước khi thực thi).*
5. **Kiểm tra kết quả:** Kiểm tra lại danh sách ở tab **SCHEMAS**, CSDL được chọn đã biến mất khỏi danh sách.

---

## 💻 Phương pháp 2: Xoá CSDL bằng câu lệnh SQL

### Các bước thực hiện:
1. **Mở cửa sổ soạn thảo:** Trong cửa sổ MySQL Workbench, nhấp vào biểu tượng **New Query Tab** (hình trang giấy có tia sét) hoặc nhấn `Ctrl + T`.
2. **Viết câu lệnh SQL:** Nhập câu lệnh xóa CSDL:
   ```sql
   DROP DATABASE `my_database`;
