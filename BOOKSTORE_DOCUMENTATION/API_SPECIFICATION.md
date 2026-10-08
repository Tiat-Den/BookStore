# API SPECIFICATION

## Base
```text
/api
```

## Response
```json
{
  "success": true,
  "data": {}
}
```

Lỗi:
```json
{
  "success": false,
  "message": "Validation failed",
  "errors": []
}
```

## Auth
```http
POST /api/auth/register
POST /api/auth/login
POST /api/auth/logout
POST /api/auth/forgot-password
POST /api/auth/reset-password
```

## Books
```http
GET    /api/books
GET    /api/books/{id}
POST   /api/books
PUT    /api/books/{id}
DELETE /api/books/{id}
PATCH  /api/books/{id}/status
```

Ví dụ query:
`?page=1&pageSize=20&keyword=clean&categoryId={id}&minPrice=50000&maxPrice=200000&sort=price_asc`

## Categories / Authors / Publishers
```http
GET/POST/PUT/DELETE /api/categories
GET/POST/PUT/DELETE /api/authors
GET/POST/PUT/DELETE /api/publishers
```

## Cart
```http
GET    /api/cart
POST   /api/cart/items
PUT    /api/cart/items/{id}
DELETE /api/cart/items/{id}
DELETE /api/cart
```

## Orders
```http
GET   /api/orders
GET   /api/orders/{id}
POST  /api/orders
PATCH /api/orders/{id}/status
POST  /api/orders/{id}/cancel
```

## Payments
```http
POST /api/payments
GET  /api/payments/{id}
POST /api/payments/{id}/callback
```

## Inventory
```http
GET  /api/inventory
GET  /api/inventory/{bookId}
POST /api/inventory/adjust
GET  /api/inventory/transactions
```

## Reviews
```http
GET    /api/books/{bookId}/reviews
POST   /api/books/{bookId}/reviews
PUT    /api/reviews/{id}
DELETE /api/reviews/{id}
```

## Wishlist
```http
GET    /api/wishlist
POST   /api/wishlist/items
DELETE /api/wishlist/items/{bookId}
```

## Coupons
```http
GET  /api/coupons
POST /api/coupons
PUT  /api/coupons/{id}
DELETE /api/coupons/{id}
POST /api/coupons/validate
```

## Users / Employees / Roles
```http
GET/PATCH/PUT /api/users
GET/POST/PUT/PATCH /api/employees
GET/POST/PUT /api/roles
PUT /api/roles/{id}/permissions
```

## Reports
```http
GET /api/reports/revenue
GET /api/reports/orders
GET /api/reports/products
GET /api/reports/inventory
```

## Authentication
Đề xuất JWT Bearer:
```http
Authorization: Bearer <access_token>
```

Backend luôn kiểm tra Role/Permission.
