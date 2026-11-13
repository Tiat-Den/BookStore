# TEST CASES

## 1. Authentication

| ID | Test | Expected |
|---|---|---|
| TC-AUTH-01 | Register email mới | Thành công |
| TC-AUTH-02 | Register email trùng | Validation/409 |
| TC-AUTH-03 | Password sai | Không login |
| TC-AUTH-04 | Login đúng | Token hợp lệ |
| TC-AUTH-05 | Locked account | 401/403 |
| TC-AUTH-06 | Forgot password | Tạo flow reset |

## 2. Books

| ID | Test | Expected |
|---|---|---|
| TC-BOOK-01 | List books | Có pagination |
| TC-BOOK-02 | Search keyword | Kết quả phù hợp |
| TC-BOOK-03 | Filter price | Đúng range |
| TC-BOOK-04 | Create book | Thành công khi có quyền |
| TC-BOOK-05 | Duplicate ISBN | 409 |
| TC-BOOK-06 | Unauthorized CRUD | 401/403 |

## 3. Cart

| ID | Test | Expected |
|---|---|---|
| TC-CART-01 | Add book | CartItem tạo |
| TC-CART-02 | Add same book | Quantity cập nhật |
| TC-CART-03 | Quantity 0 | Validation |
| TC-CART-04 | Quantity > stock | Từ chối |
| TC-CART-05 | Remove item | Thành công |

## 4. Order

| ID | Test | Expected |
|---|---|---|
| TC-ORDER-01 | Checkout hợp lệ | Order tạo |
| TC-ORDER-02 | Cart rỗng | Từ chối |
| TC-ORDER-03 | Stock không đủ | Rollback |
| TC-ORDER-04 | Coupon hợp lệ | Discount đúng |
| TC-ORDER-05 | Coupon hết hạn | Từ chối |
| TC-ORDER-06 | Cancel hợp lệ | CANCELLED |
| TC-ORDER-07 | Invalid status transition | Từ chối |

## 5. Payment

| ID | Test | Expected |
|---|---|---|
| TC-PAY-01 | COD | Pending |
| TC-PAY-02 | Callback hợp lệ | PAID |
| TC-PAY-03 | Callback giả | Không PAID |
| TC-PAY-04 | Payment fail | FAILED |

## 6. Inventory

| ID | Test | Expected |
|---|---|---|
| TC-INV-01 | Nhập kho | Tăng stock |
| TC-INV-02 | Xuất kho | Giảm đúng |
| TC-INV-03 | Tồn âm | Từ chối |
| TC-INV-04 | Adjustment | Có transaction |

## 7. Review

| ID | Test | Expected |
|---|---|---|
| TC-REV-01 | Buyer review | Thành công |
| TC-REV-02 | Non-buyer review | 403/400 |
| TC-REV-03 | Rating 6 | Validation |
| TC-REV-04 | Sửa review người khác | 403 |

## 8. Authorization

| ID | Test | Expected |
|---|---|---|
| TC-RBAC-01 | Customer gọi Admin API | 403 |
| TC-RBAC-02 | Employee thiếu permission | 403 |
| TC-RBAC-03 | Admin đổi permission | Thành công |
| TC-RBAC-04 | Không token | 401 |

## 9. Security
Kiểm thử SQL Injection, XSS, token giả/hết hạn, brute-force login, CORS, upload file, IDOR và mass assignment.

## 10. Performance
Kiểm thử search dữ liệu lớn, pagination, dashboard, concurrent checkout và race condition tồn kho.

## 11. Acceptance Criteria
Happy path, validation, authorization, error handling, database consistency và audit log phải đạt yêu cầu.
