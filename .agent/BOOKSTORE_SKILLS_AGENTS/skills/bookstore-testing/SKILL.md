# Skill: BookStore Testing

## Mục tiêu
Đảm bảo chức năng đúng, không regression và business rule được bảo vệ.

## Test levels
### Unit
Test:
- pricing
- discount
- order status transition
- validation
- permission/business rules

### Integration
Test:
- API + database
- authentication
- authorization
- checkout
- inventory
- order lifecycle

### Frontend
Test:
- form validation
- cart behavior
- auth state
- protected routes
- loading/error/empty states

### E2E
Các flow quan trọng:
1. Customer đăng ký/đăng nhập.
2. Tìm sách.
3. Xem chi tiết.
4. Thêm giỏ hàng.
5. Checkout.
6. Theo dõi đơn.
7. Review sau khi đủ điều kiện.
8. Employee xử lý đơn.
9. Admin quản lý dữ liệu.

## Regression
Sau thay đổi lớn phải kiểm tra:
- login
- product listing/detail
- cart
- checkout
- order
- role permissions

## Test case format
Mỗi case nên có:
- ID
- mục tiêu
- precondition
- steps
- test data
- expected result
- actual result
- status

## Negative testing
Luôn kiểm tra:
- thiếu field
- dữ liệu sai kiểu
- quantity <= 0
- stock không đủ
- coupon không hợp lệ
- user không có quyền
- token hết hạn
- duplicate data
- request bị gửi lặp
