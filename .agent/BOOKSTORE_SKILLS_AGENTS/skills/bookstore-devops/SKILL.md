# Skill: BookStore DevOps

## Environment
Tách:
- Development
- Test/Staging
- Production

Không dùng secret production trong development.

## Configuration
Configuration phải đi qua environment/configuration provider phù hợp.

## Build checks
Backend:
- restore
- build
- test

Frontend:
- install
- lint nếu có
- build
- test

## Deployment checklist
1. Database backup/migration plan.
2. Environment variables.
3. Backend build.
4. Frontend build.
5. API health check.
6. Database connectivity.
7. Authentication check.
8. Checkout smoke test.
9. Logging/monitoring.
10. Rollback plan.

## Logging
Production log phải đủ để điều tra lỗi nhưng không chứa credential/token/password.

## CI/CD
Pipeline nên có:
- build
- unit test
- integration test nếu có
- lint/static checks
- artifact creation
- deployment approval cho production
