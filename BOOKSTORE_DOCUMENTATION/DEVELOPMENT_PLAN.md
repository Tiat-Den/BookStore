# KẾ HOẠCH PHÁT TRIỂN WEBSITE BOOKSTORE

## 1. Mục tiêu
Xây dựng website thương mại điện tử bán sách với 3 tác nhân: Customer, Employee, Admin.

**Công nghệ:** React + JSX + JavaScript; ASP.NET Core Web API + C#; Entity Framework Core; Microsoft SQL Server; REST API.

## 2. Quy trình tổng thể
**Phân tích → Use Case → Database/ERD → SQL Server → Backend → API → Frontend → Phân quyền → Tích hợp → Kiểm thử → Bảo mật → Tối ưu → Triển khai → Nghiệm thu**

## 3. Kế hoạch từng bước

### Bước 1 — Phân tích yêu cầu
- Xác định phạm vi hệ thống.
- Xác định Customer, Employee, Admin.
- Liệt kê chức năng và quy tắc nghiệp vụ.
- Hoàn thiện `PROJECT_SPECIFICATION.md` và `USE_CASE_SPECIFICATION.md`.

### Bước 2 — Thiết kế Use Case
- Vẽ Use Case tổng quan.
- Vẽ Use Case Customer.
- Vẽ Use Case Employee.
- Vẽ Use Case Admin.
- Mô tả các use case chính.

### Bước 3 — Thiết kế Database
Thiết kế các nhóm bảng:
- Users, Roles, Permissions, UserRoles, RolePermissions.
- Books, Categories, Authors, Publishers.
- Carts, CartItems.
- Orders, OrderItems, Payments, Shipments.
- Inventories, InventoryTransactions.
- Coupons, Reviews, Wishlists.
- Addresses, Notifications, AuditLogs.

Hoàn thiện `DATABASE_DESIGN.md` và `ERD.md`.

### Bước 4 — Tạo SQL Server
- Tạo database `BookStoreDb`.
- Tạo PK/FK, unique key, index và constraint.
- Tạo dữ liệu mẫu.
- Kiểm tra toàn bộ quan hệ.

### Bước 5 — Tạo Backend
Cấu trúc đề xuất:
```text
Backend/
├── BookStore.API/
├── BookStore.Application/
├── BookStore.Domain/
└── BookStore.Infrastructure/
```
Cài ASP.NET Core Web API, EF Core, SQL Server provider, JWT, Swagger.

### Bước 6 — Entity + EF Core
- Tạo Entity.
- Tạo `BookStoreDbContext`.
- Cấu hình Fluent API.
- Tạo migration.
- Update database.
- Kiểm tra kết nối SQL Server.

### Bước 7 — Authentication
Làm:
1. Đăng ký.
2. Đăng nhập.
3. Đăng xuất.
4. Đổi mật khẩu.
5. Quên/reset mật khẩu.
6. JWT.

### Bước 8 — Authorization/RBAC
Tạo quyền cho Books, Orders, Users, Employees, Reports, Roles.
- Customer: mua hàng và quản lý tài khoản.
- Employee: sách, đơn hàng, tồn kho.
- Admin: toàn quyền quản trị và phân quyền.

### Bước 9 — API sách
```text
GET    /api/books
GET    /api/books/{id}
POST   /api/books
PUT    /api/books/{id}
DELETE /api/books/{id}
```
Thêm tìm kiếm, lọc, sắp xếp, phân trang và ảnh.

### Bước 10 — API danh mục/tác giả/NXB
CRUD cho Categories, Authors, Publishers.

### Bước 11 — API giỏ hàng
- Xem giỏ.
- Thêm sản phẩm.
- Sửa số lượng.
- Xóa sản phẩm.
- Xóa giỏ.
- Kiểm tra tồn kho.

### Bước 12 — API đơn hàng
- Tạo đơn.
- Danh sách/chi tiết.
- Hủy đơn.
- Cập nhật trạng thái.

Trạng thái:
`PENDING → CONFIRMED → PROCESSING → SHIPPING → DELIVERED`

Có thể có `CANCELLED`, `RETURNED`.

### Bước 13 — Thanh toán
- Tạo payment.
- Kiểm tra trạng thái.
- Chống thanh toán trùng.
- Trước tiên có thể làm COD/Mock Payment, sau đó tích hợp cổng thật.

### Bước 14 — Tồn kho
- Xem tồn.
- Nhập/xuất kho.
- Điều chỉnh.
- Lưu lịch sử.
- Không cho bán vượt tồn.

### Bước 15 — Review/Wishlist/Coupon
- Review chỉ cho khách đã mua.
- Wishlist thêm/xóa/xem.
- Coupon kiểm tra hạn, lượt dùng và mức giảm.

### Bước 16 — Notification/Audit Log
Gửi thông báo khi đơn thay đổi trạng thái; ghi lại người thực hiện, hành động, thời gian và đối tượng.

## 4. Frontend React

### Bước 17 — Khởi tạo
```text
Frontend/
└── src/
    ├── components/
    ├── pages/
    ├── layouts/
    ├── services/
    ├── hooks/
    ├── context/
    └── utils/
```

