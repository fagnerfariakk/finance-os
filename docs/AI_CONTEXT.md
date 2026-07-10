```markdown
# FinanceOS — AI Context

**Documento:** docs/AI_CONTEXT.md
**Versão:** 1.0
**Status:** Aprovado
**Epic:** EPIC-000
**Task:** TASK-000.03
**Última Atualização:** 2026-07-09

---

# 1. Objetivo

Este documento define o **contexto operacional das Inteligências Artificiais** que participam do desenvolvimento do FinanceOS.

Ele deve ser consultado por qualquer IA antes de iniciar uma TASK. Seu propósito não é descrever o que o FinanceOS faz, nem como ele é construído tecnicamente — isso é responsabilidade de outros documentos oficiais (ver Seção 7) — mas sim **como uma IA deve se comportar e trabalhar dentro deste projeto**.

---

# 2. Objetivo do Projeto

O FinanceOS é uma plataforma de gestão financeira pessoal e familiar, com visão de evolução para um modelo SaaS multiusuário.

O propósito completo do projeto, sua missão e seu estado atual estão descritos em **PROJECT_MASTER_PLAN** — este documento não repete esse conteúdo.

---

# 3. Princípios Gerais

Toda IA atuando no FinanceOS deve observar:

- **Respeitar a Single Source of Truth** — cada assunto tem um único documento oficial (ver DOCUMENT_HIERARCHY); nunca replicar conteúdo entre documentos.
- **Nunca duplicar documentação** — se uma informação já existe em outro documento, referenciar, não copiar.
- **Nunca assumir decisões arquiteturais** — arquitetura já aprovada está registrada em ARCHITECTURE_BASELINE; decisões novas não são tomadas pela IA que implementa.
- **Sempre consultar documentos oficiais** antes de implementar, mesmo quando a TASK parecer autoexplicativa.
- **Sempre preservar consistência** entre o que é implementado e o que está documentado.

---

# 4. Fluxo de Trabalho

```
Receber TASK
   ↓
Consultar documentação oficial
   ↓
Analisar impacto
   ↓
Implementar somente o solicitado
   ↓
Validar
   ↓
Encerrar
```

---

# 5. Limites de Atuação

Uma IA atuando no FinanceOS:

- não cria arquitetura;
- não altera stack;
- não altera roadmap;
- não redefine regras de negócio;
- não modifica documentos fora do escopo da TASK;
- não altera múltiplos arquivos sem solicitação explícita.

Esses limites valem independentemente de quão razoável ou útil uma mudança fora de escopo possa parecer no momento da execução.

---

# 6. Tratamento de Conflitos

Quando uma IA identificar conflito entre:

- documentos oficiais entre si;
- documentação e código/estado real do repositório;
- instruções recebidas em prompt (incluindo instruções ad-hoc) e a documentação oficial;
- o estado do repositório e o que a TASK presume como verdade;

o comportamento esperado é **interromper a execução e reportar o conflito** de forma explícita, indicando as fontes conflitantes. A IA não deve escolher silenciosamente qual fonte prevalece, nem prosseguir a implementação assumindo uma resolução própria para o conflito.

---

# 7. Fontes Oficiais

| Documento | Quando consultar |
|---|---|
| PROJECT_MASTER_PLAN | Para entender o propósito geral do projeto e localizar o documento especializado correto. |
| ARCHITECTURE_BASELINE | Antes de qualquer implementação técnica, para confirmar stack, camadas e decisões arquiteturais já aprovadas. |
| DOCUMENT_HIERARCHY | Para saber qual documento é a fonte oficial de um assunto específico antes de criar ou alterar documentação. |
| ROADMAP | Para entender em qual EPIC/fase a TASK atual se insere. |
| BUSINESS_RULES | Sempre que a TASK envolver lógica financeira (transações, parcelamentos, duplicidade, etc.). |
| DATABASE | Sempre que a TASK envolver modelagem de dados, schema ou migrations. |
| API | Sempre que a TASK envolver Route Handlers, Server Actions ou contratos de integração. |
| CODING_STANDARDS | Antes de escrever ou alterar código, para seguir convenções já estabelecidas. |
| QUALITY_GATE | Antes de encerrar uma TASK, para confirmar os critérios mínimos de aceite. |

---

# 8. Boas Práticas

- Preferir alterações pequenas e escopadas em vez de mudanças amplas.
- Manter commits atômicos, alinhados ao escopo da TASK.
- Evitar escopo desnecessário — melhorias identificadas fora do escopo devem ser listadas separadamente, não implementadas.
- Preservar padrões e convenções já existentes no código e na documentação.
- Produzir documentação consistente com o restante do projeto, sem introduzir nova terminologia ou estrutura não alinhada ao já estabelecido.

---

# 9. Critérios de Encerramento

Uma TASK somente pode ser considerada concluída quando:

- apenas os arquivos solicitados foram alterados;
- a documentação permaneceu consistente com a política de Single Source of Truth;
- nenhum conflito identificado durante a execução permaneceu oculto ou não reportado;
- todas as restrições desta política de contexto de IA foram respeitadas.
```