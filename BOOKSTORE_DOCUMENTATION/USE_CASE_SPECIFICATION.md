# USE CASE SPECIFICATION

## 1. Tác nhân
- Customer: mua sách, giỏ hàng, đơn hàng, đánh giá, yêu thích.
- Employee: quản lý sách, kho, đơn hàng và nghiệp vụ được cấp quyền.
- Admin: toàn quyền quản trị, nhân viên, role/permission, báo cáo, audit.

## 2. Use Case

| ID | Use Case | Customer | Employee | Admin |
|---|---|:---:|:---:|:---:|
| UC01 | Đăng ký | ✓ | | |
| UC02 | Đăng nhập | ✓ | ✓ | ✓ |
| UC03 | Quản lý tài khoản | ✓ | ✓ | ✓ |
| UC04 | Xem/tìm kiếm sách | ✓ | ✓ | ✓ |
| UC05 | Quản lý sách | | ✓ | ✓ |
| UC06 | Quản lý danh mục | | ✓ | ✓ |
| UC07 | Quản lý tác giả | | ✓ | ✓ |
| UC08 | Quản lý nhà xuất bản | | ✓ | ✓ |
| UC09 | Quản lý giỏ hàng | ✓ | | |
| UC10 | Đặt hàng | ✓ | | |
| UC11 | Thanh toán | ✓ | | ✓ |
| UC12 | Quản lý đơn hàng | | ✓ | ✓ |
| UC13 | Quản lý tồn kho | | ✓ | ✓ |
| UC14 | Đánh giá sách | ✓ | | ✓ |
| UC15 | Yêu thích | ✓ | | |
| UC16 | Coupon | ✓ | ✓ | ✓ |
| UC17 | Quản lý khách hàng | | ✓* | ✓ |
| UC18 | Quản lý nhân viên | | | ✓ |
| UC19 | Phân quyền | | | ✓ |
| UC20 | Báo cáo | | ✓* | ✓ |
| UC21 | Audit Log | | | ✓ |

`*` phụ thuộc permission.

## 3. UC01 – Đăng ký
**Precondition:** email chưa tồn tại.

1. Nhập họ tên, email, điện thoại, mật khẩu.
2. Frontend validate.
3. Backend kiểm tra trùng.
4. Hash mật khẩu.
5. Tạo User.
6. Trả kết quả.

## 4. UC02 – Đăng nhập
1. Nhập email/mật khẩu.
2. Backend xác thực.
3. Kiểm tra trạng thái.
4. Kiểm tra password hash.
5. Tạo access token.
6. Trả thông tin user.

`LOCKED` không được đăng nhập.

## 5. UC04 – Tìm kiếm sách
1. Nhập keyword.
2. Chọn bộ lọc.
3. React gọi `GET /api/books`.
4. API truy vấn EF Core.
5. SQL Server trả dữ liệu.
6. API phân trang.
7. React hiển thị.

## 6. UC09 – Giỏ hàng
1. Chọn sách và quantity.
2. Backend kiểm tra tồn.
3. Tạo/cập nhật CartItem.
4. Trả giỏ hàng.

## 7. UC10 – Đặt hàng
1. Chọn địa chỉ.
2. Chọn giao hàng và thanh toán.
3. Nhập coupon nếu có.
4. Backend kiểm tra giá, tồn, coupon.
5. Tạo Order và OrderItems.
6. Cập nhật inventory.
7. Tạo Payment.
8. Xóa CartItems.
9. Commit transaction.

Nếu lỗi → rollback.

## 8. UC12 – Quản lý đơn hàng
Employee/Admin có quyền xem, lọc, xác nhận, processing, shipping, delivered và hủy theo điều kiện. Mọi thay đổi quan trọng ghi AuditLog.

## 9. UC13 – Quản lý tồn kho
Xem tồn, nhập kho, điều chỉnh, xem lịch sử. Không cho tồn âm và mọi thay đổi tạo InventoryTransaction.

## 10. UC14 – Đánh giá
Customer phải đã mua sản phẩm. Rating từ 1 đến 5.

## 11. UC18 – Quản lý nhân viên
Admin tạo, sửa, khóa/mở khóa và gán role cho nhân viên.

## 12. UC19 – Phân quyền
Admin chọn Role → Permission → cập nhật RolePermission → AuditLog.

## 13. Include/Extend
- Đặt hàng include kiểm tra tồn kho.
- Đặt hàng include tính tổng tiền.
- Đặt hàng include kiểm tra coupon.
- Thanh toán online extend Đặt hàng.
- Review include kiểm tra lịch sử mua.
