# Hệ Thống AI Chatbot Thông Minh — Website Bán Sách BookStore

Tài liệu tổng hợp quá trình thiết kế, triển khai, kiểm thử và vận hành hệ thống Trợ lý ảo AI Chatbot (sử dụng Google Gemini API) tích hợp vào website thương mại điện tử BookStore (.NET 8 Web API + React Vite + SQL Server).

---

## 1. Mục lục tài liệu theo lộ trình

Các tài liệu chi tiết được lưu trữ tại thư mục `docs/chatbox/`:
1. [Giai đoạn 0 — Khảo sát & Đánh giá Codebase](00-discovery.md)
2. [Giai đoạn 1-3 — Nền tảng Backend, AI Adapter & Widget Chat React](01-backend-chat.md)
3. [Giai đoạn 4 — Tích hợp Giỏ hàng & Tra cứu Đơn hàng (Propose-Confirm-Execute)](04-cart-orders.md)
4. [Giai đoạn 5 — Trang Quản trị, Giám sát & Điều khiển Chatbot (Admin & Kill-Switch)](05-admin.md)
5. [Giai đoạn 6 — Kiểm thử tổng thể, Bảo mật & Nghiệm thu](06-testing-and-acceptance.md)

---

## 2. Kiến trúc & Công nghệ chính

- **Frontend:** React (Vite), Tailwind CSS, Lucide Icons.
  - Widget chat nổi đa năng (`ChatWidget.jsx`), tự động thu gọn/mở rộng, hỗ trợ nạp tin nhắn theo phiên hội thoại.
  - Hiển thị trực quan thẻ sách tương tác (`BookCard`) với hình ảnh, giá, trạng thái kho và liên kết chi tiết.
  - Thẻ hành động giỏ hàng tương tác: Nút "Xác nhận thêm giỏ" và "Hủy" đồng bộ thời gian thực với Navbar qua React Context.
  - Trang quản trị Chatbot (`AdminChatbot.jsx`) với công tắc **Kill-Switch** và bảng thống kê tổng quan.
- **Backend:** ASP.NET Core 8 Web API, Entity Framework Core.
  - Adapter `IAiService` kết nối Google Generative Language REST API (`gemini-3.1-flash-lite`), có cơ chế chuyển vùng dự phòng (Fallback).
  - Tầng công cụ nghiệp vụ nội bộ (Tool Calling): `SearchBooks`, `GetBookDetail`, `GetPolicyAnswer`, `GetCart`, `GetOrderStatus`, `ProposeAddToCart`.
  - Cơ chế bảo mật Single Source of Truth: AI không được phép ghi trực tiếp CSDL. Mọi thao tác thay đổi trạng thái giỏ hàng phải qua luồng xác nhận độc lập kèm khóa chống lặp `idempotencyKey`.
  - Phân quyền theo vai trò (RBAC): Các endpoint quản trị được bảo vệ nghiêm ngặt bằng Role `ADMIN`.
- **Database:** Microsoft SQL Server.
  - Các bảng chat mới: `ChatConversations`, `ChatMessages`, `PolicyDocuments`, `ChatSettings`.

---

## 3. Hướng dẫn chạy thử và Demo báo cáo đồ án

### Bước 1: Khởi động Backend API
Mở terminal tại thư mục gốc của dự án:
```powershell
dotnet run --project Backend/BookStore.Api
```
API sẽ lắng nghe tại: `http://localhost:5193` và tài liệu Swagger tại `http://localhost:5193/swagger`.

### Bước 2: Khởi động Frontend
Mở một terminal khác tại thư mục `Frontend`:
```powershell
cd Frontend
npm run dev
```
Truy cập trình duyệt tại: `http://localhost:5173`.

### Bước 3: Các kịch bản Demo chính khi báo cáo
1. **Tìm kiếm & Gợi ý sách thông minh:**
   - Mở widget chat ở góc dưới bên phải.
   - Nhập: *"tim sach dac nhan tam"* (tiếng Việt không dấu) -> AI trả lời câu tự nhiên và render thẻ sách Đắc Nhân Tâm kèm giá chuẩn từ DB.
   - Nhập: *"Gợi ý cho mình sách về lập trình"* -> AI tìm và trả về cuốn Clean Code.
2. **Hỏi đáp chính sách cửa hàng (FAQ):**
   - Nhập: *"Chính sách đổi trả của shop như thế nào?"* -> AI trích xuất chuẩn xác nội dung đổi trả trong 7 ngày từ bảng `PolicyDocuments`.
3. **Thêm vào giỏ hàng (Mô hình An toàn Propose - Confirm - Execute):**
   - Đăng nhập tài khoản khách hàng (`customer1@gmail.com` / `Password@123`).
   - Nhập vào chat: *"Thêm cuốn Đắc Nhân Tâm vào giỏ hàng giúp tôi"*.
   - AI hiển thị thẻ đề xuất hành động với nút **Xác nhận thêm giỏ** và **Hủy**.
   - Bấm **Xác nhận thêm giỏ** -> Badge giỏ hàng trên thanh Navbar lập tức nhảy số tăng thêm 1 sản phẩm.
4. **Kiểm tra giỏ hàng:**
   - Nhập: *"Giỏ hàng của tôi đang có những gì?"* -> AI hiển thị danh sách sản phẩm và tổng giá trị đơn hàng hiện tại.
5. **Trang Quản trị & Công tắc bảo vệ Kill-Switch:**
   - Đăng nhập tài khoản Admin (`admin@bookstore.com` / `Admin@123`).
   - Vào menu Admin -> Chọn tab **AI Chatbot** (đường dẫn `/admin/chatbot`).
   - Xem bảng thống kê: Tổng số tin nhắn, số cuộc hội thoại, model đang hoạt động.
   - Gạt công tắc chuyển sang **Tắt Chatbot** -> Bấm **Lưu cấu hình**.
   - Mở widget chat: Widget sẽ hiển thị banner thông báo bảo trì kỹ thuật và từ chối xử lý tin nhắn để bảo vệ hệ thống.
6. **Chạy kiểm thử tự động toàn diện:**
   - Chạy lệnh: `powershell -ExecutionPolicy Bypass -File "tests\chatbox\run-golden-tests.ps1"`.
   - Kết quả: **100% PASS (11/11)** bài kiểm thử chức năng, bảo mật và an toàn dữ liệu.
