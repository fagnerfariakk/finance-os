# FinanceOS — Architecture Baseline

**Documento:** docs/architecture/ARCHITECTURE_BASELINE.md
**Versão:** 1.0
**Status:** Aprovado
**Epic:** EPIC-001
**Task:** TASK-001.5.02
**Última Atualização:** 2026-07-12

---

# 1. Objetivo

Este documento é a **fonte oficial única do estado arquitetural aprovado do FinanceOS**, conforme definido em DOCUMENT_HIERARCHY Seção 3: stack oficial, camadas, estrutura do monorepo e decisões arquiteturais já registradas.

Não redefine regras de negócio (ver BUSINESS_RULES, quando existir), contratos de comunicação (ver API), modelagem de dados (ver DATABASE) ou convenções de código (ver CODING_STANDARDS) — apenas os referencia.

Este documento consolida exclusivamente o estado já existente e decidido no repositório na data de sua última atualização. Não introduz nenhuma decisão arquitetural nova — decisões arquiteturais são de responsabilidade de ChatGPT, conforme DOCUMENT_HIERARCHY Seção 7.

---

# 2. Princípios Arquiteturais

Princípios que sustentam as decisões registradas neste documento, com base no que já está aprovado em outros documentos oficiais:

- **BFF sem backend separado** — toda comunicação flui através da própria aplicação Next.js, sem uma aplicação de backend autônoma (ver Seção 5).
- **Modularidade via monorepo** — `apps/` e `packages/` mantidos com responsabilidades isoladas, orquestrados via Turborepo (ver Seção 3).
- **Single Source of Truth documental** — cada assunto possui exatamente um documento oficial responsável; este princípio rege inclusive este documento (ver DOCUMENT_HIERARCHY).
- **Type Safety First** — TypeScript com tipagem explícita como primeira linha de defesa contra erros, conforme já estabelecido em CODING_STANDARDS Seção 2 (não repetido aqui).
- **Integridade e auditabilidade de dados financeiros** — prioridade máxima declarada em PROJECT_MASTER_PLAN Seção 2, refletida operacionalmente nas regras de persistência registradas em DATABASE (soft delete, nunca exclusão física de histórico financeiro, auditoria de operações).

---

# 3. Stack Oficial

| Camada | Tecnologia | Versão |
|---|---|---|
| Runtime | Node.js | `>=22` |
| Gerenciador de pacotes | PNPM | `>=11` |
| Orquestrador de monorepo | Turborepo | `^2` |
| Linguagem | TypeScript | `^5` |
| Framework Web / BFF | Next.js (App Router) | `16` |
| UI | React | `19` |
| ORM | Prisma | `^6` |
| Banco de dados | PostgreSQL | `17` |
| Cache / dados voláteis | Redis | `8` |
| Containers locais | Docker / Docker Compose | serviços `postgres` e `redis` |

Detalhamento adicional de tecnologias, quando ultrapassar este nível, é responsabilidade de **TECH_STACK** (ainda não criado, conforme PROJECT_MASTER_PLAN Seção 4).

---

# 4. Estrutura do Monorepo

```
finance-os/
├── apps/
│   ├── web/       # Aplicação Next.js (App Router) — BFF, única aplicação ativa
│   └── api/       # Diretório reservado, sem aplicação ativa (apenas .gitkeep)
├── packages/
│   ├── database/  # Camada de persistência: schema Prisma, migrations, client (@finance-os/database)
│   ├── config/    # Reservado — sem package.json além do scaffold inicial
│   ├── types/     # Reservado — sem package.json além do scaffold inicial
│   ├── ui/        # Reservado — sem package.json além do scaffold inicial
│   └── utils/     # Reservado — sem package.json além do scaffold inicial
├── docs/          # Documentação oficial (ver DOCUMENT_HIERARCHY)
└── tools/         # Scripts auxiliares (PowerShell): bootstrap-ai-workflow.ps1, financeos.ps1, organize-docs.ps1
```

**Nota sobre `apps/api`:** existe apenas como diretório reservado (`.gitkeep`, sem código-fonte). Não representa uma aplicação de backend ativa e não contradiz o padrão BFF da Seção 5 — é espaço reservado no scaffold do monorepo.

**Nota sobre `packages/config`, `types`, `ui`, `utils`:** declarados no workspace (`pnpm-workspace.yaml`: `apps/*`, `packages/*`), mas sem implementação própria além do scaffold inicial.

---

# 5. Arquitetura BFF

O FinanceOS adota **BFF (Backend for Frontend) implementado via Next.js App Router**, sem framework de backend separado — decisão já pressuposta como aprovada em API Seção 3 ("implementada via Next.js, conforme já definido em ARCHITECTURE_BASELINE").

- Toda comunicação entre frontend e persistência ocorre por meio de Route Handlers e Server Actions do Next.js, dentro de `apps/web`.
- Não existe, no estado atual do repositório, uma aplicação de backend autônoma em execução (ver nota sobre `apps/api`, Seção 4).
- Server Components são o padrão por default; Client Components apenas quando há necessidade real de interatividade — convenção já registrada em CODING_STANDARDS Seção 5 (não repetida aqui).
- Convenções de comunicação (nomenclatura de endpoints, verbos HTTP, paginação, versionamento) são responsabilidade de **API** — não repetidas aqui.

---

# 6. Persistência

- **ORM:** Prisma, sobre **PostgreSQL 17**.
- **Localização:** `packages/database`, encapsulando schema, migrations e client (`@finance-os/database`).
- **Migrations:** exclusivamente via Prisma Migrate (`prisma migrate dev` / `prisma migrate deploy`), conforme já registrado em DATABASE — nenhuma outra estratégia de migration é utilizada.
- **Cache:** Redis 8, como camada de dados voláteis, separada da persistência primária.

