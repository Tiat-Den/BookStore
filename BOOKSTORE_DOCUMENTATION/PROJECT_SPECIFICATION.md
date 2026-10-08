## 1.1. Tên dự án
**BookStore – Website thương mại điện tử bán sách**

## 1.2. Loại hệ thống
Hệ thống thương mại điện tử (E-Commerce) chuyên kinh doanh sách trực tuyến.

## 1.3. Mục tiêu
- Khách hàng tìm kiếm, xem và mua sách trực tuyến.
- Khách hàng quản lý tài khoản, giỏ hàng, đơn hàng và đánh giá.
- Nhân viên quản lý sách, tồn kho và xử lý đơn hàng.
- Admin quản lý toàn bộ hệ thống, người dùng, phân quyền và báo cáo.
- Hệ thống có kiến trúc rõ ràng, bảo mật và có khả năng mở rộng.

Hệ thống bao gồm: quản lý tài khoản; sách; danh mục; tác giả; nhà xuất bản; thể loại; giỏ hàng; đơn hàng; thanh toán; giao hàng; tồn kho; khuyến mãi; đánh giá; yêu thích; tìm kiếm/lọc; khách hàng; nhân viên; phân quyền; thống kê và nội dung website.

| Tác nhân | Mô tả |
|---|---|
| Khách hàng | Tìm kiếm, xem và mua sách |
| Nhân viên | Xử lý sách, kho, đơn hàng và hỗ trợ khách hàng |
| Admin | Quản trị toàn bộ hệ thống |

## 4.1. Khách hàng
Đăng ký, đăng nhập, quản lý tài khoản; xem/tìm kiếm/lọc sách; giỏ hàng; yêu thích; đặt hàng; thanh toán; theo dõi và hủy đơn theo điều kiện; lịch sử mua; đánh giá; coupon; hỗ trợ.

## 4.2. Nhân viên
Đăng nhập quản trị; quản lý sách, danh mục, tác giả, nhà xuất bản, thể loại theo quyền; quản lý tồn kho; xem và xử lý đơn hàng; cập nhật trạng thái; hỗ trợ khách hàng; quản lý đánh giá theo quyền.

Nhân viên không được quản lý Admin hoặc thay đổi quyền hệ thống nếu chưa được cấp quyền.

## 4.3. Admin
Toàn quyền quản lý tài khoản, khách hàng, nhân viên, vai trò, quyền, sách, danh mục, tác giả, nhà xuất bản, thể loại, kho, đơn hàng, thanh toán, giao hàng, khuyến mãi, đánh giá, nội dung, báo cáo, cấu hình và audit log.

## 5.1. Đăng ký tài khoản
Thông tin: họ tên, email, số điện thoại, mật khẩu, xác nhận mật khẩu. Email không trùng, dữ liệu hợp lệ và mật khẩu phải đáp ứng yêu cầu bảo mật.

Người dùng đăng nhập bằng email/số điện thoại và mật khẩu. Hệ thống xác định vai trò `CUSTOMER`, `EMPLOYEE` hoặc `ADMIN` và chuyển đến giao diện tương ứng.

Thông tin sách: ID, ISBN, tên, mô tả, ảnh bìa, giá bán, giá nhập, giá khuyến mãi, tồn kho, số lượng bán, tác giả, NXB, thể loại, năm xuất bản, số trang, ngôn ngữ, kích thước, trọng lượng, trạng thái, ngày tạo/cập nhật.

Chức năng: thêm, sửa, xem, tìm kiếm, lọc, cập nhật giá/tồn kho/trạng thái, ẩn và xóa mềm.

Thêm, sửa, xóa, xem, tìm kiếm, kích hoạt/vô hiệu hóa. Có thể hỗ trợ danh mục cha/con.

```text
Danh mục
├── Văn học
├── Kinh tế
├── Kỹ năng sống
├── Công nghệ
├── Thiếu nhi
└── Giáo dục
```

Thông tin: ID, tên, tiểu sử, ảnh, quốc tịch, trạng thái. Hỗ trợ thêm/sửa/xóa/xem/tìm kiếm. Quan hệ sách–tác giả là nhiều-nhiều.

