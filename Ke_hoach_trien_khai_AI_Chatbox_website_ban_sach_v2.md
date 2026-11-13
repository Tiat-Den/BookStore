# Kế hoạch triển khai AI Chatbox — Website bán sách

**Phiên bản:** 2.0 (bản cải tiến)
**Phạm vi:** Lập kế hoạch triển khai, chưa bao gồm mã nguồn hoàn chỉnh.

### Điểm khác biệt so với v1.0

| Nội dung | Thay đổi |
|---|---|
| Thiết kế AI | Bổ sung mục riêng: tool calling, danh sách tool, giới hạn vòng lặp, output có cấu trúc |
| Tìm sách tiếng Việt | Bổ sung giải pháp: không dấu, Full-Text Search, lọc theo ngữ nghĩa |
| FAQ/chính sách | Bổ sung nơi lưu, cách truy xuất, quy trình duyệt |
| Khách vãng lai | Quyết định rõ guest chat và chuyển sang đăng nhập |
| Xác nhận hành động | Mô tả luồng "đề xuất → xác nhận → thực thi", idempotency, audit log |
| Chi phí và ngữ cảnh | `AiUsageLog` bắt buộc, chiến lược cắt lịch sử, quota |
| Tiến độ | Tách **MVP chỉ đọc** phát hành trước; giỏ hàng/đơn hàng/Admin làm sau |
| Kiểm thử | Làm liên tục từ giai đoạn 2; có golden set; tiêu chí nghiệm thu định lượng |
| Quyền riêng tư | Bổ sung thông báo, chính sách lưu/xóa, đối chiếu quy định dữ liệu cá nhân |
| Quyết định mở | Thêm danh sách quyết định cần chốt trước khi code |

---

## 1. Thông tin dự án

| Hạng mục | Quyết định |
|---|---|
| Frontend | React + Vite |
| Backend | ASP.NET Core Web API — .NET 8, C# |
| Database | SQL Server |
| Nhà cung cấp AI | Chưa quyết định; **chốt cuối Giai đoạn 0**, kèm 1 provider dự phòng |
| Phạm vi | Chat AI, tư vấn/tìm sách, giỏ hàng, đơn hàng, lịch sử chat, quản trị Admin |

### Nguyên tắc thiết kế

- Backend là nguồn dữ liệu có thẩm quyền về sách, giá, tồn kho, giỏ hàng và đơn hàng.
- AI không tự bịa dữ liệu nghiệp vụ và không tự thực thi SQL hoặc lệnh hệ thống.
- Mọi thao tác nghiệp vụ phải được backend xác thực, kiểm tra quyền và kiểm tra dữ liệu.
- AI chỉ **đề xuất** hành động làm thay đổi dữ liệu; người dùng xác nhận và backend thực thi.
- Ưu tiên tái sử dụng entity, service, API và database hiện có; không tạo trùng chức năng.
- API key và connection string lưu bằng cơ chế quản lý secrets, không đưa vào frontend.
- Ưu tiên thao tác **chỉ đọc** trước, thao tác ghi sau.

## 2. Mục tiêu và chỉ số đo được

| # | Mục tiêu | Chỉ số mục tiêu ban đầu (điều chỉnh sau khảo sát) |
|---|---|---|
| 1 | Khách trò chuyện với AI bằng tiếng Việt trên website | Trả lời đúng ngôn ngữ ≥ 98% trên golden set |
| 2 | Tư vấn/tìm sách dựa trên dữ liệu thật trong SQL Server | 100% giá/tồn kho khớp DB; ≥ 85% câu hỏi golden set cho kết quả phù hợp |
| 3 | Hiển thị thẻ sách: tên, tác giả, giá, ảnh, tình trạng bán/tồn kho | Dữ liệu thẻ lấy từ DTO backend, không từ văn bản AI |
| 4 | Xem giỏ hàng và thêm sách qua nghiệp vụ backend | 0 thao tác ghi khi chưa có xác nhận người dùng |
| 5 | Tra cứu trạng thái đơn của người dùng đã xác thực | 0 trường hợp truy cập chéo tài khoản trong kiểm thử |
| 6 | Lưu lịch sử chat; người dùng chỉ truy cập hội thoại của mình | 0 trường hợp truy cập chéo tài khoản trong kiểm thử |
| 7 | Admin theo dõi sử dụng, lỗi, phản hồi, chi phí | Dashboard có số liệu từ `AiUsageLog` |
| 8 | Kiểm thử, giới hạn sử dụng, giám sát, hướng dẫn phát hành | p95 thời gian phản hồi đạt ngưỡng đã thống nhất; tỷ lệ lỗi < 2% |

