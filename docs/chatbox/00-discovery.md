# Báo cáo Giai đoạn 0: Khảo sát Codebase (Discovery)

**Dự án:** Website Thương mại Điện tử Bán sách (BookStore)  
**Thời gian:** 12/10/2026  
**Người thực hiện:** Antigravity AI Agent  
**Trạng thái:** Hoàn thành khảo sát (Không sửa đổi mã nguồn)

---

## 1. Cấu trúc Solution & Công nghệ hiện có

### Backend (.NET 8 Clean Architecture)
- **Framework:** .NET 8, ASP.NET Core Web API.
- **Projects:**
  - `BookStore.Domain`: Chứa các Entities (`BookEntities`, `OrderAndCartEntities`, `UserEntities`, `InventoryAndMarketingEntities`) và Enums.
  - `BookStore.Application`: Chứa DTOs, Interfaces (`IBookService`, `ICartService`, `IOrderService`, `IAuthService`...), Services (`JwtTokenGenerator`).
  - `BookStore.Infrastructure`: Chứa `BookStoreDbContext`, EF Core Migrations, triển khai các Services (`BookService`, `CartService`, `OrderService`, `EmailService`...).
  - `BookStore.Api`: Controllers (`AuthController`, `BooksController`, `CartController`, `OrdersController`, `UsersController`...), Program.cs, Middleware bắt lỗi tập trung (`ExceptionMiddleware`), Swagger.
- **ORM & Database:** EF Core 8.x, SQL Server.
- **CORS:** Đã cấu hình `AllowAll` (cho phép mọi origin/header/method).
- **Build Status:** `dotnet build` thành công 100% (0 Warnings, 0 Errors).

### Frontend (React + Vite)
- **Công nghệ:** React 18 / Vite 8.
- **HTTP Client:** `axios` trong [apiClient.js](file:///d:/PhạmTiếnĐạt/Web-TMDT/Cuối%20Kỳ/Frontend/src/services/apiClient.js) trỏ về `http://localhost:5193/api`.
- **Lưu trữ Token:** `localStorage.getItem('bookstore_token')`.
- **Layout/Navigation:** [NavbarAndFooter.jsx](file:///d:/PhạmTiếnĐạt/Web-TMDT/Cuối%20Kỳ/Frontend/src/components/NavbarAndFooter.jsx), [App.jsx](file:///d:/PhạmTiếnĐạt/Web-TMDT/Cuối%20Kỳ/Frontend/src/App.jsx).
- **Build Status:** `npm run build` thành công 100%.

---

## 2. Thông tin Xác thực (Authentication & Authorization)
- **Cơ chế:** JWT Bearer Authentication.
- **Claim UserId:** Được sinh ra bởi [JwtTokenGenerator.cs](file:///d:/PhạmTiếnĐạt/Web-TMDT/Cuối%20Kỳ/Backend/BookStore.Application/Services/JwtTokenGenerator.cs) dưới dạng:
  - `ClaimTypes.NameIdentifier` (`user.Id.ToString()`) - Kiểu `int`.
- **Claim Role:** `ClaimTypes.Role` (ví dụ: `Admin`, `Customer`, `Employee`).
- **Phân quyền trong Controller:** Sử dụng `[Authorize]` và đọc UserId từ `User.FindFirst(ClaimTypes.NameIdentifier)?.Value`.

---

## 3. Các Thực thể & Service liên quan trực tiếp đến AI Chatbox
| Nghiệp vụ | Entity hiện có | Service hiện có | Cách Chatbox tận dụng |
| :--- | :--- | :--- | :--- |
| **Sách / Tìm kiếm** | `Book`, `BookAuthor`, `BookCategory`, `Category`, `Author` | `IBookService` / `BookService` | Tái sử dụng để tìm kiếm theo từ khóa, danh mục, khoảng giá. |
| **Tồn kho & Giá** | `Book.SalePrice`, `Book.DiscountPrice`, `Inventory.Quantity` | `IBookService` | Đảm bảo AI lấy giá và tồn kho thật từ DB. |
| **Giỏ hàng** | `Cart`, `CartItem` | `ICartService` / `CartService` | Dùng cho tool `GetCart` và hành động xác nhận thêm giỏ. |
| **Đơn hàng** | `Order`, `OrderItem` | `IOrderService` / `OrderService` | Dùng cho tool `GetOrderStatus` tra cứu theo mã đơn của đúng user. |
| **Người dùng** | `User` (Id kiểu `int`) | `IUserService`, `IAuthService` | Liên kết hội thoại `UserId`. |

---

## 4. Tinh chỉnh kiến trúc khi sử dụng Google Gemini API Free Tier (Dành cho Báo cáo)

Theo thống nhất với người dùng nhằm phục vụ **mục tiêu làm đồ án & báo cáo môn học**, kiến trúc được tinh gọn tối đa:
1. **Lược bỏ tính toán chi phí (`EstimatedCost`):** Không dùng bảng giá token, không tính chi phí USD/VND.
2. **Lược bỏ kiểm soát ngân sách phức tạp:** Bỏ quota tiền nong và cảnh báo tài chính trong Admin.
3. **Triển khai thẳng Gemini API (Model `gemini-1.5-flash`):**
   - Dùng gói Free Tier của Google AI Studio (15 RPM, 1.500 req/ngày - hoàn toàn miễn phí).
   - Tích hợp trực tiếp qua HTTP/REST hoặc Google GenAI SDK.
   - Hỗ trợ Tool Calling (Function Calling) chuẩn của Gemini.
4. **Bảng dữ liệu mới cần thêm:**
   - `ChatConversations` (Id: Guid, UserId: int, Title: string, CreatedAt, UpdatedAt, Status).
   - `ChatMessages` (Id: Guid, ConversationId: Guid, Role: string, Content: string, MetadataJson: string, CreatedAt).
   - `PolicyDocuments` (Id: int, Title: string, Content: string, Status: string) để chatbot trả lời chính sách đổi trả, ship hàng.

---

## 5. Kết luận Giai đoạn 0

- Hệ thống hiện tại sạch sẽ, cấu trúc rõ ràng, build Backend và Frontend đều hoạt động bình thường.
- Không phát hiện xung đột kiến trúc nghiêm trọng.
- Sẵn sàng chuyển sang **Giai đoạn 1 (Khởi tạo Database Migration & Backend Chat Service tích hợp Gemini)**.