Thông tin: ID, tên, địa chỉ, email, số điện thoại, website, trạng thái. Hỗ trợ thêm/sửa/xóa/xem/tìm kiếm.

Mỗi khách hàng có một giỏ hàng gồm sản phẩm, số lượng, đơn giá và thành tiền. Hỗ trợ thêm, xóa, tăng/giảm số lượng, xóa toàn bộ và xem tổng tiền. Phải kiểm tra tồn kho trước khi đặt.

### 12.1. Thông tin
Mã đơn, khách hàng, địa chỉ, sản phẩm, tổng tiền hàng, giảm giá, phí vận chuyển, tổng thanh toán, phương thức và trạng thái thanh toán, trạng thái đơn, ngày tạo/cập nhật.

### 12.2. Trạng thái
```text
PENDING → CONFIRMED → PROCESSING → SHIPPING → DELIVERED
```
Trạng thái bổ sung: `CANCELLED`, `RETURNED`.

### 12.3. Quy tắc
Không chuyển trạng thái tùy ý; phải tuân thủ luồng nghiệp vụ.

Hỗ trợ kiến trúc cho COD, thanh toán trực tuyến, ví điện tử và cổng thanh toán bên thứ ba. Thông tin gồm Payment ID, Order ID, phương thức, số tiền, mã giao dịch, trạng thái và thời gian. Trạng thái: `PENDING`, `PAID`, `FAILED`, `REFUNDED`.

Thông tin người nhận, số điện thoại, địa chỉ, tỉnh/thành, quận/huyện, phường/xã, phí vận chuyển, đơn vị vận chuyển, mã vận đơn và trạng thái giao hàng.

Theo dõi số lượng tồn, nhập, bán, điều chỉnh và lịch sử thay đổi kho. Không cho phép đặt hàng vượt tồn kho.

Coupon gồm mã, tên chương trình, loại giảm, giá trị giảm, đơn tối thiểu, mức giảm tối đa, số lượt sử dụng, thời gian hiệu lực và trạng thái. Loại: `PERCENT`, `FIXED_AMOUNT`. Phải kiểm tra hiệu lực, thời gian, giới hạn và giá trị đơn hàng.

Khách hàng đã mua sách có thể đánh giá. Thông tin: ID, khách hàng, sách, đơn hàng, số sao 1–5, nội dung, ngày và trạng thái. Có thể giới hạn một đánh giá cho mỗi sản phẩm trong một đơn.

Khách hàng có thể thêm, xóa và xem sách yêu thích. Một sách chỉ xuất hiện một lần trong danh sách của một khách hàng.

Tìm theo tên sách, ISBN, tác giả, nhà xuất bản, thể loại. Lọc theo giá, thể loại, tác giả, NXB, đánh giá, còn hàng. Sắp xếp theo mới nhất, giá tăng/giảm, bán chạy, đánh giá cao.

Admin xem, tìm kiếm, xem chi tiết, khóa/mở khóa tài khoản và lịch sử mua hàng. Nhân viên chỉ xem thông tin cần thiết theo quyền.

Admin thêm, sửa, xem, khóa/mở khóa, đặt vai trò, phân quyền và xem lịch sử. Thông tin: ID, họ tên, email, số điện thoại, địa chỉ, chức vụ, vai trò, trạng thái, ngày tạo.

Sử dụng RBAC (Role-Based Access Control). Vai trò mặc định: `ADMIN`, `EMPLOYEE`, `CUSTOMER`. Có thể mở rộng `WAREHOUSE_MANAGER`, `ORDER_MANAGER`, `CONTENT_MANAGER`.

Ví dụ permission: `PRODUCT_VIEW`, `PRODUCT_CREATE`, `PRODUCT_UPDATE`, `PRODUCT_DELETE`, `ORDER_VIEW`, `ORDER_UPDATE`, `USER_VIEW`, `USER_UPDATE`, `EMPLOYEE_CREATE`, `EMPLOYEE_UPDATE`, `EMPLOYEE_DELETE`.

