# FinanceOS — Documentation Guide

**Documento:** docs/DOCUMENTATION_GUIDE.md
**Versão:** 1.0
**Status:** Aprovado
**Epic:** EPIC-000
**Task:** TASK-000.08
**Última Atualização:** 2026-07-09

---

# 1. Objetivo

Este documento define a **estratégia de documentação** do FinanceOS — como a documentação deve evoluir ao longo do ciclo de vida do sistema.

Documentação, no FinanceOS, é parte do produto, não um artefato acessório. Ela é a base sobre a qual decisões técnicas, de negócio e de implementação são tomadas e rastreadas — por isso sua qualidade e consistência têm o mesmo peso que a qualidade do código.

Este documento complementa DOCUMENT_HIERARCHY (que define *quem é a fonte oficial de cada assunto*) descrevendo *como* a documentação deve ser mantida ao longo do tempo.

---

# 2. Princípios

- **Single Source of Truth** — cada assunto tem um único documento oficial; toda menção fora dele é referência, não repetição.
- **Clareza** — a documentação deve ser compreensível sem exigir conhecimento tácito não escrito.
- **Atualização contínua** — a documentação acompanha o estado real do projeto, não uma fotografia estática do passado.
- **Baixo acoplamento** — documentos devem poder ser lidos e atualizados de forma independente sempre que possível, minimizando efeito cascata.
- **Reutilização** — informação já documentada é referenciada, nunca reescrita.
- **Rastreabilidade** — toda decisão registrada deve ser identificável quanto à origem (EPIC, TASK, versão).

---

# 3. Estrutura da Documentação

A documentação do FinanceOS é organizada em camadas:

- **Documentos estratégicos** — visão de produto e evolução macro do projeto (ex.: PROJECT_MASTER_PLAN, ROADMAP).
- **Documentos arquiteturais** — decisões técnicas estruturais já aprovadas (ex.: ARCHITECTURE_BASELINE, DOCUMENT_HIERARCHY).
- **Documentos técnicos** — detalhamento especializado de domínios específicos (ex.: DATABASE, API, BUSINESS_RULES, CODING_STANDARDS).
- **Documentos operacionais** — processo e critérios de execução do dia a dia (ex.: AI_CONTEXT, AI_TEAM, AI_WORKFLOW, QUALITY_GATE, SETUP).
- **Documentação futura** — assuntos ainda sem documento oficial, a serem criados conforme a necessidade surgir, respeitando sempre a política de SSOT antes da criação (ver DOCUMENT_HIERARCHY, Seção 5).

---

# 4. Ciclo de Vida

- **Criar documento**: quando um assunto relevante ao projeto ainda não possui documento oficial correspondente na hierarquia estabelecida.
- **Atualizar documento**: quando há mudança real no estado do assunto do qual aquele documento é responsável — a atualização deve ocorrer no momento em que a mudança é aprovada, não retroativamente.
- **Arquivar documento**: quando um documento deixa de ser aplicável ao estado atual do projeto (ex.: substituído por uma nova decisão), mas ainda possui valor histórico ou de rastreabilidade.
- **Substituir documento**: quando uma nova versão consolidada torna o conteúdo anterior obsoleto por completo; a substituição deve deixar claro qual documento passa a ser a nova fonte oficial.

---

# 5. Convenções

- **Nomes de arquivos**: em maiúsculas, com underscore separando palavras (ex.: `ARCHITECTURE_BASELINE.md`, `DOCUMENT_HIERARCHY.md`), refletindo o padrão já em uso no projeto.
- **Versionamento**: todo documento oficial deve declarar um número de versão no cabeçalho, incrementado a cada atualização de conteúdo relevante.
- **Status**: todo documento oficial deve declarar seu status (ex.: Aprovado, Em Revisão, Obsoleto).
- **Cabeçalhos**: todo documento oficial deve conter, no topo, identificação do documento, versão, status, EPIC/TASK de origem e data da última atualização — seguindo o padrão já estabelecido nos documentos existentes do projeto.
- **Organização das seções**: seções numeradas sequencialmente, com títulos claros e escopo delimitado, evitando seções que misturem mais de um assunto de responsabilidade distinta.

---

# 6. Critérios de Qualidade

Uma documentação é considerada adequada quando:

- Reflete o estado real do projeto no momento da leitura.
- Não contém informação duplicada de outro documento oficial.
- É compreensível para um novo participante da equipe (humano ou IA) sem depender de contexto não escrito.
- Está posicionada corretamente na hierarquia documental (ver DOCUMENT_HIERARCHY).
- Permite rastrear a origem da decisão registrada (EPIC/TASK correspondente).

---

# 7. Anti-padrões

Práticas que devem ser evitadas na documentação do FinanceOS:

- **Duplicidade** — repetir em um documento conteúdo que já é responsabilidade de outro.
- **Documentação desatualizada** — manter descrições que não correspondem mais ao estado real do código ou da arquitetura.
- **Decisões sem rastreabilidade** —