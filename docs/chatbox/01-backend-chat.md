# Báo cáo Triển khai AI Chatbot (Gemini AI Free Tier)

**Dự án:** Website Thương mại Điện tử Bán sách (BookStore)  
**Thời gian hoàn thành:** 12/10/2026  
**Công nghệ:** ASP.NET Core .NET 8, React + Vite, Google Gemini API Free (gemini-3.5-flash / gemini-3.8-flash)  
**Tác giả:** Antigravity AI Agent

---

## 1. Những việc đã làm

### A. Cơ sở dữ liệu & Entity (Domain & Infrastructure)
1. Thêm entity `ChatConversation`, `ChatMessage`, `PolicyDocument` trong [ChatEntities.cs](file:///d:/PhạmTiếnĐạt/Web-TMDT/Cuối%20Kỳ/Backend/BookStore.Domain/Entities/ChatEntities.cs).
2. Cập nhật `BookStoreDbContext` và cấu hình Fluent API, tạo Migration `AddChatAndPolicyEntities` và áp dụng thành công vào SQL Server database.
3. Seed dữ liệu mẫu các chính sách của nhà sách (Đổi trả, Vận chuyển, Thanh toán) vào bảng `PolicyDocuments` trong `DbInitializer.cs`.

### B. Tích hợp Google Gemini AI & Tools Layer (Backend)
1. Lưu trữ an toàn Gemini API Key vào .NET `user-secrets`.
2. Tạo interface `IAiService` và cài đặt [GeminiAiService.cs](file:///d:/PhạmTiếnĐạt/Web-TMDT/Cuối%20Kỳ/Backend/BookStore.Infrastructure/Services/GeminiAiService.cs):
   - Sử dụng model `gemini-3.5-flash` (kèm danh sách tự động fallback sang `gemini-3.1-flash-lite`, `gemini-3.8-flash`).
   - Cung cấp cơ chế gọi Function Calling (Tool Calling) của Gemini.
3. Tạo [BookSearchService.cs](file:///d:/PhạmTiếnĐạt/Web-TMDT/Cuối%20Kỳ/Backend/BookStore.Infrastructure/Services/BookSearchService.cs) cung cấp 3 công cụ:
   - `SearchBooks`: Tìm kiếm sách theo từ khóa tiếng Việt, danh mục, khoảng giá, trạng thái còn hàng.
   - `GetBookDetail`: Lấy thông tin chi tiết cuốn sách.
   - `GetPolicyAnswer`: Tra cứu chính sách cửa hàng.
4. Xây dựng [ChatService.cs](file:///d:/PhạmTiếnĐạt/Web-TMDT/Cuối%20Kỳ/Backend/BookStore.Infrastructure/Services/ChatService.cs) điều phối logic hội thoại và lưu trữ lịch sử tin nhắn.
5. Tạo [ChatController.cs](file:///d:/PhạmTiếnĐạt/Web-TMDT/Cuối%20Kỳ/Backend/BookStore.Api/Controllers/ChatController.cs) với các endpoint:
   - `POST /api/chat/messages`: Gửi tin nhắn và nhận câu trả lời kèm thẻ sách gợi ý.
   - `GET /api/chat/conversations`: Xem danh sách các cuộc trò chuyện.
   - `GET /api/chat/conversations/{id}`: Xem chi tiết lịch sử tin nhắn.
   - `DELETE /api/chat/conversations/{id}`: Xóa cuộc trò chuyện.

### C. Giao diện người dùng (Frontend React)
1. Tạo [chatService.js](file:///d:/PhạmTiếnĐạt/Web-TMDT/Cuối%20Kỳ/Frontend/src/services/chatService.js) kết nối backend qua Axios client đã có sẵn token JWT.
2. Thiết kế widget nổi [ChatWidget.jsx](file:///d:/PhạmTiếnĐạt/Web-TMDT/Cuối%20Kỳ/Frontend/src/components/ChatWidget.jsx):
   - Nút bong bóng chat ở góc phải màn hình với hiệu ứng gradient và pulse.
   - Giao diện chat hiện đại, hỗ trợ cuộn tự động, trạng thái đang suy nghĩ.
   - **Thẻ sách tương tác (`BookCard`):** Hiển thị ảnh bìa, tên sách, tác giả, giá bán, giá giảm, bấm vào chuyển ngay tới trang chi tiết sách (`/books/:id`).
   - Gợi ý câu hỏi nhanh (Quick suggestion pills).
   - Xem và xóa lịch sử trò chuyện cũ của tài khoản.
3. Tích hợp `ChatWidget` vào layout chính tại [App.jsx](file:///d:/PhạmTiếnĐạt/Web-TMDT/Cuối%20Kỳ/Frontend/src/App.jsx).

---

## 2. Kết quả kiểm thử thực tế

- **Backend API:** `dotnet build` thành công 100% (0 errors, 0 warnings).
- **Frontend App:** `npm run build` thành công 100%.
- **Test Endpoint `/api/chat/messages`:**
  - *Query tìm sách:* "Gợi ý cho tôi vài cuốn sách văn học hay" -> AI đã trả về phản hồi tự nhiên và trích xuất đúng 2 cuốn sách thật từ SQL Server (`Mắt Biếc`, `Tôi Thấy Hoa Vàng Trên Cỏ Xanh` của Nguyễn Nhật Ánh).
  - *Query chính sách:* "Chính sách đổi trả sách của cửa hàng như thế nào?" -> AI đã tra cứu `PolicyDocuments` và trả lời chính xác: đổi trả trong 7 ngày, quy định sách còn nguyên vẹn.