Hiển thị tổng doanh thu, tổng đơn hàng, đơn đang xử lý, số khách hàng, số sách, sách sắp hết, sản phẩm bán chạy, doanh thu theo thời gian và đơn theo trạng thái.

Báo cáo doanh thu theo ngày/tháng/quý/năm; đơn hàng theo tổng/thành công/hủy/đang xử lý; sản phẩm bán chạy/bán chậm/sắp hết/hết hàng.

## 25.1. Website khách hàng
```text
Trang chủ
Danh sách sách
Chi tiết sách
Tìm kiếm
Giỏ hàng
Thanh toán
Đăng nhập / Đăng ký / Quên mật khẩu
Tài khoản cá nhân
Đơn hàng / Chi tiết đơn hàng
Yêu thích
Đánh giá
```

## 25.2. Trang quản trị
```text
Dashboard
Quản lý sách / danh mục / tác giả / nhà xuất bản / thể loại
Quản lý kho / đơn hàng / khách hàng / nhân viên
Quản lý vai trò / quyền / khuyến mãi / đánh giá
Báo cáo / Cài đặt / Nhật ký hệ thống
```

## 26.1. Bảo mật
- Hash mật khẩu, không lưu plain text.
- HTTPS trong production.
- Kiểm tra quyền API.
- Validate dữ liệu đầu vào.
- Phòng chống SQL Injection và XSS.
- Quản lý phiên đăng nhập an toàn.
- Khóa tài khoản và ghi log hoạt động quan trọng.

## 26.2. Hiệu năng
- Phân trang.
- Tối ưu truy vấn và index.
- Cache phù hợp.
- Tối ưu ảnh.
- Hạn chế truy vấn dư thừa.

## 26.3. Khả năng mở rộng
Có thể mở rộng thanh toán, vận chuyển, khuyến mãi, thông báo, email, đăng nhập mạng xã hội, mobile app và API bên thứ ba.

```text
Users
Roles
Permissions
Role_Permissions

Books
Categories
Authors
Publishers
Book_Authors
Book_Categories

Carts
Cart_Items
Orders
Order_Items
Payments
Shipments
Inventories
Inventory_Transactions
Coupons
Coupon_Usages
Reviews
Wishlists
Wishlist_Items
Addresses
Notifications
Audit_Logs
```

```text
User 1 ─── N Order
Order 1 ─── N OrderItem
Book 1 ─── N OrderItem
Book N ─── N Author       → Book_Author
Book N ─── N Category     → Book_Category
User 1 ─── N Review
Book 1 ─── N Review
```

- **BR-01:** Email đăng ký không được trùng.
- **BR-02:** Mật khẩu phải được hash trước khi lưu.
- **BR-03:** Không đặt số lượng vượt tồn kho.
- **BR-04:** Giá bán >= 0.
- **BR-05:** Chỉ khách hàng đã mua mới được đánh giá.
- **BR-06:** Coupon phải còn hiệu lực và trong giới hạn sử dụng.
- **BR-07:** Đơn hàng tuân thủ quy trình chuyển trạng thái.
- **BR-08:** Khách chỉ hủy đơn ở trạng thái cho phép.
- **BR-09:** Người dùng chỉ thực hiện chức năng có quyền.
- **BR-10:** Dữ liệu nghiệp vụ quan trọng nên soft delete.

```text
Khách hàng → Tìm kiếm sách → Xem chi tiết → Thêm giỏ
→ Kiểm tra giỏ → Nhập địa chỉ → Chọn giao hàng
→ Chọn thanh toán → Áp dụng coupon → Đặt hàng
→ Hệ thống tạo Order → Nhân viên xác nhận
→ Chuẩn bị hàng → Giao hàng → Khách nhận hàng
→ Hoàn thành → Khách đánh giá
```

```text
PENDING → CONFIRMED → PROCESSING → SHIPPING → DELIVERED

PENDING ─────→ CANCELLED
CONFIRMED ───→ CANCELLED
```

```text
Admin/Nhân viên → Tạo sách → Nhập thông tin → Chọn danh mục
→ Chọn tác giả → Chọn nhà xuất bản → Nhập giá
→ Nhập tồn kho → Lưu → Sách được hiển thị
```

