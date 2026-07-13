# FinanceOS Documentation

**Document:** 05_BUSINESS_RULES.md
**Version:** 2.0

# Core Business Rules

## Transfers
Never count as income or expense.

## Installments
Maintain parent relationship, total amount, current installment and remaining balance.

## Reversals
Never delete transactions. Create reversing entries.

## AI
Only suggests actions. Never changes financial data automatically.

## Duplicate Detection
Compare:
- account
- date
- amount
- description

## Imports
Keep complete import history and audit trail.

Financial data integrity has priority over convenience.
