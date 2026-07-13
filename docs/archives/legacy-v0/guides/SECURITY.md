# FinanceOS Documentation

**Document:** 06_SECURITY.md
**Version:** 2.0

# Objective
Define mandatory security practices.

## Principles
- Secure by Default
- Least Privilege
- Defense in Depth

## Authentication
- JWT
- Refresh Tokens
- Password hashing with bcrypt/argon2
- MFA ready

## Authorization
- RBAC
- Guards in NestJS
- Server-side authorization only

## Secrets
- Environment variables only
- Never commit secrets

## OWASP
Follow OWASP Top 10.

## Logging
Never log passwords, tokens or sensitive financial data.

## Security Reviews
New dependencies must be evaluated before adoption.
