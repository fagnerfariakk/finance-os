# FinanceOS Documentation

**Document:** 10_BACKEND.md
**Version:** 2.0

# Backend Standards

## Stack
- NestJS
- Prisma
- PostgreSQL
- Redis

## Layers
Controller
Application Service
Domain
Repository

## Rules
- Controllers orchestrate requests only.
- Services contain business rules.
- Repositories encapsulate persistence.
- Dependency Injection everywhere.

## Cross-cutting
- Validation Pipes
- Global Exception Filters
- Structured Logging
- Health Checks