## 3. Phạm vi chức năng

### 3.1. MVP (phát hành đầu tiên — chỉ đọc)

- Chatbox nổi trên website: trạng thái đang gửi/đang trả lời, thông báo lỗi, thử lại.
- Hội thoại nhiều lượt, tạo hội thoại mới, xem và xóa lịch sử.
- Tìm sách theo từ khóa, tác giả, danh mục, khoảng giá (hỗ trợ không dấu).
- Gợi ý sách theo nhu cầu, thể loại, ngân sách hoặc chủ đề.
- Trả lời FAQ/chính sách từ nội dung cửa hàng đã duyệt.
- Rate limit, xác thực, quản lý secrets, `AiUsageLog` cơ bản.

### 3.2. Giai đoạn mở rộng (sau MVP)

- Xem giỏ hàng và thêm sách qua luồng xác nhận.
- Tra cứu đơn hàng theo tài khoản đã xác thực.
- Dashboard Admin: số lượt chat, lỗi, thời gian phản hồi, feedback, chi phí ước tính; bật/tắt chatbot; cấu hình giới hạn.
- Chuyển giao cho nhân viên thật (email/hotline/biểu mẫu liên hệ).

### 3.3. Ngoài phạm vi mặc định

- AI tự thanh toán, hoàn tiền, hủy đơn hoặc đổi địa chỉ giao hàng mà không có quy trình xác nhận riêng.
- AI tự viết hoặc thực thi SQL, C#, JavaScript hay lệnh hệ thống.
- Huấn luyện mô hình nền tảng riêng từ đầu.
- Chat giọng nói, đa kênh hoặc tính năng nâng cao khác nếu chưa được phê duyệt.

## 4. Kiến trúc định hướng

| Thành phần | Trách nhiệm |
|---|---|
| React + Vite | Giao diện chat, lịch sử, trạng thái lỗi/loading, thẻ sách, nút xác nhận hành động |
| ASP.NET Core Web API | Xác thực, phân quyền, kiểm tra dữ liệu, điều phối yêu cầu |
| Chat/Application Services | Điều phối hội thoại, lưu tin nhắn, áp dụng chính sách, quản lý ngữ cảnh |
| AI Provider Adapter (`IAiService`) | Cô lập nhà cung cấp AI để có thể thay provider |
| Tool Layer | Các tool nghiệp vụ có schema, kiểm tra quyền và giới hạn |
| Book Service | Tìm sách và trả dữ liệu thực tế |
| Policy/FAQ Service | Lưu và truy xuất nội dung chính sách đã duyệt |
| Cart Service | Xem/cập nhật giỏ qua nghiệp vụ hiện có |
| Order Service | Tra cứu đơn theo quyền sở hữu |
| SQL Server + EF Core | Lưu dữ liệu chat và dùng dữ liệu cửa hàng hiện có |
| Admin/Monitoring | Theo dõi lỗi, mức sử dụng, thời gian phản hồi, chi phí |

**Nguyên tắc:** AI đề xuất hoặc tạo nội dung; backend mới quyết định dữ liệu và thực thi thao tác.

## 5. Thiết kế AI

### 5.1. Cơ chế tool calling

1. Người dùng gửi tin nhắn → backend xác thực, lấy `UserId` từ claim, kiểm tra giới hạn.
2. Backend gửi cho AI: system prompt, lịch sử đã cắt gọn, danh sách tool (schema).
3. AI trả về câu trả lời hoặc yêu cầu gọi tool.
4. Backend **kiểm tra tham số và quyền**, thực thi tool, trả kết quả cho AI.
5. AI diễn đạt kết quả; backend gắn dữ liệu có cấu trúc (thẻ sách) vào phản hồi.
6. Backend lưu tin nhắn và ghi `AiUsageLog`.

**Giới hạn bắt buộc:** tối đa N vòng gọi tool mỗi lượt (đề xuất 3–5), timeout theo từng bước, từ chối tool không có trong danh sách.

### 5.2. Danh sách tool đề xuất

| Tool | Loại | Quyền | Ghi chú |
|---|---|---|---|
| `SearchBooks` | Đọc | Mọi người (kể cả guest) | Tham số: từ khóa, tác giả, danh mục, giá min/max, giới hạn kết quả |
| `GetBookDetail` | Đọc | Mọi người | Theo ID sách |
| `GetPolicyAnswer` | Đọc | Mọi người | Truy xuất nội dung chính sách/FAQ đã duyệt |
| `GetCart` | Đọc | Người dùng đã đăng nhập | Chỉ giỏ của chính họ |
| `GetOrderStatus` | Đọc | Người dùng đã đăng nhập | Kiểm tra ownership theo `UserId` từ claim |
| `ProposeAddToCart` | Đề xuất | Người dùng đã đăng nhập | **Không ghi**; trả về đề xuất để UI hiển thị nút xác nhận |