## Authentication
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
```

## Categories
```http
GET    /api/categories
POST   /api/categories
PUT    /api/categories/{id}
DELETE /api/categories/{id}
```

## Cart
```http
GET    /api/cart
POST   /api/cart/items
PUT    /api/cart/items/{id}
DELETE /api/cart/items/{id}
```

## Orders
```http
GET    /api/orders
GET    /api/orders/{id}
POST   /api/orders
PUT    /api/orders/{id}/status
POST   /api/orders/{id}/cancel
```

## Reviews
```http
GET    /api/books/{id}/reviews
POST   /api/books/{id}/reviews
PUT    /api/reviews/{id}
DELETE /api/reviews/{id}
```

## Users
```http
GET    /api/users
GET    /api/users/{id}
PUT    /api/users/{id}
PATCH  /api/users/{id}/status
```

```text
ACTIVE
INACTIVE
LOCKED
```
Tài khoản `LOCKED` không được đăng nhập.

Ghi lại đăng nhập/đăng xuất, tạo tài khoản, thay đổi quyền, CRUD sách, cập nhật tồn kho, cập nhật đơn hàng, thay đổi trạng thái tài khoản và coupon.

```text
id
user_id
action
entity
entity_id
old_value
new_value
ip_address
user_agent
created_at
```

Hỗ trợ thông báo đặt hàng thành công, xác nhận đơn, đang giao, đã giao, hủy đơn, khuyến mãi và sản phẩm yêu thích có giảm giá.

### Khách hàng
- Đăng ký/đăng nhập.
- Tìm kiếm và xem sách.
- Thêm giỏ và đặt hàng.
- Theo dõi đơn.
- Đánh giá sản phẩm đã mua.

### Nhân viên
- Đăng nhập.
- Quản lý sách theo quyền.
- Xử lý đơn hàng.
- Cập nhật tồn kho.
- Xem thông tin cần thiết của khách.

### Admin
- Quản lý toàn bộ hệ thống.
- Quản lý nhân viên và phân quyền.
- Quản lý sách, đơn hàng, khách hàng.
- Xem báo cáo và audit log.

Hệ thống sử dụng kiến trúc **Frontend – Backend – Database**.

```text
┌──────────────────────────────┐
│          FRONTEND            │
│        React + JSX           │
│          JavaScript          │
│  Website khách hàng          │
│  Website Admin / Nhân viên   │
└──────────────┬───────────────┘
               │ HTTP / REST API
               ▼
┌──────────────────────────────┐
│           BACKEND            │
│     ASP.NET Core Web API     │
│             C#               │
│ Authentication / Authorization│
│ Business Logic / Management  │
└──────────────┬───────────────┘
               │ Entity Framework Core
               ▼
┌──────────────────────────────┐
│          DATABASE            │
│        SQL Server            │
└──────────────────────────────┘
```

## 39.1. Frontend – React + JSX
Sử dụng **React + JSX (JavaScript XML) + JavaScript** để xây dựng giao diện. Đảm nhiệm giao diện khách hàng, giao diện Admin/Nhân viên, tìm kiếm, giỏ hàng, đặt hàng, tài khoản và giao tiếp HTTP/REST API.

## 39.2. Backend – ASP.NET Core Web API
Sử dụng **ASP.NET Core Web API + C#** để xử lý request, REST API, xác thực, phân quyền và toàn bộ nghiệp vụ bán hàng.

## 39.3. ORM – Entity Framework Core
Sử dụng **Entity Framework Core** để kết nối ASP.NET Core với SQL Server, mapping Entity/Table, CRUD, LINQ, quan hệ và Migration.

## 39.4. Database – SQL Server
Sử dụng **Microsoft SQL Server** để lưu trữ người dùng, sách, danh mục, đơn hàng, thanh toán, kho, khuyến mãi, đánh giá và các dữ liệu hệ thống.

## 39.5. Bảng công nghệ
| Thành phần | Công nghệ | Vai trò |
|---|---|---|
| Frontend | **React** | Xây dựng giao diện |
| Giao diện | **JSX** | Viết UI trong React |
| Ngôn ngữ Frontend | **JavaScript** | Logic phía Client |
| Giao tiếp | **HTTP / REST API** | Frontend – Backend |
| Backend | **ASP.NET Core Web API** | API và nghiệp vụ |
| Ngôn ngữ Backend | **C#** | Phát triển Backend |
| ORM | **Entity Framework Core** | Kết nối Database |
| Database | **Microsoft SQL Server** | Lưu trữ dữ liệu |

## 39.6. Luồng xử lý
```text
React + JSX
     ↓
