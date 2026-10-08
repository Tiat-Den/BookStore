# Audit Project BookStore

Ngày audit: 08/10/2026  
Phạm vi: rà soát nhanh mã nguồn và cấu hình trong thư mục `Backend`, `Frontend`, tài liệu chạy dự án và cấu hình liên quan.

## 1. Tổng quan dự án

Dự án là hệ thống thương mại điện tử bán sách gồm:

- **Backend**: ASP.NET Core Web API .NET 8, Clean Architecture.
  - Solution: `Backend/BookStore.slnx`
  - API: `Backend/BookStore.Api`
  - Application: `Backend/BookStore.Application`
  - Domain: `Backend/BookStore.Domain`
  - Infrastructure: `Backend/BookStore.Infrastructure`
  - Database: SQL Server, Entity Framework Core, tự động migrate/seed khi khởi động.
- **Frontend**: React + Vite.
  - Thư mục: `Frontend`
  - Dependencies chính: React, React Router, Axios, Lucide React.
- **Tài liệu vận hành**: `HUONG_DAN_CHAY_DU_AN.md`, script `run-dev.ps1`, `run-dev.bat`.

## 2. Điểm tốt đã ghi nhận

- Backend đã tách theo hướng Clean Architecture: API/Application/Domain/Infrastructure.
- Có JWT Bearer Authentication và role-based authorization theo vai trò `ADMIN`, `EMPLOYEE`, `CUSTOMER`.
- Mật khẩu người dùng được hash bằng BCrypt trong luồng đăng nhập/đăng ký.
- Có middleware xử lý exception riêng: `BookStore.Api.Middlewares.ExceptionMiddleware`.
- Có Swagger/OpenAPI và hỗ trợ nhập JWT token trong Swagger UI.
- Có migration/seed tự động, thuận tiện cho demo và môi trường phát triển.
- Frontend có interceptor Axios tự động gắn JWT token và xử lý 401.
- Có tài liệu hướng dẫn chạy dự án và tài khoản mẫu.

## 3. Phát hiện ưu tiên cao

### A-01. JWT secret đang hard-code trong repository

**Mức độ:** Cao  
**Vị trí:**

- `Backend/BookStore.Api/appsettings.json`
- `Backend/BookStore.Api/Program.cs`
- `Backend/BookStore.Application/Services/JwtTokenGenerator.cs`

**Chi tiết:**

`appsettings.json` chứa trực tiếp khóa JWT:

```json
"Secret": "BookStore_Secure_Jwt_Key_For_Authentication_2026_DotNet8_CleanArch_Key"
```

Ngoài ra code còn có fallback secret mặc định:

```csharp
"BookStore_Default_Secret_Key_For_Development_Only_123456"
```

Nếu source code bị public hoặc chia sẻ, attacker có thể ký JWT giả nếu biết issuer/audience.

**Khuyến nghị:**

- Không commit secret thật vào repository.
- Dùng environment variable, User Secrets khi dev, hoặc Secret Manager/Vault khi production.
- Xóa fallback secret mặc định trong môi trường production; nếu thiếu secret thì fail fast.
- Tạo `appsettings.example.json` không chứa secret thật.

---

### A-02. CORS đang cho phép mọi origin/method/header
    
**Mức độ:** Cao  
**Vị trí:** `Backend/BookStore.Api/Program.cs`

```csharp
policy.AllowAnyOrigin()
      .AllowAnyMethod()
      .AllowAnyHeader();
```

**Rủi ro:**

API có thể bị gọi từ bất kỳ website nào. Với token lưu ở browser, điều này làm tăng rủi ro abuse API và khó kiểm soát môi trường production.

**Khuyến nghị:**

- Dev: chỉ cho `http://localhost:5173`.
- Production: chỉ allow domain frontend chính thức.
- Đặt origin qua cấu hình, ví dụ `Cors:AllowedOrigins`.

---

### A-03. JWT token lưu trong localStorage

**Mức độ:** Cao/Trung bình tùy môi trường  
**Vị trí:**

- `Frontend/src/services/apiClient.js`
- `Frontend/src/context/AuthContext.jsx`

**Chi tiết:**

Token được lưu bằng:

```js
localStorage.setItem('bookstore_token', res.data.token)
```

**Rủi ro:**

Nếu có lỗi XSS, token trong `localStorage` có thể bị đánh cắp.

**Khuyến nghị:**

- Ưu tiên dùng HttpOnly Secure SameSite cookie cho access/refresh token nếu triển khai production.
- Nếu vẫn dùng localStorage cho đồ án/demo, cần đảm bảo không render HTML không tin cậy và áp dụng CSP.
- Rút ngắn thời hạn access token và bổ sung refresh token rotation.