Thao tác ghi thực sự (thêm giỏ) do API nghiệp vụ thực hiện khi người dùng bấm xác nhận, **không** do AI gọi trực tiếp.

### 5.3. Output có cấu trúc

- Phản hồi gồm: `text` (văn bản AI), `books[]` (DTO từ backend), `proposedActions[]` (hành động chờ xác nhận), `suggestions[]` (gợi ý câu hỏi tiếp theo).
- Giá, tồn kho, trạng thái đơn **chỉ** lấy từ DTO backend; nếu văn bản AI mâu thuẫn với DTO thì ưu tiên DTO.
- Frontend không render HTML tùy ý từ AI; chỉ hiển thị văn bản/markdown đã lọc.

### 5.4. Streaming

- Quyết định ở Giai đoạn 1: dùng SSE để hiển thị phản hồi dần, hay trả một lần.
- Khuyến nghị: SSE cho văn bản; dữ liệu thẻ sách gửi ở sự kiện cuối. Nếu chọn trả một lần thì phải có chỉ báo "đang trả lời" và timeout rõ ràng.

### 5.5. Quản lý ngữ cảnh và chi phí

- Chỉ gửi N tin gần nhất (đề xuất 10–20) kèm tóm tắt ngắn cho phần cũ nếu cần.
- Giới hạn token vào/ra mỗi lượt, độ dài tin nhắn người dùng, số lượt/phút theo người dùng và IP.
- Đặt quota ngân sách theo ngày/tháng; cảnh báo khi đạt ngưỡng; tự tắt hoặc giảm chức năng khi vượt.

### 5.6. Hành vi ngoài phạm vi

- Câu hỏi không liên quan sách/cửa hàng: từ chối lịch sự và hướng về chủ đề của cửa hàng.
- Khi không chắc hoặc không tìm thấy dữ liệu: nói rõ, không đoán; đề nghị chuyển cho nhân viên.
- Phát hiện thông tin nhạy cảm trong tin nhắn (số thẻ, mật khẩu): nhắc người dùng không chia sẻ và không lưu/không gửi cho provider nếu có thể che.

## 6. Tìm sách tiếng Việt

| Vấn đề | Giải pháp đề xuất |
|---|---|
| Người dùng gõ không dấu | Dùng collation không phân biệt dấu hoặc cột chuẩn hóa không dấu để tìm kiếm |
| `LIKE '%...%'` chậm, kém chính xác | Cân nhắc **SQL Server Full-Text Search** cho tên sách, tác giả, mô tả |
| Câu hỏi theo nhu cầu ("sách tặng bạn mới đi làm, dưới 200k") | AI trích xuất bộ lọc (thể loại, giá, chủ đề) → backend lọc và xếp hạng |
| Tìm theo ý nghĩa nâng cao | Đánh giá embedding/vector search ở giai đoạn sau MVP nếu golden set cho thấy cần |
| Sách hết hàng/ngừng bán | Vẫn hiển thị nhưng ghi rõ tình trạng; không gợi ý như còn hàng |

## 7. FAQ và chính sách

- Lưu nội dung trong bảng riêng (ví dụ `PolicyDocuments`: tiêu đề, nội dung, trạng thái duyệt, ngày hiệu lực) hoặc tái sử dụng bảng nội dung hiện có nếu có.
- Chỉ nội dung có trạng thái **đã duyệt** mới được AI sử dụng.
- Truy xuất: bắt đầu bằng tìm kiếm từ khóa/Full-Text; nâng cấp lên RAG nếu cần.
- Chủ cửa hàng chịu trách nhiệm duyệt và cập nhật; mỗi lần cập nhật được ghi lại.
- Khi câu hỏi không có trong nội dung đã duyệt, AI nói không có thông tin và gợi ý liên hệ cửa hàng.

## 8. Khách vãng lai và người dùng đã đăng nhập

| Tính năng | Guest | Người dùng đăng nhập |
|---|---|---|
| Chat tìm/tư vấn sách, FAQ | Có (giới hạn tần suất chặt hơn) | Có |
| Lưu lịch sử chat | Tùy chọn: theo session, thời hạn ngắn | Có, theo `UserId` |
| Xem giỏ hàng, thêm giỏ | Không (nhắc đăng nhập) | Có, qua luồng xác nhận |
| Tra cứu đơn hàng | Không | Có, chỉ đơn của mình |

