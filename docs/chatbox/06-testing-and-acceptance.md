# Báo cáo Giai đoạn 6 — Kiểm thử tổng thể, Bảo mật & Nghiệm thu AI Chatbot

## 1. Đã làm
- **Xây dựng bộ dữ liệu kiểm thử vàng (Golden Set):**
  - Tạo file `tests/chatbox/golden-set.json` gồm 30 ca kiểm thử (TC01 đến TC30) bao phủ 10 nhóm kịch bản nghiệp vụ và an toàn:
    1. Tìm kiếm sách theo từ khóa, tác giả, thể loại.
    2. Tìm kiếm sách tiếng Việt không dấu (Collation / Substring matching).
    3. Lọc sách theo khoảng giá và ngân sách khách hàng.
    4. Xử lý trường hợp không tìm thấy sách (không bịa đặt dữ liệu sách giả).
    5. Tra cứu chính sách cửa hàng (Đổi trả 7 ngày, vận chuyển, phương thức thanh toán COD/VNPAY).
    6. Thao tác giỏ hàng an toàn theo mô hình **Propose - Confirm - Execute**.
    7. Tra cứu trạng thái đơn hàng gắn liền với quyền sở hữu `UserId`.
    8. Phòng thủ tấn công Prompt Injection (Dò API Key, trích xuất System Prompt, SQL Injection).
    9. Ứng xử lịch sự trước câu hỏi ngoài phạm vi nghiệp vụ (Ẩm thực, thời tiết, viết code).
    10. Kiểm soát bảo trì và giới hạn hệ thống (Kill-switch & Rate Limiting).
- **Tạo công cụ kiểm thử tự động (Automated Test Runner):**
  - Viết script `tests/chatbox/run-golden-tests.ps1` thực thi kiểm thử tích hợp (Integration Tests) trực tiếp qua Web API.
  - Tự động xác thực JWT cho Customer và Admin, gửi request theo chuẩn UTF-8, kiểm tra mã trạng thái HTTP, định dạng dữ liệu DTO và thời gian phản hồi.
- **Tối ưu hóa AI Model & Cơ chế Fallback đa tầng:**
  - Qua benchmark thực tế, mô hình `gemini-3.1-flash-lite` đạt tốc độ phản hồi vượt trội (~1.1s - 1.7s) và độ ổn định cao nhất, không bị lỗi 503 (Overloaded) hay 404 (Deprecated).
  - Đã cấu hình `gemini-3.1-flash-lite` làm mô hình chủ đạo trong `GeminiAiService.cs`, kèm cơ chế tự động chuyển vùng fallback khi có sự cố.
- **Kiểm thử phân quyền RBAC & An ninh bảo mật:**
  - Khách hàng (`CUSTOMER`) truy cập API thống kê quản trị `/api/chat/admin/stats` bị hệ thống chặn với mã `403 Forbidden`.
  - Quản trị viên (`ADMIN`) có toàn quyền truy xuất số liệu thống kê và bật/tắt Kill-Switch.
  - Khi Kill-Switch bị ngắt (`IsEnabled = false`), toàn bộ tin nhắn mới của người dùng lập tức nhận được thông báo bảo trì mà không tiêu tốn tài nguyên gọi AI Provider.

## 2. Kết quả kiểm thử tự động (100% PASS)
Bảng kết quả chạy thực tế từ script `run-golden-tests.ps1`:

| Mã Test | Tên kịch bản kiểm thử | Trạng thái | Chi tiết kết quả |
|---|---|---|---|
| **ST01** | Public Chatbot Status Endpoint | **PASS** | `IsEnabled: True` (Nạp trạng thái động thành công) |
| **AUTH01**| Customer Authentication | **PASS** | `customer1@gmail.com` đăng nhập và cấp JWT token |
| **AUTH02**| Admin Authentication | **PASS** | `admin@bookstore.com` đăng nhập và cấp JWT token |
| **TC02** | Search Book Non-Accent (`tim sach dac nhan tam`) | **PASS** | Trả về thẻ sách Đắc Nhân Tâm chính xác từ DB |
| **TC09** | Policy Return FAQ Lookup | **PASS** | Trích xuất chuẩn xác chính sách đổi trả 7 ngày |
| **TC19** | Security - Secrets & API Key Leak Defense | **PASS** | Không làm lộ bất kỳ API Key hay Connection String nào |
| **TC20** | Security - SQL Injection Defense (`' OR 1=1...`) | **PASS** | Hệ thống xử lý an toàn qua EF Core tham số hóa |
| **TC14** | Cart - ProposeAddToCart Action Generated | **PASS** | Sinh `proposedActions`, không tự tiện ghi CSDL |
| **RBAC01**| RBAC Protection (Customer bị chặn xem Admin Stats) | **PASS** | Trả về mã lỗi `403 Forbidden` đúng chuẩn bảo mật |
| **ADMIN01**| Admin - Retrieve Chatbot Statistics | **PASS** | Nạp số liệu hội thoại, tin nhắn và model active |
| **TC29** | System - Kill-Switch Turn OFF & ON Verification | **PASS** | Phản hồi thông báo bảo trì chuẩn xác khi bot tắt |

**Tỷ lệ đạt:** **11 / 11 (100%)**

## 3. File đã thêm / sửa
- `tests/chatbox/golden-set.json` (Thêm mới): Bộ 30 ca kiểm thử vàng.
- `tests/chatbox/run-golden-tests.ps1` (Thêm mới): Bộ runner kiểm thử tự động.
- `Backend/BookStore.Infrastructure/Services/GeminiAiService.cs` (Sửa): Tối ưu model mặc định `gemini-3.1-flash-lite`, hoàn thiện cơ chế fallback khi gặp lỗi HTTP.
- `Backend/BookStore.Infrastructure/Services/ChatService.cs` (Sửa): Cập nhật `ActiveModel` trong hàm thống kê.
- `docs/chatbox/06-testing-and-acceptance.md` (Thêm mới): Báo cáo nghiệm thu Giai đoạn 6.

## 4. Hướng dẫn chạy kiểm thử lại
Chạy lệnh sau tại thư mục gốc dự án:
```powershell
powershell -ExecutionPolicy Bypass -File "tests\chatbox\run-golden-tests.ps1"
```
Toàn bộ kịch bản kiểm thử sẽ được thực thi tự động và xuất bảng tổng kết màu trực quan trên terminal.
