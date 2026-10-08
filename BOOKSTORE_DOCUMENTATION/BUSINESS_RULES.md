# BUSINESS RULES

## Account
- BR-01: Email không trùng.
- BR-02: Password phải hash.
- BR-03: LOCKED không đăng nhập.
- BR-04: User chỉ truy cập dữ liệu đúng quyền.

## Book
- BR-05: ISBN không trùng.
- BR-06: Giá không âm.
- BR-07: Quantity mua không vượt stock.
- BR-08: Không xóa vật lý sách đã có OrderItem.

## Cart
- BR-09: Một Book chỉ có một CartItem trong Cart.
- BR-10: Quantity > 0.
- BR-11: Quantity không vượt stock tại thời điểm kiểm tra.

## Order
- BR-12: Order phải có ít nhất một item.
- BR-13: Backend tính tổng tiền.
- BR-14: Không tin giá từ Frontend.
- BR-15: OrderItem lưu snapshot.
- BR-16: Chỉ transition hợp lệ.
- BR-17: Chỉ hủy khi trạng thái cho phép.

## Payment
- BR-18: COD có trạng thái chờ thanh toán.
- BR-19: Online payment phải verify callback/signature.
- BR-20: Frontend không thể tự đánh dấu PAID.

## Inventory
- BR-21: Không tồn âm.
- BR-22: Mọi thay đổi kho tạo transaction.
- BR-23: Order/inventory xử lý transaction và concurrency.

## Coupon
- BR-24: Code unique.
- BR-25: Chỉ dùng trong thời gian hiệu lực.
- BR-26: Không vượt usage limit.
- BR-27: Đạt minimum order.

## Review
- BR-28: Rating 1–5.
- BR-29: Chỉ người đã mua được review.
- BR-30: Chính sách không cho review trùng.

## RBAC
- BR-31: Backend quyết định authorization.
- BR-32: Customer không gọi API Admin.
- BR-33: Employee chỉ dùng permission được cấp.
- BR-34: Chỉ Admin quản lý Role/Permission.

## Audit
- BR-35: Thao tác quan trọng phải ghi AuditLog.
- BR-36: Không cho sửa/xóa AuditLog tùy tiện.
