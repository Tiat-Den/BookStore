# 📚 BOOKSTORE - HỆ THỐNG THƯƠNG MẠI ĐIỆN TỬ BÁN SÁCH
> **Đồ Án Cuối Kỳ Môn Web Thương Mại Điện Tử**  
> Kiến trúc: **Clean Architecture (.NET 8 Web API) + React (Vite) + SQL Server**

---

## 🚀 HƯỚNG DẪN KHỞI CHẠY DỰ ÁN

### 1. Yêu Cầu Môi Trường
- **.NET SDK 8.0** trở lên.
- **Node.js** (v18+ hoặc v20+).
- **Microsoft SQL Server** (Mặc định kết nối instance `.\SQLEXPRESS`).

---

### 2. Khởi Chạy Backend (ASP.NET Core Web API)
Mở một cửa sổ Terminal (PowerShell hoặc Command Prompt) tại thư mục gốc:

```powershell
cd Backend
dotnet run --project BookStore.Api --urls "http://localhost:5193"
```

- **Swagger API Documentation:** [http://localhost:5193/swagger](http://localhost:5193/swagger)
- Khi khởi chạy lần đầu, hệ thống tự động:
  - Áp dụng Migration `BookStoreDb`.
  - Khởi tạo tài khoản Quản trị viên (`ADMIN`), Khách hàng mẫu, Danh mục, Tác giả, Nhà xuất bản, Sách mẫu kèm tồn kho và Mã voucher (`BOOK20`, `FREESHIP`).

---

### 3. Khởi Chạy Frontend (React Vite)
Mở một cửa sổ Terminal thứ hai:

```powershell
cd Frontend
npm install    # (Nếu chưa cài node_modules)
npm run dev
```

- Truy cập Website: [http://localhost:5173](http://localhost:5173)

---

## 🔑 TÀI KHOẢN MẪU DÙNG THỬ

| Vai trò | Email | Mật khẩu | Chức năng nổi bật |
| :--- | :--- | :--- | :--- |
| **Quản trị viên (ADMIN)** | `admin@bookstore.com` | `Admin@123456` | Toàn quyền hệ thống: Dashboard doanh thu, Quản lý sách, Duyệt trạng thái đơn hàng, Quản lý Voucher |
| **Nhân viên (EMPLOYEE)** | `employee@bookstore.com` | `Employee@123456` | Quản lý nghiệp vụ: Xem & duyệt trạng thái đơn hàng (`SHIPPING`, `DELIVERED`), quản lý danh mục & sách, xem báo cáo |
| **Khách hàng (CUSTOMER)** | `customer1@gmail.com` | `Password@123` | Mua hàng: Tìm kiếm & lọc sách, Giỏ hàng, Áp dụng Voucher `BOOK20`, Thanh toán VNPay / COD, Đánh giá nhận xét (BR-29) |

---

## 🛡️ CÁC QUY TẮC NGHIỆP VỤ ĐÃ HIỆN THỰC CHUẨN MỰC
1. **BR-01 đến BR-08 (Xác thực & Phân quyền RBAC):** JWT Bearer, băm mật khẩu BCrypt, kiểm soát Role `ADMIN`, `EMPLOYEE`, `CUSTOMER`.
2. **BR-09 đến BR-14 (Quản lý Sách & Danh mục):** Soft Delete, phân trang PagedResult, lọc giá, tìm kiếm đa tiêu chí.
3. **BR-15 đến BR-18 (Giỏ hàng & Đơn hàng):** Snapshot tên và đơn giá tại thời điểm đặt, trừ kho và xuất kho trong Database Transaction. Máy trạng thái: `PENDING` -> `CONFIRMED` -> `PROCESSING` -> `SHIPPING` -> `DELIVERED`. Hủy đơn hoàn kho tức thời.
4. **BR-19 đến BR-20 (Thanh toán):** Tích hợp cổng thanh toán mô phỏng VNPay Sandbox và MoMo.
5. **BR-29 (Đánh giá sản phẩm):** Chỉ người mua có đơn hàng đã giao (`DELIVERED`) mới có quyền gửi nhận xét và chấm sao.
6. **BR-35 & BR-36 (Báo cáo kinh doanh):** Doanh thu tính từ các đơn đã thanh toán (`PAID`), không tính đơn hủy; thống kê Top sách bán chạy nhất và biểu đồ trực quan 6 tháng.
