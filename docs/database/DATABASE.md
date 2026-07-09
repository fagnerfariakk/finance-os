# FinanceOS Documentation

**Document:** 03_DATABASE.md
**Version:** 2.0

# Database

## Engine
PostgreSQL

## ORM
Prisma

## Main Entities
Users
Accounts
CreditCards
Transactions
Categories
Budgets
Goals
Assets
Investments
Dividends
ImportHistory
AILogs

## Rules
- Prisma Migrations only.
- Prefer soft delete.
- Use foreign keys.
- Audit financial operations.
- Never physically delete financial history.
