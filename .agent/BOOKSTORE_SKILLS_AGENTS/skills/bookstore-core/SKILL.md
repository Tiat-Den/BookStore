# Skill: BookStore Core

## Purpose
Skill nền tảng cho toàn bộ dự án.

## Project context
BookStore là website bán sách có Customer, Employee và Admin.

## Architecture
Backend theo hướng phân lớp:
- `BookStore.API`
- `BookStore.Application`
- `BookStore.Domain`
- `BookStore.Infrastructure`

Frontend:
- `components/`
- `pages/`
- `layouts/`
- `services/`
- `hooks/`
- `context/`
- `utils/`

## Business flow chính
`PENDING → CONFIRMED → PROCESSING → SHIPPING → DELIVERED`

Có thể chuyển sang:
- `CANCELLED`
- `RETURNED`

Không cho phép chuyển trạng thái tùy tiện; phải kiểm tra transition hợp lệ.

## Quy tắc coding
- Ưu tiên tên rõ nghĩa.
- Hàm ngắn, một trách nhiệm.
- Không đưa business rule phức tạp vào UI component.
- Không lặp code nếu có thể tạo service/helper dùng chung.
- Không hard-code role, status hoặc URL rải rác trong code.
- Dùng constants/enums/configuration phù hợp.

## Workflow
1. Đọc tài liệu.
2. Xác định module bị ảnh hưởng.
3. Kiểm tra dependency.
4. Lập kế hoạch.
5. Implement.
6. Test.
7. Review.
8. Cập nhật docs.

## Handoff
Mỗi agent khi bàn giao phải nêu:
- Đã làm gì.
- File/module đã thay đổi.
- API/schema thay đổi.
- Test đã chạy.
- Việc còn lại.
- Rủi ro hoặc breaking change.