**Cần chốt:** có hỗ trợ guest chat hay không. Nếu có, dùng session ID ngẫu nhiên, rate limit theo IP và thời hạn lưu ngắn.

## 9. Luồng xác nhận hành động (thêm giỏ hàng)

1. Người dùng: "Thêm cuốn này vào giỏ".
2. AI gọi `ProposeAddToCart` → backend kiểm tra sách tồn tại, còn hàng, số lượng hợp lệ, trả về đề xuất.
3. UI hiển thị thẻ: tên sách, giá hiện tại, số lượng, nút **Xác nhận** / **Hủy**.
4. Người dùng bấm Xác nhận → frontend gọi `POST /api/chat/cart/items` kèm `idempotencyKey`.
5. Backend kiểm tra lại **giá, tồn kho, quyền** tại thời điểm thực thi, rồi gọi `CartService` hiện có.
6. Chỉ khi backend trả thành công, chatbot mới thông báo "đã thêm"; ghi audit log (ai, khi nào, làm gì).

Áp dụng tương tự cho mọi thao tác ghi trong tương lai.

## 10. Kế hoạch theo giai đoạn

Thời lượng là ước tính ban đầu, cần điều chỉnh sau khi khảo sát source code thực tế.

### Giai đoạn 0 — Khảo sát và chuẩn bị (2 ngày)

**Công việc**
- Kiểm tra cấu trúc React, API, xác thực/JWT, `DbContext`, schema SQL Server.
- Xác định service/API hiện có cho sách, giỏ hàng, đơn hàng, tài khoản, vai trò.
- Ghi nhận chính sách lưu hội thoại, yêu cầu bảo mật, tiêu chí nghiệm thu.
- Đánh giá AI provider: chất lượng tiếng Việt, chi phí, giới hạn, hỗ trợ tool calling/streaming, quyền riêng tư, vùng lưu trữ, khả năng thay thế.
- Chốt các quyết định ở mục 17.

**Sản phẩm bàn giao**
- Báo cáo kiến trúc hiện trạng.
- Danh sách thành phần tái sử dụng và phần cần bổ sung.
- **Quyết định chọn provider** + provider dự phòng.
- Bản nháp golden set (≥ 30 câu).

**Tiêu chí nghiệm thu**
- Xác định được luồng xác thực và các nghiệp vụ hiện có.
- Không đề xuất tạo trùng bảng hoặc chức năng đã tồn tại.
- Provider đã được chốt bằng văn bản.

### Giai đoạn 1 — Thiết kế chi tiết (2–3 ngày)

**Công việc**
- Thiết kế luồng chat, tool calling, tìm sách, xác nhận hành động.
- Thiết kế DTO, API contract, mô hình hội thoại/tin nhắn, định dạng streaming.
- Thiết kế phân quyền khách hàng/Admin/guest, rate limit, xử lý lỗi, log.
- Định nghĩa `IAiService` và schema các tool.
- Thiết kế chiến lược ngữ cảnh, quota chi phí, chính sách lưu/xóa dữ liệu.

**Sản phẩm bàn giao**
- Sơ đồ kiến trúc và sơ đồ tuần tự của luồng tool calling.
- API contract.
- Mô hình dữ liệu/migration dự kiến.
- Ma trận quyền; danh sách tool và schema.

**Tiêu chí nghiệm thu**
- Endpoint có request/response và mã lỗi rõ ràng.
- Thao tác nhạy cảm có bước xác minh quyền và xác nhận.

### Giai đoạn 2 — Nền tảng chat (3–4 ngày)

**Công việc**
- Entity và cấu hình EF Core cho hội thoại, tin nhắn, `AiUsageLog`.
- `ChatService`, `ChatController`, API gửi/xem/xóa hội thoại.
- Tích hợp adapter AI; xử lý timeout, lỗi provider, retry có giới hạn, giới hạn nội dung và lịch sử.
- Rate limit (middleware `RateLimiter` của .NET 8), health check, logging an toàn.
- **Bắt đầu kiểm thử bảo mật liên tục**: phân quyền, prompt injection cơ bản.

**Sản phẩm bàn giao**
- API chat cơ bản; migration bảng chat.
- Cấu hình provider qua secrets.
- Bộ kiểm thử API và kiểm thử phân quyền.

**Tiêu chí nghiệm thu**
- Gửi câu hỏi và nhận phản hồi.
- Hội thoại thuộc đúng tài khoản.
- Không trả secrets hoặc stack trace cho frontend.
- Mỗi lượt gọi AI đều có bản ghi `AiUsageLog` (token, độ trễ, lỗi).

