# Skill: BookStore Frontend

## Stack
React + JSX + JavaScript.

## Structure
- `components/`: reusable UI
- `pages/`: route-level pages
- `layouts/`: customer/admin/employee layouts
- `services/`: API calls
- `hooks/`: reusable behavior
- `context/`: global state where appropriate
- `utils/`: pure helpers

## Rules
- Dùng JSX, không chuyển sang TSX.
- Component tập trung vào presentation/orchestration.
- Business logic quan trọng phải ở backend.
- API access tập trung trong service layer.
- Không gọi API trực tiếp rải rác trong nhiều component nếu có thể tái sử dụng service.
- Xử lý loading, error và empty state.
- Form phải validate dữ liệu cơ bản trước khi gửi.
- Nhưng frontend validation không thay thế backend validation.

## Auth/RBAC
UI có thể ẩn/hiện chức năng theo role để UX tốt, nhưng backend vẫn phải kiểm tra quyền.

## E-commerce
Cart UI phải hiển thị rõ:
- quantity
- unit price
- subtotal
- discount nếu có
- total

Không coi total từ frontend là giá trị cuối cùng.

## UX
- Responsive.
- Có feedback khi submit.
- Chống double submit.
- Có confirmation cho thao tác nguy hiểm.
- Empty state dễ hiểu.
- Error message thân thiện nhưng không làm lộ thông tin hệ thống.

## Performance
- Lazy load route/page lớn khi phù hợp.
- Tránh render lại không cần thiết.
- Pagination/infinite loading cho danh sách lớn.
- Tối ưu ảnh sách.
