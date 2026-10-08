# UI SPECIFICATION

## 1. Nguyên tắc
- Responsive desktop/tablet/mobile.
- Component tái sử dụng.
- Có Loading/Empty/Error state.
- Validate form.
- Confirmation cho thao tác nguy hiểm.

## 2. Customer

### Home
Header, logo, search, category menu, banner, sách mới, bán chạy, nổi bật, footer.

### Book Listing
Search, filter, sort, pagination, ProductCard.

### Product Card
Ảnh, tên, tác giả, giá, giá giảm, rating, tồn kho, thêm giỏ, yêu thích.

### Product Detail
Ảnh, ISBN, NXB, tác giả, mô tả, giá, quantity, cart, wishlist, review.

### Checkout
```text
Cart → Address → Shipping → Payment → Confirm → Success
```

### Account
Thông tin cá nhân, địa chỉ, đơn hàng, yêu thích, đánh giá, đổi mật khẩu.

## 3. Employee/Admin

Sidebar:
```text
Dashboard
Books
Categories
Authors
Publishers
Inventory
Orders
Customers
Coupons
Reviews
Reports
```

Admin bổ sung:
```text
Employees
Roles & Permissions
Audit Logs
System Settings
```

## 4. Components
`Button, Input, Select, Modal, Table, Pagination, SearchBox, ProductCard, Badge, Toast, ConfirmDialog, Loading, EmptyState, ErrorState`.

## 5. UX
Disable submit khi xử lý; giữ dữ liệu khi API lỗi; confirmation trước delete/cancel; lỗi hiển thị tại field; quantity không âm/0.
