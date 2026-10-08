# BookStore Skills & Agents

Bộ Skill + Agent dành cho dự án website thương mại điện tử bán sách.

## Cấu trúc

```text
BOOKSTORE_SKILLS_AGENTS/
├── AGENTS.md
├── SKILLS.md
├── README.md
├── skills/
│   ├── bookstore-core/SKILL.md
│   ├── bookstore-backend/SKILL.md
│   ├── bookstore-frontend/SKILL.md
│   ├── bookstore-database/SKILL.md
│   ├── bookstore-testing/SKILL.md
│   ├── bookstore-security/SKILL.md
│   └── bookstore-devops/SKILL.md
└── agents/
    ├── bookstore-orchestrator.md
    ├── backend-agent.md
    ├── frontend-agent.md
    ├── database-agent.md
    ├── qa-agent.md
    ├── security-agent.md
    └── devops-agent.md
```

## Cách sử dụng

- Dùng `bookstore-orchestrator` để phân tích task và điều phối.
- Dùng `backend-agent` cho API, C#, EF Core.
- Dùng `frontend-agent` cho React/JSX.
- Dùng `database-agent` cho SQL Server/schema/migration.
- Dùng `qa-agent` cho test và regression.
- Dùng `security-agent` cho auth/RBAC/security review.
- Dùng `devops-agent` cho build, environment và deployment.

Agent không được tự ý vượt phạm vi nếu task liên quan đến agent chuyên môn khác; cần bàn giao rõ đầu vào/đầu ra.