### Giai đoạn 3 — React Chatbox (2–3 ngày)

**Công việc**
- Widget chat responsive; loading, lỗi, nút thử lại; hiển thị streaming nếu đã chọn.
- Hiển thị lịch sử, tạo hội thoại mới, xóa hội thoại.
- Kết nối API bằng cơ chế xác thực hiện có; xử lý hết phiên và mất mạng.
- Không render HTML tùy ý do AI trả về.

**Sản phẩm bàn giao**
- Component chatbox, CSS responsive, tích hợp layout website.

**Tiêu chí nghiệm thu**
- Dùng được trên desktop và mobile.
- Hiển thị lỗi rõ ràng.
- Không lộ token hoặc khóa AI trong bundle frontend.

### Giai đoạn 4 — Tư vấn và tìm sách (4–6 ngày)

**Công việc**
- `BookSearchService`: không dấu, Full-Text Search, lọc theo giá/danh mục/tác giả.
- Tool `SearchBooks`, `GetBookDetail`; DTO kết quả có cấu trúc.
- Thẻ sách trong React, liên kết đến trang chi tiết.
- `PolicyService` và nội dung FAQ/chính sách đã duyệt.
- Hoàn thiện golden set (≥ 50–100 câu) và chạy đánh giá.
- Tinh chỉnh system prompt theo kết quả đánh giá.

**Sản phẩm bàn giao**
- `BookSearchService`, `PolicyService`, DTO kết quả sách, thẻ sách.
- Golden set và báo cáo đánh giá.

**Tiêu chí nghiệm thu**
- Kết quả khớp database; giá và tồn kho không do AI tự bịa.
- Đạt chỉ tiêu chất lượng trên golden set (mục 2).
- Khi không tìm thấy sách, chatbot thông báo rõ.

### Giai đoạn 5 — Kiểm thử và phát hành MVP (2–3 ngày)

**Công việc**
- Kiểm thử unit, integration, UI, phân quyền, lỗi provider, prompt injection, tải và chi phí.
- Triển khai staging → UAT → production (có cờ bật/tắt chatbot).

**Sản phẩm bàn giao**
- Báo cáo kiểm thử, checklist release/rollback, hướng dẫn vận hành.

**Tiêu chí nghiệm thu**
- Không còn lỗi nghiêm trọng; đạt tiêu chí bảo mật đã thống nhất.
- Có rollback và giám sát sau phát hành.

> **Mốc MVP:** hoàn thành sau Giai đoạn 5 (khoảng 15–21 ngày làm việc).

### Giai đoạn 6 — Giỏ hàng và đơn hàng (3–5 ngày)

**Công việc**
- Tích hợp `CartService`, `OrderService` hiện có.
- Tool `GetCart`, `GetOrderStatus`, `ProposeAddToCart`; API xác nhận thêm giỏ có idempotency.
- Kiểm tra tồn kho, giá, số lượng, quyền sở hữu ở backend.
- Audit log cho thao tác ghi.

**Sản phẩm bàn giao**
- `CartAssistantService`, `OrderAssistantService`, UI xác nhận hành động.

**Tiêu chí nghiệm thu**
- Không thể sửa giỏ hoặc truy cập đơn của tài khoản khác.
- Giá và tồn kho được kiểm tra tại thời điểm thực thi.
- Chatbot không thông báo thành công khi backend chưa xác nhận.
- Bấm xác nhận nhiều lần không tạo trùng.

### Giai đoạn 7 — Quản trị và giám sát (2–3 ngày)

**Công việc**
- Endpoint Admin bảo vệ bằng role/policy hiện có.
- Thống kê số lượt chat, lỗi, độ trễ, feedback, chi phí từ `AiUsageLog` và `ChatFeedback`.
- Cấu hình bật/tắt chatbot, giới hạn sử dụng, ngưỡng cảnh báo chi phí.
- Log có kiểm soát dữ liệu cá nhân; correlation ID cho mỗi yêu cầu.

**Sản phẩm bàn giao**
- Admin API/dashboard, quy tắc giám sát, cấu hình an toàn.

**Tiêu chí nghiệm thu**
- Khách hàng thường không truy cập được API Admin.
- Số liệu có nguồn dữ liệu rõ ràng.
- Không ghi log secrets; Admin không sửa được system prompt tùy ý.

### Giai đoạn 8 — Kiểm thử cuối và phát hành đầy đủ (2–4 ngày)

**Công việc**
- Hồi quy toàn bộ; kiểm thử bảo mật chéo người dùng, prompt injection nâng cao, tải và chi phí.
- Staging → UAT → production; theo dõi sau phát hành.

