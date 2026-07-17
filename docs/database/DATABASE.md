# FinanceOS — Database

**Documento:** docs/database/DATABASE.md
**Versão:** 1.0
**Status:** Aprovado
**Epic:** EPIC-003
**Task:** TASK-003.5.02
**Última Atualização:** 2026-07-16

---

# 1. Objetivo

Este documento é a **fonte oficial única da modelagem de dados do FinanceOS**: engine, ORM, modelos existentes no schema Prisma e regras de persistência.

Não redefine arquitetura (ver ARCHITECTURE_BASELINE), contratos de comunicação (ver API) ou convenções de código (ver CODING_STANDARDS) — apenas os referencia.

Este documento reflete exclusivamente o estado real do arquivo `packages/database/prisma/schema.prisma` na data de sua última atualização.

---

# 2. Engine e ORM

- **Engine:** PostgreSQL 17.
- **ORM:** Prisma.

Versões exatas e demais detalhes de stack são responsabilidade de **ARCHITECTURE_BASELINE** — não repetidos aqui.

---

# 3. Modelos Implementados

Modelos que **já existem** em `packages/database/prisma/schema.prisma`, com migration aplicada (`20260709121205_init`). Todos pertencem ao domínio **Identity**.

## Tenant
Entidade raiz de multi-tenancy. Campos: `id`, `name`, `slug` (único), `isActive`, `createdAt`, `updatedAt`. Relaciona-se com `User`, `Role` e `AuditLog`.

## User
Usuário autenticável, escopado por tenant. Campos: `id`, `tenantId`, `email`, `passwordHash`, `isActive`, `createdAt`, `updatedAt`, `deletedAt` (soft delete). Único por (`tenantId`, `email`). Relaciona-se com `Tenant`, `UserRole` e `AuditLog`.

## Role
Papel de RBAC, escopado por tenant. Campos: `id`, `tenantId`, `name`, `description`, `isActive`, `createdAt`, `updatedAt`. Único por (`tenantId`, `name`). Relaciona-se com `Tenant`, `UserRole` e `RolePermission`.

## Permission
Permissão granular, compartilhada entre tenants (não escopada por `tenantId`). Campos: `id`, `resource`, `action`, `description`, `createdAt`, `updatedAt`. Único por (`resource`, `action`). Relaciona-se com `RolePermission`.

## UserRole
Tabela de junção entre `User` e `Role`. Campos: `userId`, `roleId`, `createdAt`. Chave primária composta (`userId`, `roleId`).

## RolePermission
Tabela de junção entre `Role` e `Permission`. Campos: `roleId`, `permissionId`, `createdAt`. Chave primária composta (`roleId`, `permissionId`).

## AuditLog
Registro de auditoria, escopado por tenant. Campos: `id`, `tenantId`, `userId` (opcional), `resource`, `resourceId`, `action`, `payload` (JSON), `ipAddress`, `userAgent`, `createdAt`. Índices em (`tenantId`, `resource`, `action`), (`tenantId`, `userId`) e (`createdAt`).

---

# 4. Modelos Planejados

Modelos que **ainda não existem** no schema. Listados aqui apenas para indicar direção futura já prevista em PROJECT_MASTER_PLAN e ROADMAP — **não modelados, sem estrutura de campos definida, sem migration**. Nenhum destes deve ser tratado como implementado até que apareça na Seção 3 deste documento.

- Account
- Transaction
- Category
- Budget
- Goal
- Investment
- Dividend
- Open Finance (entidades de integração bancária)
- Demais modelos financeiros previstos no roadmap (ex.: cartões de crédito, histórico de importação, logs de classificação por IA)

---

# 5. Regras

- Prisma Migrations only.
- Prefer soft delete.
- Use foreign keys.
- Audit financial operations.
- Never physically delete financial history.

---

# 6. Referências

Este documento não repete conteúdo já registrado em:

- **ARCHITECTURE_BASELINE** — stack, decisões arquiteturais, incluindo o registro do domínio Identity/RBAC/Multi-tenancy como já implementado (Seções 6, 9 e 10).
- **ROADMAP** — sequenciamento de EPICs, incluindo EPIC-005 (Core Financeiro) e EPIC-010 (Open Finance), responsáveis pelos modelos planejados da Seção 4.
- **CODING_STANDARDS** — convenções de nomenclatura e organização de models Prisma (Seção 6).

Em caso de divergência entre este documento e o schema real, prevalece o princípio definido em DOCUMENT_HIERARCHY Seção 7: a IA deve interromper a execução e reportar o conflito — nunca decidir unilateralmente.

Fim do documento.
