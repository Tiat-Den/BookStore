# Skill: BookStore Database

## Stack
Microsoft SQL Server + Entity Framework Core.

## Core entities dự kiến
- User
- Role
- Book
- Category
- Author
- Publisher
- Cart
- CartItem
- Order
- OrderItem
- Payment
- Inventory
- Coupon
- Review
- Wishlist
- Notification
- AuditLog

## Design principles
- PK/FK rõ ràng.
- Foreign key có index khi cần.
- Unique constraint cho dữ liệu phải duy nhất.
- NOT NULL cho thuộc tính bắt buộc.
- Decimal phù hợp cho tiền.
- Không dùng floating point cho monetary value.
- Có CreatedAt/UpdatedAt cho entity phù hợp.
- Soft delete chỉ dùng khi nghiệp vụ cần.

## Order snapshot
OrderItem phải lưu dữ liệu cần thiết để lịch sử đơn không phụ thuộc hoàn toàn vào Book hiện tại, đặc biệt:
- UnitPrice
- Quantity
- Product/Book name snapshot khi cần
- Discount snapshot khi cần

## Inventory
Không để stock âm.
Các thao tác nhập/xuất/trừ stock phải xử lý concurrency/transaction phù hợp.

## Transaction
Đặc biệt chú ý:
- checkout
- thanh toán/cập nhật trạng thái thanh toán
- trừ tồn kho
- hoàn hàng

## Migration
Mọi thay đổi schema phải:
1. sửa entity/configuration
2. tạo migration
3. review migration
4. update database
5. cập nhật ERD/documentation nếu có thay đổi quan trọng

Không sửa production database bằng thao tác thủ công thiếu kiểm soát.