**Tiêu chí nghiệm thu**
- Đạt toàn bộ tiêu chí tại mục 15.

## 11. API dự kiến

Các đường dẫn là đề xuất ban đầu, phải điều chỉnh theo quy ước API hiện có.

| Method | Endpoint | Mục đích | Công khai cho frontend? |
|---|---|---|---|
| `POST` | `/api/chat/messages` | Gửi tin nhắn (có thể stream SSE) | Có |
| `GET` | `/api/chat/conversations` | Danh sách hội thoại của người dùng | Có |
| `GET` | `/api/chat/conversations/{id}/messages` | Lịch sử hội thoại | Có |
| `DELETE` | `/api/chat/conversations/{id}` | Xóa hội thoại (theo chính sách xóa) | Có |
| `POST` | `/api/chat/cart/items` | Thêm sách vào giỏ **sau khi người dùng xác nhận** (có `idempotencyKey`) | Có |
| `POST` | `/api/chat/feedback` | Đánh giá câu trả lời | Có |
| — | Tìm sách, tra đơn, chính sách | Tool nội bộ do ChatService gọi | **Không** |
| `GET` | `/api/admin/chat/usage` | Admin xem thống kê sử dụng | Admin |
| `GET/PUT` | `/api/admin/chat/settings` | Cấu hình được phép (bật/tắt, giới hạn); không trả khóa bí mật, không sửa system prompt tùy ý | Admin |

## 12. Dữ liệu và thay đổi database

- Tái sử dụng bảng Books/Categories/Cart/Orders/Users hiện tại.
- `ChatConversations`: `Id`, `UserId` (nullable cho guest) hoặc `SessionId`, `Title`, `CreatedAt`, `UpdatedAt`, `Status`.
- `ChatMessages`: `Id`, `ConversationId`, `Role`, `Content`, `CreatedAt`, metadata tối thiểu (ví dụ ID sách đã hiển thị).
- `AiUsageLog` (**bắt buộc**): `Id`, `ConversationId`, `UserId`, `Model`, `InputTokens`, `OutputTokens`, `LatencyMs`, `EstimatedCost`, `ErrorCode`, `CreatedAt`.
- `ChatFeedback`: `Id`, `MessageId`, `Rating`, `Comment`, `CreatedAt`.
- `PolicyDocuments` (nếu chưa có nơi lưu phù hợp): tiêu đề, nội dung, trạng thái duyệt, ngày hiệu lực.
- `ChatActionAudit`: ai, hành động, tham số, kết quả, thời điểm.
- Index cho `UserId + UpdatedAt`, `ConversationId + CreatedAt`, và `AiUsageLog(CreatedAt)`.
- Chính sách lưu/xóa: thời hạn lưu, xóa mềm hay xóa thật, xử lý khi người dùng yêu cầu xóa dữ liệu.
- Migration được rà soát và backup trước khi áp dụng.

## 13. Bảo mật và quyền riêng tư

- Lấy `UserId` từ claim đã xác thực; không tin `UserId` gửi trong body/query.
- Kiểm tra quyền sở hữu ở mọi thao tác hội thoại, giỏ hàng và đơn hàng.
- Authorization theo role/policy cho Admin.
- Secrets lưu trong User Secrets, secret manager hoặc biến môi trường an toàn; không đưa vào `VITE_*` hay mã frontend.
- Rate limit theo người dùng/IP; giới hạn kích thước request, lịch sử gửi cho mô hình, ngân sách.
- Chỉ gửi dữ liệu cần thiết đến AI provider; che hoặc loại bỏ thông tin cá nhân không cần thiết.
- AI không thực thi SQL hoặc lệnh; chỉ có tool nghiệp vụ có schema, quyền và giới hạn rõ ràng.
- Backend xác nhận thành công trước khi chatbot thông báo hành động đã hoàn tất.
- **Prompt injection**: coi nội dung sách, đánh giá người dùng, kết quả tool là dữ liệu không đáng tin, không phải chỉ thị; tách rõ khỏi system prompt.
- Không ghi API key, access token, dữ liệu thanh toán, thông tin cá nhân không cần thiết vào log.
- **Quyền riêng tư**: thông báo rõ cho người dùng rằng hội thoại được lưu và xử lý bởi bên thứ ba; cập nhật chính sách quyền riêng tư; đối chiếu với quy định bảo vệ dữ liệu cá nhân hiện hành tại Việt Nam (ví dụ Nghị định 13/2023/NĐ-CP) và rà soát chính sách lưu giữ dữ liệu của provider.
- Có cơ chế bật/tắt nhanh chatbot (kill switch).

