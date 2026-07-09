# FinanceOS

> ERP Financeiro moderno, modular e orientado a domínio.

---

# Status do Projeto

Release Atual

v0.1 Foundation

Status

🟢 Em desenvolvimento

---

# Objetivo

Construir um ERP Financeiro moderno para pequenas e médias empresas utilizando tecnologias atuais e arquitetura escalável.

---

# Stack Tecnológica

Frontend

- Next.js 16
- React 19
- TypeScript

Backend

- NestJS (EPIC futura)

Banco

- PostgreSQL 17
- Prisma ORM

Infraestrutura

- Docker
- Docker Compose

Monorepo

- PNPM Workspace
- Turborepo

---

# Estrutura

finance-os

apps/

web

api

packages/

database

auth

ui

config

types

utils

docs/

prisma/

docker/

scripts/

---

# Roadmap

## Foundation

- ✅ EPIC-001 Platform Foundation
- ✅ EPIC-002 Prisma Foundation

---

## Core

- ⏳ EPIC-003 Domain Foundation
- ⏳ EPIC-004 Authentication
- ⏳ EPIC-005 API Foundation

---

## Finance

- Plano de Contas
- Centros de Custos
- Contas Bancárias
- Fluxo de Caixa
- Receitas
- Despesas
- Cartões
- Investimentos

---

## Intelligence

- Dashboard
- KPIs
- BI
- Forecast
- IA

---

# Princípios Arquiteturais

- Domain Driven Design
- Clean Architecture
- SOLID
- Repository Pattern
- Modular Monolith (inicialmente)

---

# Regras

Apps apenas orquestram.

Packages concentram lógica reutilizável.

Todo acesso ao banco passa pelo package database.

Nenhuma regra de negócio no frontend.

---

# Fluxo

ChatGPT

↓

Arquitetura

↓

Claude

↓

Implementação

↓

Validação

↓

Review

↓

Merge

---

# Definition of Done

Toda EPIC deverá possuir:

- Build funcionando
- Lint funcionando
- Docker saudável
- Scripts funcionando
- Documentação atualizada
- ADR criada (quando necessário)