# SYSTEM ARCHITECTURE

## 1. Tổng thể

```text
React + JSX + JavaScript
          |
        HTTPS
          |
REST API / JSON
          |
ASP.NET Core Web API + C#
          |
Application / Domain / Infrastructure
          |
Entity Framework Core
          |
Microsoft SQL Server
```

## 2. Frontend
```text
src/
├── assets/
├── components/
├── layouts/
├── pages/
├── routes/
├── services/
├── hooks/
├── context/
├── utils/
└── App.jsx
```

Feature:
```text
features/
├── auth/
├── books/
├── cart/
├── orders/
├── reviews/
├── wishlist/
└── admin/
```

## 3. Backend
```text
BookStore.Api/
├── Controllers/
├── Middleware/
└── Program.cs

BookStore.Application/
├── DTOs/
├── Services/
├── Interfaces/
├── Validators/
└── Mappings/

BookStore.Domain/
├── Entities/
├── Enums/
├── Exceptions/
└── Interfaces/

BookStore.Infrastructure/
├── Data/
├── Repositories/
├── Services/
└── Migrations/
```

## 4. Request flow
React → Controller → DTO Validation → Application Service → Domain Rules → EF Core → SQL Server → DTO Response.

## 5. Transaction đặt hàng
Validate cart → Validate stock → Calculate price → Validate coupon → Create Order → Create OrderItems → Update inventory → Create Payment → Clear cart → Commit.

Lỗi → Rollback.

## 6. Security
- HTTPS.
- JWT.
- Password hashing.
- Role/Permission authorization.
- DTO validation.
- CORS.
- Rate limiting.
- Audit log.
- Không trả PasswordHash.

## 7. Môi trường
Development → Testing → Production.
