# AGENTS.md — BookStore Project

## 1. Mục tiêu
Đây là quy tắc chung cho mọi AI Agent làm việc trên dự án website thương mại điện tử bán sách (BookStore).

## 2. Stack bắt buộc
- Frontend: React + JSX + JavaScript
- Backend: ASP.NET Core Web API + C#
- ORM: Entity Framework Core
- Database: Microsoft SQL Server
- API: RESTful API
- Authentication: JWT
- Authorization: Role-Based Access Control (RBAC)

## 3. Vai trò
- Customer: xem sách, tìm kiếm, giỏ hàng, đặt hàng, thanh toán, đánh giá, yêu thích, theo dõi đơn.
- Employee: xử lý sách, tồn kho, đơn hàng, giao hàng và nghiệp vụ được phân quyền.
- Admin: quản trị người dùng, nhân viên, phân quyền, danh mục, báo cáo, cấu hình và audit.

## 4. Nguyên tắc quan trọng
1. Không tự ý thay đổi database/API contract nếu chưa kiểm tra tài liệu hiện có.
2. Backend là nguồn sự thật cho giá, tồn kho, quyền, trạng thái đơn hàng và nghiệp vụ.
3. Không tin dữ liệu giá, role, discount hoặc stock do frontend gửi lên.
4. Checkout và cập nhật tồn kho phải có transaction phù hợp.
5. OrderItem phải lưu snapshot cần thiết tại thời điểm mua (tên sách, đơn giá, số lượng, giảm giá nếu có).
6. Mọi endpoint quản trị phải kiểm tra quyền ở backend.
7. Password phải được hash an toàn; không lưu plaintext.
8. Không commit secret, connection string thật, JWT key thật hoặc credential.
9. Mọi thay đổi schema/API phải cập nhật tài liệu tương ứng.
10. Ưu tiên code dễ đọc, có validation, logging và xử lý lỗi rõ ràng.

## 5. Quy trình Agent
Phân tích → kiểm tra tài liệu → lập kế hoạch → triển khai → test → review → cập nhật docs.

Nếu task lớn, chia thành các phần nhỏ và xác định dependency trước khi sửa code.

## 6. Definition of Done
Một chức năng chỉ được xem là hoàn thành khi:
- Database/entity cần thiết đã đúng.
- API đã có validation và authorization.
- Frontend đã tích hợp đúng API.
- Có loading/error/empty state phù hợp.
- Có test hoặc kiểm thử thủ công có ghi nhận.
- Không phá vỡ chức năng hiện có.
- Tài liệu được cập nhật nếu contract/schema thay đổi.
