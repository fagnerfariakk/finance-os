# FinanceOS — Roadmap

**Documento:** docs/ROADMAP.md
**Versão:** 1.2
**Status:** Aprovado
**Epic:** EPIC-001
**Task:** TASK-001.99
**Última Atualização:** 2026-07-13

---

# 1. Objetivo

Este documento apresenta a **evolução planejada do FinanceOS**, organizada em EPICs.

O roadmap é **estratégico**, não operacional: ele indica a ordem e o agrupamento macro da evolução do projeto, sem detalhar TASKs, cronogramas, datas ou estimativas — esse nível de detalhe pertence a outros documentos e artefatos de execução.

---

# 2. Princípios

- Evolução incremental.
- Entregas pequenas.
- Validação contínua.
- Documentação primeiro.
- Qualidade antes de velocidade.

---

# 3. Estado Atual

- **EPIC-000** concluída — governança e consolidação documental do projeto.
- Plataforma documental consolidada, seguindo a hierarquia definida em DOCUMENT_HIERARCHY.
- Plataforma de engenharia (monorepo, infraestrutura local, qualidade) estabilizada.

---

# 4. Roadmap Estratégico

| EPIC | Objetivo | Status |
|---|---|---|
| EPIC-000 | Governança e documentação | Concluída |
| EPIC-001 | Plataforma de Engenharia | Concluída |
| EPIC-002 | Infraestrutura Compartilhada | Backlog |
| EPIC-003 | Persistência e Banco de Dados | Em execução |
| EPIC-004 | Autenticação e Autorização | Backlog |
| EPIC-005 | Core Financeiro | Backlog |
| EPIC-006 | Importadores | Backlog |
| EPIC-007 | Dashboard | Backlog |
| EPIC-008 | Orçamento | Backlog |
| EPIC-009 | Investimentos | Backlog |
| EPIC-010 | Open Finance | Backlog |
| EPIC-011 | Inteligência Financeira | Backlog |
| EPIC-012 | Observabilidade | Backlog |
| EPIC-013 | Deploy | Backlog |
| EPIC-014 | MVP | Backlog |

---

# 5. Macrofases

As EPICs são agrupadas nas seguintes macrofases:

- **Fundação** — EPIC-000, EPIC-001, EPIC-002, EPIC-003, EPIC-004
- **Core** — EPIC-005, EPIC-006, EPIC-007
- **Funcionalidades** — EPIC-008, EPIC-009
- **Integrações** — EPIC-010, EPIC-011
- **Operação** — EPIC-012, EPIC-013, EPIC-014

---

# 6. Critérios para Evolução

Uma EPIC pode ser considerada concluída quando:

- A documentação relacionada está concluída e consistente.
- O Quality Gate foi aprovado para as entregas correspondentes.
- A validação técnica foi realizada.
- O Product Owner aprovou a entrega.

---

# 7. Dependências

EPICs posteriores dependem da consolidação das EPICs anteriores dentro da mesma macrofase, e macrofases posteriores dependem da consolidação da Fundação. Dependências detalhadas entre EPICs específicas não são definidas neste documento.

---

# 8. Evolução do Roadmap

Novas EPICs poderão ser adicionadas a este roadmap conforme o projeto evoluir. Mudanças de prioridade entre EPICs já listadas são permitidas.

A estrutura macro deste documento — organização por EPIC e agrupamento em macrofases — deve permanecer estável ao longo do projeto, mesmo quando o conteúdo específico das EPICs for ajustado.

---

# 9. Histórico

- EPIC-000 concluída.
- Documentation Freeze realizado.
- Baseline documental versão 1.0 estabelecida.
- Todas as próximas EPICs deverão preservar a política de Single Source of Truth.
- EPIC-001 concluída.
- Plataforma de engenharia consolidada.
- Ferramentas oficiais de governança implementadas.
- Plataforma pronta para desenvolvimento funcional.