### Bước 18 — Layout chung
Làm Header, Footer, Sidebar, Navbar, Modal, Toast, Loading, Pagination.

### Bước 19 — Customer UI
Theo thứ tự:
1. Trang chủ.
2. Danh sách sách.
3. Chi tiết sách.
4. Tìm kiếm/lọc.
5. Đăng ký/đăng nhập.
6. Giỏ hàng.
7. Checkout.
8. Địa chỉ.
9. Đơn hàng.
10. Wishlist.
11. Review.
12. Hồ sơ.

### Bước 20 — Employee UI
Dashboard, Books, Categories, Authors, Publishers, Orders, Inventory, Customers.

### Bước 21 — Admin UI
Dashboard, Users, Employees, Roles, Permissions, Books, Orders, Inventory, Coupons, Reports, Audit Logs.

## 5. Tích hợp

### Bước 22 — Kết nối API
Tạo service:
```text
authService.js
bookService.js
cartService.js
orderService.js
userService.js
inventoryService.js
reportService.js
```
Xử lý JWT, loading, lỗi và thông báo.

### Bước 23 — Bảo vệ route
Bảo vệ `/customer/*`, `/employee/*`, `/admin/*`.
Frontend chỉ hiển thị đúng menu; backend vẫn phải kiểm tra quyền.

## 6. Kiểm thử

### Bước 24 — Test API
Test Authentication, Authorization, Books, Cart, Orders, Payments, Inventory, Reviews, Coupons.

### Bước 25 — Test Frontend
Test form, navigation, responsive, loading, lỗi, search, pagination và checkout.

### Bước 26 — Test phân quyền
- Customer không gọi được API Admin.
- Employee không dùng chức năng chỉ dành cho Admin.
- Admin truy cập được chức năng được cấp.

### Bước 27 — Test nghiệp vụ
Kiểm tra email trùng, sai mật khẩu, vượt tồn kho, coupon hết hạn, hủy đơn sai trạng thái, review khi chưa mua, thanh toán trùng.

## 7. Bảo mật và tối ưu

### Bước 28 — Bảo mật
Hash password, JWT, HTTPS, CORS, validation, authorization backend, kiểm soát upload và audit log.

### Bước 29 — Tối ưu
- Database index.
- Pagination.
- DTO/projection.
- `AsNoTracking` cho truy vấn chỉ đọc.
- Giảm N+1 query.
- Lazy loading/code splitting khi phù hợp.
- Tối ưu ảnh và request.

## 8. Triển khai

### Bước 30 — Môi trường
Tách Development, Staging, Production. Không hard-code connection string, JWT secret hoặc API key.

### Bước 31 — Build
Frontend:
```text
npm install
npm run build
```
Backend:
```text
dotnet restore
dotnet build
dotnet publish
```
Sau đó chạy migration và kiểm tra production database.

## 9. Lịch 20 ngày đề xuất

| Ngày | Công việc |
|---|---|
| 1 | Phân tích yêu cầu |
| 2 | Use Case |
| 3 | Database + ERD |
| 4 | SQL Server + EF Core |
| 5 | Authentication |
| 6 | RBAC |
| 7-8 | Books + Category |
| 9 | Cart |
| 10-11 | Order |
| 12 | Inventory |
| 13 | Payment |
| 14 | Review + Wishlist + Coupon |
| 15 | Customer UI |
| 16 | Employee UI |
| 17 | Admin UI |
| 18 | Tích hợp |
| 19 | Testing |
| 20 | Sửa lỗi + hoàn thiện |

## 10. Definition of Done
Mỗi chức năng chỉ hoàn thành khi:
- [ ] Database có.
- [ ] Entity có.
- [ ] API có.
- [ ] Validation có.
- [ ] Authorization có.
- [ ] Frontend kết nối API.
- [ ] Loading/error được xử lý.
- [ ] Test thành công.
- [ ] Không làm hỏng chức năng cũ.

## 11. Thứ tự code thực tế

```text
Phân tích
  ↓
Use Case
  ↓
ERD + Database
  ↓
SQL Server
  ↓
ASP.NET Core + EF Core
  ↓
Authentication
  ↓
RBAC
  ↓
Books
  ↓
Category/Author/Publisher
  ↓
Cart
  ↓
Order
  ↓
Inventory
  ↓
Payment
  ↓
Review/Wishlist/Coupon
  ↓
React + JSX
  ↓
Customer
  ↓
Employee
  ↓
Admin
  ↓
Tích hợp
  ↓
Testing
  ↓
Security + Performance
  ↓
Deployment
  ↓
Nghiệm thu
```

## 12. Kết quả cuối cùng
Hệ thống phải chạy hoàn chỉnh với Customer, Employee, Admin; SQL Server; ASP.NET Core Web API; EF Core; React + JSX; JWT/RBAC; quản lý sách, giỏ hàng, đơn hàng, thanh toán, giao hàng, tồn kho, khuyến mãi, review, wishlist, notification, audit log, dashboard, báo cáo và kiểm thử.

**Nguyên tắc:** hoàn thành và test Backend/API từng module trước, sau đó mới nối Frontend; không nên làm toàn bộ giao diện trước rồi mới viết Backend.
