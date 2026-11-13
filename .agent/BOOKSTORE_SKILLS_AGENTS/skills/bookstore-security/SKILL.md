# Skill: BookStore Security

## Authentication
- Password hash bằng thuật toán/framework phù hợp.
- JWT secret không hard-code.
- Token có expiration.
- Không lưu token/password trong log.
- Có cơ chế logout/revoke phù hợp với kiến trúc.

## Authorization
Roles:
- Customer
- Employee
- Admin

Không dùng kiểm tra role chỉ ở frontend.

## Input security
- Validate mọi input ở backend.
- Dùng parameterized queries/EF Core.
- Chống mass assignment bằng DTO.
- Sanitize nội dung hiển thị nếu có HTML/user-generated content.

## E-commerce security
- Không tin giá từ client.
- Không tin discount từ client.
- Không tin stock từ client.
- Không cho client tự đổi order owner.
- Không cho client tự set payment status thành PAID.
- Không cho user truy cập order của user khác.

## Sensitive data
Không commit:
- `.env` chứa secret thật
- production connection string
- JWT secret
- API key
- payment secret

## Security review checklist
- Broken access control
- IDOR
- SQL injection
- XSS
- CSRF nếu kiến trúc yêu cầu
- insecure file upload
- rate limiting cho endpoint nhạy cảm
- excessive data exposure
- insecure password reset