HTTP / REST API
     ↓
ASP.NET Core Web API + C#
     ↓
Entity Framework Core
     ↓
SQL Server
```

## 39.7. Ví dụ luồng đặt sách
```text
Khách hàng → React + JSX → HTTP POST
→ ASP.NET Core Web API → Xác thực/Phân quyền
→ Xử lý nghiệp vụ → EF Core → SQL Server
→ HTTP Response → React + JSX → Hiển thị kết quả
```

## 39.8. Stack công nghệ chính
> **Frontend:** React + JSX + JavaScript  
> **Backend:** ASP.NET Core Web API + C#  
> **ORM:** Entity Framework Core  
> **Database:** Microsoft SQL Server  
> **Communication:** HTTP/REST API

## Version 1.0 – MVP
Đăng ký, đăng nhập, sách, danh mục, tìm kiếm, giỏ hàng, đặt hàng, COD, đơn hàng, khách hàng và Admin.

## Version 1.1
Đánh giá, yêu thích, coupon, thống kê và quản lý kho.

## Version 2.0
Thanh toán trực tuyến, tích hợp vận chuyển, thông báo, email, dashboard nâng cao và audit log nâng cao.

BookStore hướng tới hệ thống bán sách có giao diện thân thiện, quy trình mua hàng rõ ràng, quản lý sản phẩm/đơn hàng/kho hiệu quả, phân quyền rõ ràng, bảo mật, cơ sở dữ liệu chuẩn hóa, API rõ ràng và kiến trúc có khả năng mở rộng.

| Chức năng | Khách hàng | Nhân viên | Admin |
|---|:---:|:---:|:---:|
| Đăng ký | ✓ | - | - |
| Đăng nhập | ✓ | ✓ | ✓ |
| Quản lý tài khoản | ✓ | ✓ | ✓ |
| Xem sách | ✓ | ✓ | ✓ |
| Quản lý sách | - | ✓ | ✓ |
| Quản lý danh mục | - | ✓ | ✓ |
| Quản lý tác giả | - | ✓ | ✓ |
| Quản lý NXB | - | ✓ | ✓ |
| Giỏ hàng | ✓ | - | - |
| Đặt hàng | ✓ | - | - |
| Xử lý đơn hàng | - | ✓ | ✓ |
| Thanh toán | ✓ | - | ✓ |
| Quản lý kho | - | ✓ | ✓ |
| Đánh giá | ✓ | ✓* | ✓* |
| Yêu thích | ✓ | - | - |
| Coupon | ✓ | - | ✓ |
| Quản lý khách hàng | - | ✓* | ✓ |
| Quản lý nhân viên | - | - | ✓ |
| Phân quyền | - | - | ✓ |
| Báo cáo | - | ✓* | ✓ |
| Audit Log | - | - | ✓ |
| Cấu hình hệ thống | - | - | ✓ |

`*` Phụ thuộc quyền được cấp.

Tài liệu này là đặc tả chức năng và nghiệp vụ nền tảng cho hệ thống **BookStore E-Commerce**.

Các tài liệu tiếp theo:
1. `USE_CASE_SPECIFICATION.md`
2. `DATABASE_DESIGN.md`
3. `ERD.md`
4. `API_SPECIFICATION.md`
5. `SYSTEM_ARCHITECTURE.md`
6. `UI_SPECIFICATION.md`
7. `BUSINESS_RULES.md`
8. `TEST_CASES.md`

Mọi thay đổi về chức năng, dữ liệu hoặc nghiệp vụ cần được cập nhật để đảm bảo tính nhất quán giữa **Use Case → Database → API → Frontend → Backend**.
