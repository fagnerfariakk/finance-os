# FinanceOS Documentation

**Document:** 04_API.md
**Version:** 2.0

# API Standards

## Style
REST
JSON
/api/v1

## Validation
- DTOs
- Zod / Validation Pipe
- JWT authentication

## Responses
{
  "success": true,
  "data": {},
  "message": "",
  "errors": []
}

## Pagination
page
limit
total

## HTTP
GET
POST
PUT
PATCH
DELETE

Use consistent status codes and centralized exception handling.
