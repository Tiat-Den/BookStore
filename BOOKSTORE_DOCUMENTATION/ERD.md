# ERD – BOOKSTORE

## Mermaid

```mermaid
erDiagram
    USERS ||--o{ ORDERS : places
    USERS ||--o{ ADDRESSES : owns
    USERS ||--|| CARTS : has
    USERS }o--o{ ROLES : assigned
    ROLES }o--o{ PERMISSIONS : grants
    BOOKS }o--o{ AUTHORS : written_by
    BOOKS }o--o{ CATEGORIES : belongs_to
    CARTS ||--o{ CART_ITEMS : contains
    BOOKS ||--o{ CART_ITEMS : appears_in
    ORDERS ||--o{ ORDER_ITEMS : contains
    BOOKS ||--o{ ORDER_ITEMS : ordered
    ORDERS ||--o{ PAYMENTS : has
    ORDERS ||--|| SHIPMENTS : ships
    BOOKS ||--|| INVENTORIES : stocked
    BOOKS ||--o{ INVENTORY_TRANSACTIONS : changes
    USERS ||--o{ REVIEWS : writes
    BOOKS ||--o{ REVIEWS : receives
    USERS ||--|| WISHLISTS : owns
    WISHLISTS ||--o{ WISHLIST_ITEMS : contains
    BOOKS ||--o{ WISHLIST_ITEMS : saved
    COUPONS ||--o{ COUPON_USAGES : used
    USERS ||--o{ COUPON_USAGES : uses
    ORDERS ||--o{ COUPON_USAGES : applies
    USERS ||--o{ NOTIFICATIONS : receives
    USERS ||--o{ AUDIT_LOGS : creates
```

## Quan hệ chính
- User 1-N Order.
- User 1-N Address.
- User 1-1 Cart.
- User N-N Role.
- Role N-N Permission.
- Book N-N Author.
- Book N-N Category.
- Cart 1-N CartItem.
- Order 1-N OrderItem.
- Order 1-N Payment.
- Order 1-1 Shipment.
- Book 1-1 Inventory.
- Book 1-N Review.
- User 1-1 Wishlist.
- Coupon 1-N CouponUsage.

OrderItem lưu snapshot tên và giá tại thời điểm mua.