## 14. Kế hoạch kiểm thử

Kiểm thử chạy liên tục từ Giai đoạn 2; mỗi giai đoạn bổ sung ca kiểm thử của phần mình.

| Nhóm | Trường hợp kiểm thử | Kết quả mong đợi |
|---|---|---|
| Chat | Tin nhắn hợp lệ, rỗng, quá dài, gửi liên tục | Phản hồi đúng; request sai bị từ chối |
| AI provider | Timeout, lỗi 429/5xx, nội dung rỗng, tool call sai tham số | Thông báo thân thiện, log an toàn, không treo vòng lặp |
| Tìm sách | Có/không kết quả, không dấu, lọc giá, sách hết hàng | Dữ liệu khớp SQL Server |
| FAQ/chính sách | Câu hỏi có/không có trong nội dung đã duyệt | Trả lời đúng nguồn; không bịa khi thiếu |
| Phân quyền | Đọc hội thoại/đơn người khác, gọi Admin API bằng customer, guest gọi chức năng cần đăng nhập | Bị từ chối; không rò rỉ dữ liệu |
| Giỏ hàng | Sách không tồn tại, số lượng sai, tồn kho thay đổi, bấm xác nhận nhiều lần | Backend từ chối thao tác không hợp lệ; không tạo trùng |
| Bảo mật AI | Prompt injection trực tiếp và gián tiếp (qua mô tả sách/đánh giá), yêu cầu secrets/SQL | Không tiết lộ secrets, không thực thi lệnh trái phép |
| Chi phí/tải | Nhiều request, lịch sử dài, vượt quota | Bị giới hạn; theo dõi được mức sử dụng |
| Frontend | Màn hình nhỏ, mất mạng, hết phiên, streaming bị ngắt | Responsive và báo lỗi rõ ràng |
| Chất lượng AI | Golden set 50–100 câu (tìm sách, tư vấn, FAQ, ngoài phạm vi, không dấu) | Đạt chỉ tiêu ở mục 2; chạy lại mỗi khi đổi prompt/model |

## 15. Tiêu chí nghiệm thu tổng thể

**MVP**
- Chatbox hoạt động trong React + Vite, gọi API qua HTTPS.
- ASP.NET Core API lưu/đọc hội thoại đúng tài khoản trên SQL Server.
- Provider AI cấu hình qua secrets; thay adapter không sửa nghiệp vụ chính.
- Tư vấn sách dùng dữ liệu thật; giá, tồn kho không do mô hình suy diễn (100% khớp DB trong kiểm thử).
- Đạt chỉ tiêu golden set; p95 thời gian phản hồi và tỷ lệ lỗi đạt ngưỡng đã thống nhất.
- Có `AiUsageLog`, rate limit, quota chi phí, kill switch.

**Bản đầy đủ (bổ sung)**
- Thao tác giỏ hàng chỉ thực hiện sau xác nhận và được backend kiểm tra; có idempotency và audit log.
- Tra cứu đơn giới hạn theo quyền sở hữu; 0 trường hợp truy cập chéo trong kiểm thử.
- Admin API có authorization, không lộ khóa hoặc dữ liệu nhạy cảm.
- Có kiểm thử chức năng, quyền, lỗi provider, prompt injection, giới hạn request và hướng dẫn triển khai/rollback.

## 16. Rủi ro và phương án giảm thiểu

| Rủi ro | Ảnh hưởng | Giảm thiểu |
|---|---|---|
| Chưa chọn AI provider | Trễ tích hợp, thay đổi API | Chốt cuối Giai đoạn 0; dùng adapter `IAiService`; có provider dự phòng |
| Schema dự án khác giả định | Migration/code không tương thích | Khảo sát source; tái sử dụng entity/service |
| AI trả thông tin sai | Mất tin cậy, ảnh hưởng mua hàng | Dùng dữ liệu backend; ưu tiên DTO hơn văn bản AI; golden set |
| Tìm kiếm tiếng Việt kém | Gợi ý sai/không tìm thấy | Không dấu, Full-Text Search, trích xuất bộ lọc; đo trên golden set |
| Lộ dữ liệu người dùng | Rủi ro quyền riêng tư | Kiểm tra ownership, authorization, tối thiểu hóa dữ liệu, kiểm thử chéo |
| Prompt injection qua nội dung sách/đánh giá | AI bị điều khiển | Coi dữ liệu là không đáng tin; tool có quyền hẹp; AI không tự ghi dữ liệu |
| Chi phí AI tăng | Vượt ngân sách | Rate limit, giới hạn token/lịch sử, quota, cảnh báo, kill switch |
| Provider gián đoạn | Chat không hoạt động | Timeout, retry có giới hạn, fallback/provider dự phòng, giám sát |
| Thao tác giỏ/đơn sai | Ảnh hưởng nghiệp vụ | Luồng xác nhận, idempotency, kiểm tra server, audit log |
| Ước tính thấp cho phần AI | Trễ tiến độ | Tách MVP; dành thời gian tinh chỉnh prompt/đánh giá; hiệu chỉnh sau Giai đoạn 0 |

