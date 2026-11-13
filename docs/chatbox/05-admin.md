# Báo cáo Giai đoạn 5 — Quản trị, Giám sát & Điều khiển Chatbot (Admin & Kill-Switch)

## 1. Đã làm
- **Kill-Switch (Công tắc an toàn cấp hệ thống):**
  - Thêm thực thể `ChatSetting` lưu trạng thái `IsEnabled`, `WelcomeMessage`, `SystemNotice`, `UpdatedAt`.
  - Migration EF Core `AddChatSettingEntity` và seed bản ghi cấu hình mặc định trong `DbInitializer.cs`.
  - Cập nhật `ChatService`: Khi `IsEnabled = false`, Chatbot lập tức từ chối xử lý và không gọi AI Provider, trả về câu thông báo bảo trì/tạm dừng hệ thống.
  - Endpoint `GET /api/chat/status` (AllowAnonymous): Cho phép widget chat ở Frontend tự động kiểm tra trạng thái hoạt động của bot để hiển thị banner bảo trì hoặc lời chào tùy chỉnh.
- **API Quản trị (Admin APIs):**
  - `GET /api/chat/admin/settings`: Đọc cấu hình hiện tại (chỉ role `ADMIN`).
  - `PUT /api/chat/admin/settings`: Cập nhật trạng thái bật/tắt bot, lời chào, thông báo hệ thống (chỉ role `ADMIN`).
  - `GET /api/chat/admin/stats`: Thống kê tổng lượt chat, số cuộc hội thoại, số lỗi, và thời gian phản hồi trung bình (chỉ role `ADMIN`).
- **Giao diện Quản trị viên (Frontend Admin UI):**
  - Tạo trang `AdminChatbot.jsx` hiển thị:
    - Thẻ thống kê tổng quan (Tổng số hội thoại, Tổng lượt tin nhắn, Lượt lỗi, Thời gian xử lý trung bình).
    - Khối điều khiển **Kill-Switch**: Bật / Tắt trạng thái chatbot với switch toggle trực quan và cảnh báo màu sắc.
    - Cấu hình thông điệp: Tin nhắn chào mừng (`WelcomeMessage`) và Thông báo hệ thống khi bảo trì (`SystemNotice`).
  - Tích hợp tab **AI Chatbot** vào thanh điều hướng quản trị `ManagementHeader` trong `AdminPages.jsx`.
  - Khai báo route `/admin/chatbot` trong `App.jsx`.
  - Cập nhật `chatService.js` với các hàm API admin và status.
  - Cập nhật `ChatWidget.jsx` để nạp trạng thái động từ API status.

## 2. File đã thêm / sửa
- `Backend/BookStore.Domain/Entities/ChatSetting.cs` (Thêm mới): Entity cấu hình chat.
- `Backend/BookStore.Infrastructure/Data/BookStoreDbContext.cs` (Sửa): Thêm `DbSet<ChatSetting>`.
- `Backend/BookStore.Infrastructure/Migrations/*_AddChatSettingEntity.cs` (Thêm mới): Migration EF Core.
- `Backend/BookStore.Infrastructure/Data/DbInitializer.cs` (Sửa): Seed cấu hình mặc định.
- `Backend/BookStore.Application/Interfaces/IChatService.cs` (Sửa): Khai báo các method admin & status.
- `Backend/BookStore.Application/Services/ChatService.cs` (Sửa): Cài đặt logic kill-switch, stats, status.
- `Backend/BookStore.Api/Controllers/ChatController.cs` (Sửa): Thêm các endpoint admin và status.
- `Frontend/src/services/chatService.js` (Sửa): Bổ sung `getChatStatus`, `getAdminSettings`, `updateAdminSettings`, `getAdminStats`.
- `Frontend/src/pages/admin/AdminChatbot.jsx` (Thêm mới): Giao diện quản trị Chatbot.
- `Frontend/src/pages/admin/AdminPages.jsx` (Sửa): Thêm tab "AI Chatbot" vào navigation header.
- `Frontend/src/App.jsx` (Sửa): Đăng ký route `/admin/chatbot`.
- `Frontend/src/components/ChatWidget.jsx` (Sửa): Đọc trạng thái từ `/api/chat/status`.

## 3. Lệnh đã chạy và kết quả
- `dotnet ef migrations add AddChatSettingEntity`: Hoàn thành.
- `dotnet ef database update`: Áp dụng migration vào SQL Server thành công.
- `dotnet build Backend/BookStore.Api`: Build succeeded (0 Warning, 0 Error).
- `npm run build`: Hoàn thành kiểm tra cú pháp và bundling.

## 4. Cách chạy thử nghiệm
1. Đăng nhập tài khoản Admin (`admin@bookstore.com` / `Admin@123`).
2. Truy cập `/admin/chatbot` hoặc bấm tab **AI Chatbot** trên thanh điều hướng quản trị.
3. Xem bảng điều khiển và số liệu thống kê.
4. Gạt công tắc sang **Tắt Chatbot** -> Bấm **Lưu cấu hình**.
5. Mở widget chat ở góc dưới màn hình: Widget sẽ hiển thị banner thông báo bảo trì và khóa khung gửi tin nhắn.
6. Bật lại công tắc và Lưu -> Widget khôi phục hoạt động bình thường ngay lập tức.
