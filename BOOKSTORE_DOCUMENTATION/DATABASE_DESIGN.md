# DATABASE DESIGN

## 1. Công nghệ
- Microsoft SQL Server
- Entity Framework Core
- PK đề xuất: `uniqueidentifier`
- Tiền: `decimal(18,2)`
- Ngày giờ: `datetime2`

## 2. Bảng

### Users
`Id PK, FullName, Email UNIQUE, Phone, PasswordHash, Status, CreatedAt, UpdatedAt`

### Roles
`Id PK, Name UNIQUE, Description, CreatedAt`

### Permissions
`Id PK, Code UNIQUE, Name, Description`

### UserRoles
`UserId FK, RoleId FK, PK(UserId, RoleId)`

### RolePermissions
`RoleId FK, PermissionId FK, PK(RoleId, PermissionId)`

### Addresses
`Id PK, UserId FK, ReceiverName, Phone, Province, District, Ward, AddressLine, IsDefault, CreatedAt`

### Categories
`Id PK, ParentId FK NULL, Name, Slug UNIQUE, Description, IsActive, CreatedAt, UpdatedAt`

### Authors
`Id PK, Name, Biography, ImageUrl, Nationality, IsActive`

### Publishers
`Id PK, Name, Address, Email, Phone, Website, IsActive`

### Books
`Id PK, ISBN UNIQUE, Title, Slug UNIQUE, Description, CoverImageUrl, ImportPrice, SalePrice, DiscountPrice, StockQuantity, SoldQuantity, PublisherId FK, PublishedYear, PageCount, Language, Dimensions, Weight, Status, IsDeleted, CreatedAt, UpdatedAt`

### BookAuthors
`BookId FK, AuthorId FK, PK(BookId, AuthorId)`

### BookCategories
`BookId FK, CategoryId FK, PK(BookId, CategoryId)`

### Carts
`Id PK, UserId FK UNIQUE, CreatedAt, UpdatedAt`

### CartItems
`Id PK, CartId FK, BookId FK, Quantity, UnitPrice`

Unique `(CartId, BookId)`.

### Orders
`Id PK, OrderCode UNIQUE, UserId FK, AddressId FK, SubTotal, DiscountAmount, ShippingFee, TotalAmount, PaymentMethod, PaymentStatus, OrderStatus, Note, CreatedAt, UpdatedAt`

### OrderItems
`Id PK, OrderId FK, BookId FK, ProductNameSnapshot, UnitPrice, Quantity, TotalPrice`

### Payments
`Id PK, OrderId FK, PaymentMethod, TransactionCode, Amount, Status, PaidAt, CreatedAt`

### Shipments
`Id PK, OrderId FK UNIQUE, Carrier, TrackingCode, ReceiverName, Phone, Address, ShippingFee, Status, ShippedAt, DeliveredAt`

### Inventories
`Id PK, BookId FK UNIQUE, Quantity, ReservedQuantity, UpdatedAt`

### InventoryTransactions
`Id PK, BookId FK, Type, Quantity, ReferenceType, ReferenceId, Note, CreatedBy FK, CreatedAt`

### Coupons
`Id PK, Code UNIQUE, Name, Type, Value, MinimumOrderAmount, MaximumDiscountAmount, UsageLimit, UsedCount, StartAt, EndAt, IsActive`

### CouponUsages
`Id PK, CouponId FK, UserId FK, OrderId FK, DiscountAmount, UsedAt`

### Reviews
`Id PK, UserId FK, BookId FK, OrderId FK, Rating, Content, Status, CreatedAt, UpdatedAt`

### Wishlists
`Id PK, UserId FK UNIQUE, CreatedAt`

### WishlistItems
`Id PK, WishlistId FK, BookId FK, CreatedAt`

### Notifications
`Id PK, UserId FK, Title, Message, Type, IsRead, CreatedAt`

### AuditLogs
`Id PK, UserId FK NULL, Action, Entity, EntityId, OldValue, NewValue, IpAddress, UserAgent, CreatedAt`

## 3. Index quan trọng
- Users.Email UNIQUE
- Books.ISBN UNIQUE
- Books.Slug UNIQUE
- Orders.OrderCode UNIQUE
- Orders `(UserId, CreatedAt)`
- Orders.OrderStatus
- Reviews.BookId
- CartItems `(CartId, BookId)` UNIQUE
- WishlistItems `(WishlistId, BookId)` UNIQUE
- Coupons.Code UNIQUE

## 4. Migration

```bash
dotnet ef migrations add InitialCreate
dotnet ef database update
```

Không xóa vật lý dữ liệu đã tham gia Order. OrderItem lưu snapshot tên và giá.