---

### A-04. Swagger bật không điều kiện

**Mức độ:** Trung bình/Cao khi production  
**Vị trí:** `Backend/BookStore.Api/Program.cs`

```csharp
app.UseSwagger();
app.UseSwaggerUI(...);
```

**Rủi ro:**

Swagger public trong production làm lộ toàn bộ API surface, schema request/response và hỗ trợ thử token.

**Khuyến nghị:**

- Chỉ bật Swagger trong Development/Staging hoặc bảo vệ bằng auth/IP allowlist.

```csharp
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
```

---

### A-05. Tài khoản mẫu và mật khẩu mặc định được tài liệu hóa

**Mức độ:** Cao nếu deploy production với seed mặc định  
**Vị trí:** `HUONG_DAN_CHAY_DU_AN.md`, `DbInitializer`

Tài liệu công khai tài khoản mẫu:

- `admin@bookstore.com` / `Admin@123456`
- `customer1@gmail.com` / `Password@123`

**Khuyến nghị:**

- Chỉ seed tài khoản mẫu trong Development.
- Với production, bắt buộc đổi mật khẩu admin lần đầu hoặc tạo admin qua biến môi trường an toàn.
- Không đưa mật khẩu thật vào tài liệu production.

## 4. Phát hiện ưu tiên trung bình

### B-01. HTTPS metadata cho JWT bị tắt

**Mức độ:** Trung bình  
**Vị trí:** `Backend/BookStore.Api/Program.cs`

```csharp
options.RequireHttpsMetadata = false;
```

**Khuyến nghị:**

- Chỉ để `false` trong Development.
- Production nên yêu cầu HTTPS và cấu hình reverse proxy đúng chuẩn.

---

### B-02. Thời hạn JWT khá dài

**Mức độ:** Trung bình  
**Vị trí:** `Backend/BookStore.Api/appsettings.json`

```json
"ExpiryMinutes": 1440
```

Token có hạn 24 giờ. Nếu bị lộ, attacker có thể dùng trong thời gian dài.

**Khuyến nghị:**

- Access token: 15-60 phút.
- Refresh token: lưu an toàn, có rotation/revocation.
- Thêm cơ chế revoke token khi đổi mật khẩu/khóa tài khoản.

---

### B-03. Connection string hard-code trong `appsettings.json`

**Mức độ:** Trung bình  
**Vị trí:** `Backend/BookStore.Api/appsettings.json`

```json
"DefaultConnection": "Server=.\\SQLEXPRESS;Database=BookStoreDb;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true"
```

**Khuyến nghị:**

- Dùng biến môi trường cho production.
- Không dùng `TrustServerCertificate=True` trong production nếu có thể cấu hình certificate đúng.
- Tách file cấu hình mẫu và cấu hình thật.

---

### B-04. Tự động migrate và seed database khi startup

**Mức độ:** Trung bình  
**Vị trí:** `Backend/BookStore.Api/Program.cs`

```csharp
await db.Database.MigrateAsync();
await DbInitializer.SeedAsync(db);
```

**Rủi ro:**

- Production startup có thể thay đổi schema ngoài ý muốn.
- Seed mặc định có thể tạo dữ liệu/tài khoản không mong muốn.
- Nếu migration lỗi, ứng dụng hiện chỉ log lỗi rồi tiếp tục chạy.

**Khuyến nghị:**

- Chỉ auto migrate/seed trong Development.
- Production nên chạy migration trong CI/CD pipeline có kiểm soát.
- Nếu migration là bắt buộc, startup nên fail khi migration thất bại.

---

### B-05. Logging EF Core command ở mức Information

**Mức độ:** Trung bình  
**Vị trí:** `Backend/BookStore.Api/appsettings.json`

```json
"Microsoft.EntityFrameworkCore.Database.Command": "Information"
```

**Rủi ro:**

Log có thể chứa SQL statement, tham số truy vấn hoặc thông tin nhạy cảm nếu cấu hình thêm sensitive data logging.

**Khuyến nghị:**

- Production nên để `Warning` hoặc cao hơn.
- Không bật sensitive data logging trong production.

---

### B-06. API base URL của frontend hard-code localhost

**Mức độ:** Trung bình  
**Vị trí:** `Frontend/src/services/apiClient.js`

```js
baseURL: 'http://localhost:5193/api'
```

**Khuyến nghị:**

- Dùng biến môi trường Vite:

```js
baseURL: import.meta.env.VITE_API_BASE_URL
```

- Tạo `.env.example`:

```env
VITE_API_BASE_URL=http://localhost:5193/api
```

## 5. Phát hiện ưu tiên thấp / chất lượng dự án

### C-01. `audit.md` trước audit đang rỗng