## 17. Quyết định cần chốt trước khi code

| # | Quyết định | Chốt ở |
|---|---|---|
| 1 | AI provider chính và dự phòng | Giai đoạn 0 |
| 2 | Có hỗ trợ guest chat không; cách lưu và thời hạn | Giai đoạn 0 |
| 3 | Streaming (SSE) hay trả một lần | Giai đoạn 1 |
| 4 | Cách tìm sách: Full-Text Search; có cần tìm theo ngữ nghĩa ở MVP không | Giai đoạn 1 |
| 5 | Nơi lưu và quy trình duyệt FAQ/chính sách | Giai đoạn 1 |
| 6 | Chính sách lưu/xóa hội thoại và thông báo quyền riêng tư | Giai đoạn 1 |
| 7 | Ngân sách AI hàng tháng và quota theo người dùng | Giai đoạn 1 |
| 8 | Chuẩn chuyển giao cho nhân viên thật | Giai đoạn 1 |
| 9 | Chỉ tiêu định lượng (p95, tỷ lệ lỗi, độ chính xác golden set) | Giai đoạn 1 |

## 18. Lịch trình và vai trò

**Ước tính sơ bộ**

| Phạm vi | Thời gian (ngày làm việc, 1 người phát triển có kinh nghiệm) |
|---|---|
| MVP (Giai đoạn 0–5) | khoảng 15–21 |
| Bản đầy đủ (Giai đoạn 0–8) | khoảng 22–33 |

Đây không phải cam kết tiến độ; cần hiệu chỉnh sau Giai đoạn 0, đặc biệt phần tinh chỉnh prompt, tìm kiếm tiếng Việt và đánh giá chất lượng AI.

| Vai trò | Trách nhiệm |
|---|---|
| Backend developer | API, EF Core, SQL Server, AI adapter, tool layer, phân quyền, nghiệp vụ |
| Frontend developer | Chat widget, thẻ sách, nút xác nhận, lịch sử chat, tích hợp đăng nhập |
| Tester/QA | Kiểm thử chức năng, quyền, lỗi provider, prompt injection, responsive, golden set |
| Project owner/Admin | Chốt nghiệp vụ, chính sách, provider, ngân sách, nội dung FAQ, tiêu chí nghiệm thu |

## 19. Thứ tự ưu tiên

1. Khảo sát source và luồng xác thực hiện tại; chốt các quyết định ở mục 17.
2. Chọn provider, thống nhất chi phí, chính sách dữ liệu và kiến trúc adapter.
3. Hoàn thành chat cơ bản, lưu lịch sử, `AiUsageLog` và rate limit.
4. Tư vấn/tìm sách bằng dữ liệu thật; FAQ đã duyệt; đánh giá bằng golden set.
5. **Phát hành MVP chỉ đọc.**
6. Tích hợp giỏ hàng (luồng xác nhận) và tra cứu đơn hàng an toàn.
7. Hoàn thiện dashboard Admin, usage, logging, kiểm soát chi phí.
8. Kiểm thử bảo mật cuối, staging, UAT và phát hành đầy đủ.

## 20. Điều kiện bắt đầu triển khai

- Có source code backend/frontend và quyền chạy dự án.
- Có schema SQL Server hoặc migrations hiện tại.
- Xác định cơ chế đăng nhập, JWT claims và role/policy Admin.
- Có môi trường phát triển/staging và quy trình quản lý secrets.
- Có người chịu trách nhiệm chọn provider sau khi đánh giá chất lượng, giá và quyền riêng tư.
- Có người xác nhận quy tắc nghiệp vụ của giỏ hàng, đơn hàng và nội dung chính sách cửa hàng.
- Có ngân sách AI và chỉ tiêu chất lượng đã thống nhất.

## 21. Ghi chú

Đây là tài liệu kế hoạch nền để tổ chức công việc, không phải mã nguồn triển khai. Tên bảng, endpoint và thời lượng có thể điều chỉnh sau khi khảo sát source code thực tế. Mọi migration và thao tác dữ liệu phải được rà soát và backup trước khi áp dụng.
