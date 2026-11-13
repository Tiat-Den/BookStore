# Skill: BookStore Backend

## Stack
ASP.NET Core Web API + C# + Entity Framework Core + SQL Server.

## Layering
- API: Controller, middleware, authentication/authorization.
- Application: use case, DTO, validation, service/application logic.
- Domain: entity, enum, domain rules.
- Infrastructure: EF Core, repositories, external integrations.

## API rules
- RESTful naming.
- DTO cho request/response; tránh expose entity trực tiếp.
- Validation ở server.
- HTTP status code phù hợp.
- Error response thống nhất.
- Pagination cho danh sách lớn.
- Filter/sort/search có contract rõ ràng.
- Không trả password/hash/password reset token ra client.

## Authentication
- JWT access token.
- Kiểm tra expiration.
- Role/policy authorization ở backend.
- Endpoint admin/employee phải khai báo authorization rõ ràng.

## Business rules
Backend phải tự tính:
- subtotal
- discount
- shipping fee
- total
- tồn kho
- quyền thao tác

Không tin total hoặc price từ frontend.

## Order
Checkout phải:
1. Xác thực user.
2. Đọc giỏ hàng từ server.
3. Kiểm tra tồn kho.
4. Tính lại giá/discount.
5. Tạo Order + OrderItems.
6. Trừ tồn kho trong transaction.
7. Xóa/điều chỉnh cart.
8. Ghi audit/log phù hợp.

## EF Core
- Dùng migration có kiểm soát.
- Tránh N+1 query.
- Dùng `AsNoTracking()` cho read-only query phù hợp.
- Không query toàn bộ bảng khi chỉ cần một phần dữ liệu.
- Index các cột search/filter/foreign key quan trọng.

## Error handling
Dùng global exception handling/middleware. Không trả stack trace cho production.

## Logging
Log:
- authentication failures
- authorization failures
- checkout/payment failures
- unexpected exceptions
- các thao tác quản trị quan trọng

Không log password, token hoặc dữ liệu nhạy cảm.
