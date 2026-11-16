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
| **Quản trị viên (ADMIN)** | `admin@bookstore.com` | `Admin@123` | Toàn quyền hệ thống: Dashboard doanh thu, Quản lý sách, Duyệt trạng thái đơn hàng, Quản lý Voucher |
| **Nhân viên (EMPLOYEE)** | `employee@bookstore.com` | `Employee@123456` | Quản lý nghiệp vụ: Xem & duyệt trạng thái đơn hàng (`SHIPPING`, `DELIVERED`), quản lý danh mục & sách, xem báo cáo |
| **Khách hàng (CUSTOMER)** | `customer1@gmail.com` | `Password@123` | Mua hàng: Tìm kiếm & lọc sách, Giỏ hàng, Áp dụng Voucher `BOOK20`, Thanh toán VNPay / COD, Đánh giá nhận xét (BR-29) |
