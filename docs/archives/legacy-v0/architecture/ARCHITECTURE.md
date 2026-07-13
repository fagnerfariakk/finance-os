# FinanceOS Documentation

**Document:** 01_ARCHITECTURE.md
**Version:** 2.0

# Objective
Define the official software architecture of FinanceOS.

## Principles
- Modular Monorepo
- Clean Architecture
- SOLID
- Low coupling / High cohesion
- Domain-first design

## Monorepo
apps/
- web (Next.js)
- api (NestJS)

packages/
- ui
- config
- types
- eslint-config
- tsconfig

docs/

## Backend Layers
Controller -> Application(Service) -> Domain -> Repository -> Prisma -> PostgreSQL

## Rules
- Controllers never access Prisma.
- Business rules stay in services/domain.
- Shared code belongs in packages.
- All changes must preserve modularity.
