# FinanceOS — Project Master Plan

**Documento:** docs/PROJECT_MASTER_PLAN.md
**Versão:** 1.2
**Status:** Aprovado
**Epic:** EPIC-000
**Task:** TASK-000.15
**Última Atualização:** 2026-07-10

---

# 1. Objetivo do FinanceOS

O FinanceOS é uma plataforma de gestão financeira pessoal, concebida para substituir o uso de planilhas por um sistema centralizado, automatizado e preparado para evolução contínua.

O propósito do sistema é consolidar, em um único lugar, a vida financeira do usuário — permitindo o acompanhamento de receitas, despesas, patrimônio, investimentos e planejamento financeiro.

O público-alvo inicial é o usuário individual e a família. A visão de longo prazo contempla evolução para pequenas empresas e escritórios financeiros, com arquitetura preparada desde o início para suportar um modelo SaaS multiusuário.

Este documento não detalha funcionalidades — o detalhamento funcional é responsabilidade de documentos especializados (ver Seção 4).

---

# 2. Missão do Projeto

O FinanceOS existe para resolver um problema recorrente: o controle financeiro pessoal e familiar depende hoje, majoritariamente, de planilhas manuais, propensas a erro, sem automação e sem consolidação entre múltiplas fontes (contas, cartões, investimentos).

A proposta de valor do FinanceOS é oferecer uma plataforma que automatiza a importação e classificação de dados financeiros, consolida múltiplas contas em uma visão única, gera indicadores acionáveis e apoia a tomada de decisão financeira — com integridade de dados e auditabilidade como prioridades máximas.

---

# 3. Estado Atual

- EPIC-000 encontra-se **concluída**.
- A documentação oficial do FinanceOS encontra-se consolidada.
- A estrutura documental estabelecida durante a EPIC-000 passa a ser a **Single Source of Truth (SSOT)** oficial do projeto.
- O desenvolvimento futuro deverá seguir obrigatoriamente esta documentação.
- Plataforma de engenharia (monorepo, qualidade, infraestrutura local) em consolidação.
- Desenvolvimento guiado por EPICs, com entrega incremental via PRs escopados.

---

# 4. Estrutura Oficial da Documentação

| Documento | Objetivo | Responsável |
|---|---|---|
| README | Porta de entrada resumida do repositório, com links para os documentos oficiais. | Engenharia |
| PROJECT_MASTER_PLAN | Ponto de entrada oficial do projeto; hub de navegação para toda a documentação. | Arquitetura de Software |
| ARCHITECTURE_BASELINE | Consolidação factual do estado arquitetural aprovado: stack, camadas, estrutura do monorepo. | Arquitetura de Software |
| DOCUMENT_HIERARCHY | Política de Single Source of Truth e hierarquia entre documentos. | Arquitetura de Software |
| DOCUMENTATION_GUIDE | Estratégia de evolução, ciclo de vida e convenções da documentação do projeto. | Arquitetura de Software |
| TECH_STACK (ainda não criado) | Detalhamento de tecnologias e versões, quando além do escopo do baseline. | Arquitetura de Software |
| DATABASE | Schema de dados, modelos e estratégia de migrations. | Engenharia de Dados |
| API | Contratos de endpoints, Route Handlers e Server Actions. | Engenharia |
| BUSINESS_RULES (ainda não criado) | Regras de negócio financeiras do FinanceOS. | Produto / Arquitetura |
| CODING_STANDARDS | Convenções de código e padrões de teste. | Engenharia |
| ROADMAP | Sequenciamento de EPICs e fases de entrega. | Produto |
| AI_CONTEXT | Contexto operacional para agentes de IA envolvidos no projeto. | Arquitetura de Software |
| AI_TEAM | Papel de cada IA envolvida no desenvolvimento. | Arquitetura de Software |
| AI_WORKFLOW | Fluxo de trabalho que agentes de IA devem seguir por task. | Arquitetura de Software |
| QUALITY_GATE | Critérios mínimos de qualidade para aceite de entregas. | Engenharia |
| SETUP | Instruções de configuração de ambiente de desenvolvimento local. | Engenharia |

---

# 5. Fluxo Oficial de Consulta

README
↓
PROJECT_MASTER_PLAN
↓
ARCHITECTURE_BASELINE
↓
Documento especializado
↓
Código

---

# 6. Organização do Projeto

O FinanceOS é organizado como um monorepo, contendo:

- **Apps** — aplicações executáveis do projeto (ex.: aplicação web).
- **Packages** — pacotes de domínio e utilitários compartilhados entre aplicações (ex.: camada de dados).
- **Documentação** — conjunto de documentos oficiais em `docs/`, organizados conforme a hierarquia definida em DOCUMENT_HIERARCHY.
- **Ferramentas** — plataforma de qualidade e automação (lint, formatação, hooks de commit) e infraestrutura de desenvolvimento local, aplicadas de forma centralizada no monorepo.

Detalhes técnicos de cada camada não são repetidos aqui — ver ARCHITECTURE_BASELINE.

---

# 7. Roadmap Geral

Visão macro de EPICs. Detalhamento de escopo, entregas e status de cada EPIC é responsabilidade do documento ROADMAP.

- **EPIC-000** — Governança e consolidação documental do projeto.
- **EPIC-001** — Plataforma de engenharia (monorepo, infraestrutura, qualidade).
- **EPIC-002** — *(planejado — detalhamento em ROADMAP)*
- **EPIC-003** — Modelagem de domínio de identidade e autorização.
- *(demais EPICs, cobrindo os módulos funcionais principais do FinanceOS — Contas, Transações, Importadores, Orçamento, Investimentos, Inteligência — serão listados e detalhados em ROADMAP à medida que forem formalizados)*

---

# 8. Governança

A definição de arquitetura, implementação e revisão do FinanceOS segue papéis específicos, detalhados nos documentos AI_TEAM e AI_WORKFLOW — não duplicados aqui.

Em linhas gerais:

- **Quem define arquitetura**: papel documentado em AI_TEAM.
- **Quem implementa**: papel documentado em AI_TEAM.
- **Quem revisa**: processo documentado em AI_WORKFLOW.
- **Quem aprova**: processo documentado em AI_WORKFLOW.

---

# 9. Documentos Obrigatórios Antes de Desenvolver

Antes de iniciar qualquer implementação, os seguintes documentos devem ser consultados:

- ☐ PROJECT_MASTER_PLAN
- ☐ ARCHITECTURE_BASELINE
- ☐ DOCUMENT_HIERARCHY
- ☐ ROADMAP
- ☐ BUSINESS_RULES (quando existir)
- ☐ CODING_STANDARDS (quando existir)

---

# 10. Regras Gerais

- O PROJECT_MASTER_PLAN é o ponto de entrada oficial do projeto.
- Não deve conter duplicidade de informação com nenhum outro documento.
- Deve sempre referenciar documentos especializados em vez de repetir seu conteúdo.
- Deve permanecer estável ao longo do projeto — mudanças frequentes aqui indicam que conteúdo específico demais foi incluído indevidamente.
- Mudanças estruturais relevantes no projeto devem ser refletidas primeiro na documentação oficial correspondente antes de serem consideradas parte do estado atual.