File `audit.md` tồn tại nhưng có dung lượng 0 byte trước khi ghi báo cáo này. Không phải lỗi kỹ thuật, nhưng nên duy trì file audit/changelog rõ ràng.

---

### C-02. Tài liệu tiếng Việt bị lỗi encoding trong output terminal

Khi đọc `HUONG_DAN_CHAY_DU_AN.md` qua PowerShell, nội dung tiếng Việt hiển thị mojibake. Có thể do terminal/code page, không nhất thiết do file.

**Khuyến nghị:**

- Đảm bảo file Markdown lưu UTF-8.
- Khi chạy PowerShell có thể dùng:

```powershell
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
```

---

### C-03. Frontend vẫn dùng README template của Vite

**Vị trí:** `Frontend/README.md`

README frontend hiện chủ yếu là template React + Vite.

**Khuyến nghị:**

- Cập nhật README frontend với biến môi trường, script, cấu trúc thư mục, flow auth, account demo.

---

### C-04. Chưa thấy cấu hình lint/format/test đầy đủ ở root

Frontend có script `lint` dùng `oxlint`, nhưng chưa thấy cấu hình test rõ ràng. Backend có thể build/test bằng dotnet, nhưng chưa thấy project test trong phạm vi liệt kê nhanh.

**Khuyến nghị:**

- Thêm test project cho backend: unit test service, integration test controller.
- Thêm test frontend nếu cần: Vitest/React Testing Library.
- Thêm CI chạy `dotnet build`, `dotnet test`, `npm run lint`, `npm run build`.

## 6. Khuyến nghị hardening nhanh

### Backend

1. Chuyển JWT secret, connection string, CORS origins sang environment variables.
2. Chỉ bật Swagger, auto migration, seed tài khoản mẫu trong Development.
3. Giới hạn CORS theo domain cụ thể.
4. Giảm thời hạn access token, thiết kế refresh token an toàn.
5. Bật HTTPS nghiêm ngặt ở production.
6. Kiểm tra toàn bộ controller admin có `[Authorize(Roles = "ADMIN")]` hoặc policy tương ứng.
7. Thêm rate limiting cho login/register để chống brute force.
8. Thêm lockout/tạm khóa sau nhiều lần login sai nếu chưa có.
9. Log security event: login fail, lock account, tạo/sửa/xóa dữ liệu admin.
10. Không log dữ liệu nhạy cảm.

### Frontend

1. Không hard-code API URL; dùng `VITE_API_BASE_URL`.
2. Cân nhắc chuyển token từ localStorage sang HttpOnly cookie nếu triển khai thật.
3. Thêm Content Security Policy khi deploy.
4. Validate dữ liệu form phía client nhưng không thay thế validate ở backend.
5. Đảm bảo không dùng `dangerouslySetInnerHTML` với dữ liệu người dùng.

### DevOps / Repository

1. Thêm `.env.example` và hướng dẫn cấu hình.
2. Thêm `.gitignore` kiểm soát `bin`, `obj`, `node_modules`, file env thật.
3. Thêm CI build/test/lint.
4. Không commit secrets, backup database, log nhạy cảm.
5. Tách cấu hình Development/Staging/Production.

## 7. Checklist kiểm tra trước production

- [ ] Không còn secret thật trong repository.
- [ ] JWT secret đủ mạnh và lấy từ secret store.
- [ ] CORS chỉ allow domain frontend chính thức.
- [ ] Swagger tắt hoặc được bảo vệ.
- [ ] Tài khoản seed demo không tồn tại trong production.
- [ ] HTTPS bắt buộc end-to-end hoặc qua reverse proxy chuẩn.
- [ ] Access token hết hạn ngắn; có refresh/revoke strategy.
- [ ] Login có rate limit/lockout.
- [ ] Log không chứa password/token/PII nhạy cảm.
- [ ] Database migration production chạy qua pipeline có kiểm soát.
- [ ] Frontend dùng biến môi trường cho API URL.
- [ ] Có backup/restore database và monitoring cơ bản.

## 8. Kết luận

Dự án có nền tảng kiến trúc tốt cho đồ án: backend .NET 8 theo Clean Architecture, frontend React/Vite, JWT auth, BCrypt, Swagger và seed dữ liệu demo. Tuy nhiên, để an toàn hơn khi đưa ra môi trường thật, cần ưu tiên xử lý các vấn đề cấu hình bảo mật: hard-code JWT secret, CORS quá rộng, Swagger bật công khai, token lưu localStorage, tài khoản/mật khẩu demo và auto migration/seed khi startup.

Các vấn đề này không nhất thiết làm dự án demo bị lỗi, nhưng là rủi ro đáng kể nếu triển khai production.
