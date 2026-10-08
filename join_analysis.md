# Giải trình kỹ thuật: COUNT(o.order_id) vs COUNT(*) trong LEFT JOIN

Khi sử dụng `LEFT JOIN` để giữ lại các khách hàng chưa từng mua hàng (như Charlie), bảng `Orders` sẽ trả về các giá trị `NULL` cho các cột của họ.

- **`COUNT(*)`**: Đếm tổng số dòng được trả về trong tập kết quả, bao gồm cả những dòng có chứa giá trị `NULL`. Do đó, dòng của Charlie (dù có `order_id` là `NULL`) vẫn sẽ được đếm là 1 đơn hàng, gây ra sai lệch dữ liệu nghiêm trọng.
- **`COUNT(o.order_id)`**: Chỉ đếm các giá trị **khác NULL** trên cột `order_id`. Khi một khách hàng chưa từng mua hàng, `o.order_id` mang giá trị `NULL`, hàm đếm sẽ trả về đúng bằng `0`.

Vì vậy, bắt buộc phải dùng `COUNT(o.order_id)` trên cột thuộc bảng bên phải để phản ánh chính xác số lượng đơn hàng.
