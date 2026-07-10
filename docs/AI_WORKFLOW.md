```markdown
# FinanceOS — AI Workflow

**Documento:** docs/AI_WORKFLOW.md
**Versão:** 1.0
**Status:** Aprovado
**Epic:** EPIC-000
**Task:** TASK-000.05
**Última Atualização:** 2026-07-09

---

# 1. Objetivo

Este documento define o **fluxo oficial de execução de TASKs** pelas Inteligências Artificiais que atuam no FinanceOS.

Ele descreve exclusivamente o **processo operacional** — etapas, checklist de validação e critérios de bloqueio/encerramento de uma TASK. Não define quem participa da equipe (ver AI_TEAM), não define princípios ou limites gerais de atuação de IA (ver AI_CONTEXT), e não define arquitetura, stack ou regras de negócio (ver ARCHITECTURE_BASELINE e documentos especializados correspondentes).

---

# 2. Workflow Oficial

```
Receber TASK
   ↓
Entender objetivo
   ↓
Consultar documentação oficial
   ↓
Analisar impacto
   ↓
Planejar implementação
   ↓
Executar
   ↓
Validar
   ↓
Reportar resultado
   ↓
Aguardar aprovação
```

---

# 3. Etapa 1 — Entendimento

Nesta etapa, a IA deve:

- Compreender completamente o objetivo da TASK.
- Identificar claramente os entregáveis esperados.
- Identificar as restrições declaradas (escopo, arquivos permitidos, regras obrigatórias).
- Esclarecer ambiguidades antes de iniciar qualquer implementação, em vez de assumir interpretação própria.

---

# 4. Etapa 2 — Consulta

Nesta etapa, a IA deve:

- Consultar apenas os documentos oficiais necessários ao escopo específico da TASK, evitando leitura ou aplicação de conteúdo irrelevante ao pedido.
- Sempre priorizar documentos oficiais em detrimento de suposições, memória de conversas anteriores ou instruções ad-hoc não formalizadas.

---

# 5. Etapa 3 — Planejamento

Nesta etapa, a IA deve:

- Avaliar o impacto da mudança sobre o restante do projeto.
- Identificar precisamente quais arquivos estão envolvidos na TASK.
- Evitar expansão de escopo além do solicitado.
- Preservar compatibilidade com o que já está implementado e documentado.

---

# 6. Etapa 4 — Implementação

Nesta etapa, a IA deve:

- Realizar alterações pequenas e escopadas.
- Manter commits atômicos, alinhados ao objetivo da TASK.
- Seguir os padrões já existentes no projeto (código e documentação).
- Alterar exclusivamente os arquivos autorizados pela TASK.

---

# 7. Etapa 5 — Validação

Checklist de validação antes do reporte:

- ☐ Build
- ☐ Lint
- ☐ Testes (quando existirem)
- ☐ Revisão da documentação
- ☐ Escopo respeitado
- ☐ Nenhum conflito oculto

---

# 8. Reporte da TASK

Ao concluir a execução, toda IA deve informar:

- Arquivos alterados.
- Validações realizadas.
- Limitações encontradas durante a execução.
- Pendências remanescentes.
- Riscos identificados, mesmo que fora do escopo direto da TASK.

---

# 9. Critérios para Bloqueio

A execução deve ser interrompida quando houver:

- Conflito documental (entre documentos oficiais entre si).
- Conflito arquitetural (entre a TASK e decisões já registradas em ARCHITECTURE_BASELINE).
- Falta de informação suficiente para executar com segurança.
- Necessidade de mudança fora do escopo declarado na TASK.
- Dependência não prevista que impeça a conclusão sem decisão adicional.

Nesses casos, a IA deve reportar o bloqueio de forma explícita em vez de prosseguir com suposições.

---

# 10. Encerramento

Uma TASK pode ser considerada **pronta para revisão** quando:

- Todas as etapas do Workflow Oficial (Seção 2) foram percorridas.
- O checklist de Validação (Seção 7) foi integralmente concluído.
- O reporte da TASK (Seção 8) foi entregue de forma completa.
- Nenhum critério de bloqueio (Seção 9) permaneceu ativo sem ser reportado.

A aprovação final da TASK, entretanto, permanece de responsabilidade definida em AI_TEAM — este documento apenas define quando a execução está tecnicamente pronta para ser submetida a essa aprovação.
```