Modelagem de entidades, relacionamentos e regras específicas de dados (ex.: soft delete, chaves estrangeiras, auditoria) são responsabilidade de **DATABASE** — não repetidas aqui.

---

# 7. Infraestrutura

Definida em `docker-compose.yml`, raiz do repositório:

| Serviço | Imagem | Porta | Volume | Healthcheck |
|---|---|---|---|---|
| `postgres` | `postgres:17` | `5432:5432` | `postgres_data` | `pg_isready` |
| `redis` | `redis:8` | `6379:6379` | `redis_data` | `redis-cli ping` |

Ambos os serviços compartilham a rede `financeos-network` (driver `bridge`). Procedimento operacional (subir/derrubar containers, reset de volumes) é responsabilidade de **SETUP** — não repetido aqui.

---

# 8. Qualidade

- **Convenções de código:** responsabilidade exclusiva de **CODING_STANDARDS** — não repetidas aqui.
- **Critérios de aceite de entrega** (build, lint, testes): responsabilidade de **QUALITY_GATE** e do checklist de validação definido em AI_WORKFLOW Seção 7.
- **Lint verificado no repositório:** ESLint configurado via flat config (`eslint.config.mjs`) exclusivamente em `apps/web`, executado por `pnpm lint` → `turbo run lint`. Não há configuração de lint compartilhada em `packages/config` no estado atual — o pacote existe apenas como scaffold reservado (ver Seção 4).
- **Testes:** nenhuma ferramenta de teste está configurada no repositório no estado atual (nenhum framework de testes localizado nos `package.json` existentes).

---

# 9. Segurança

Princípios já registrados em documentos oficiais existentes, consolidados aqui por serem de natureza arquitetural:

- Toda comunicação que exponha ou modifique dados sensíveis exige autenticação; autorização é tratada como camada distinta de autenticação (já registrado em API Seção 6, não repetido em detalhe).
- Erros internos nunca expõem detalhes de implementação, stack traces ou informação sensível (já registrado em API Seção 7 e CODING_STANDARDS Seção 7).
- Logs não devem expor dados sensíveis, independentemente do nível de severidade (já registrado em CODING_STANDARDS Seção 8).
- Integridade e auditabilidade de operações financeiras são princípio de projeto (ver Seção 2).

**Mecanismo concreto de autenticação/autorização será definido durante EPIC-004** — API Seção 6 declara explicitamente que essa é "uma decisão arquitetural a ser registrada separadamente quando tomada". Este documento não a antecipa (ver Seção 12).

---

# 10. Decisões Arquiteturais (Registro)

| Decisão | Estado |
|---|---|
| BFF via Next.js App Router, sem backend separado | Aprovada e em vigor |
| Prisma como ORM exclusivo sobre PostgreSQL | Aprovada e em vigor |
| Redis como camada de cache/dados voláteis | Aprovada e em vigor |
| Turborepo + PNPM workspaces como base do monorepo | Aprovada e em vigor |
| Documentação legada (formato antigo, referências a NestJS) arquivada em `docs/archives/legacy-v0/` | Aprovada — aplicação via TASK-001.5.01 |
| Mecanismo de autenticação/autorização | A definir durante EPIC-004 |
| Biblioteca/ferramenta de logging estruturado | A definir durante EPIC-001 |
| Estratégia concreta de versionamento de API | A definir quando necessário |

---

# 11. Evolução

Este documento registra apenas o estado atual — não antecipa funcionalidades futuras. A evolução planejada do projeto é responsabilidade exclusiva de **ROADMAP**, que já lista, entre outras, EPIC-004 (Autenticação e Autorização), EPIC-010 (Open Finance) e EPIC-012 (Observabilidade) como fases futuras ainda em backlog.

Áreas de expansão já oficialmente previstas em outros documentos aprovados (referenciadas, não detalhadas aqui): Open Finance, importadores, APIs públicas, webhooks e integrações bancárias (API Seção 10); evolução para modelo SaaS multiusuário (PROJECT_MASTER_PLAN Seção 1).

Quando qualquer uma dessas áreas for efetivamente decidida e implementada, este documento deve ser atualizado para refletir o novo estado — conforme o ciclo de vida definido em DOCUMENTATION_GUIDE Seção 4.

---

# 12. Pendências

Itens explicitamente identificados como não decididos, registrados aqui por transparência (permitido por DOCUMENT_HIERARCHY Seção 8, que admite seções de pendências como exceção à regra de "somente decisões já tomadas"):

- Mecanismo concreto de autenticação/autorização (A definir durante EPIC-004).
- Ferramenta/biblioteca de logging estruturado (A definir durante EPIC-001).
- Ferramenta de observabilidade (A definir durante EPIC-012).
- Estratégia concreta de versionamento de contrato de API (A definir quando necessário).

---

# 13. Referências

Este documento não repete conteúdo já registrado em:

- **DATABASE** — schema, entidades e regras de modelagem de dados.
- **API** — contratos de comunicação, Route Handlers, Server Actions, autenticação.
- **CODING_STANDARDS** — convenções de código e padrões Next.js/Prisma no nível de implementação.
- **DOCUMENT_HIERARCHY** — política de SSOT e hierarquia documental.
- **DOCUMENTATION_GUIDE** — ciclo de vida e convenções da documentação.
- **SETUP** — procedimento de configuração de ambiente local.
- **ROADMAP** — sequenciamento de EPICs.

Em caso de divergência entre este documento e o estado real do repositório, prevalece o princípio definido em DOCUMENT_HIERARCHY Seção 7: a IA deve interromper a execução e reportar o conflito — nunca decidir unilateralmente.

Fim do documento.
