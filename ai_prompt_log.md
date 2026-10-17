Nhật Ký Sử Dụng AI (AI Prompt Log)

Dự án: Thiết kế lại Cơ sở dữ liệu HealthSync

Vai trò: Data Modeling Assistant (Trợ lý mô hình hóa dữ liệu)

Prompt 1: Tìm hiểu Anti-pattern trong thiết kế trạng thái

Nội dung Prompt: "Trong thiết kế cơ sở dữ liệu quan hệ, tại sao việc dùng một cột is_active (kiểu TINYINT/BOOLEAN) để theo dõi vòng đời của một Đơn hàng/Lịch hẹn lại là một thiết kế tồi (Anti-pattern)? Tôi nên thay thế bằng cấu trúc nào trong MySQL để quản lý 5 trạng thái?"

Mục đích: Hiểu rõ tác hại của việc dùng Boolean cho quy trình đa trạng thái và chọn kiểu dữ liệu ENUM tối ưu.

Bài học rút ra: Cột Boolean không thể thể hiện tính mở rộng và trạng thái chuyển giao. Dùng ENUM giúp ràng buộc dữ liệu trực tiếp ở tầng Database, tránh chèn dữ liệu rác.

Prompt 2: Lựa chọn kiểu dữ liệu tài chính

Nội dung Prompt: "Khi thiết kế cột deposit_amount và penalty_fee trong MySQL phục vụ tính toán tài chính và đối soát kế toán, tôi nên dùng kiểu dữ liệu FLOAT, DOUBLE hay DECIMAL? Tại sao?"

Mục đích: Đảm bảo chính xác tính toàn vẹn tài chính, tránh lỗi làm tròn số thực.

Bài học rút ra: Luôn sử dụng DECIMAL(M, D) cho số tiền vì FLOAT/DOUBLE dùng hệ nhị phân xấp xỉ dễ gây ra lỗi sai lệch tiền tệ (Precision rounding errors).

Prompt 3: Tối ưu hóa ràng buộc và Truy vấn kết hợp

Nội dung Prompt: "Viết cho tôi một câu lệnh SQL SELECT kết hợp JOIN giữa bảng Appointments, Patients, Doctors và Prescriptions để kiểm tra danh sách bệnh nhân đã hoàn tất khám bệnh kèm chi tiết đơn thuốc."

Mục đích: Mẫu truy vấn DML kiểm thử tính đúng đắn của mối quan hệ 1-1 / 1-N giữa Lịch hẹn và Đơn thuốc.

Bài học rút ra: Sử dụng LEFT JOIN hoặc INNER JOIN tùy thuộc vào việc muốn lọc chính xác trạng thái COMPLETED hay hiển thị toàn bộ lịch hẹn.
