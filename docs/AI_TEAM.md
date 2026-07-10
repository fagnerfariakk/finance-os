```markdown
# FinanceOS — AI Team

**Documento:** docs/AI_TEAM.md
**Versão:** 1.0
**Status:** Aprovado
**Epic:** EPIC-000
**Task:** TASK-000.04
**Última Atualização:** 2026-07-09

---

# 1. Objetivo

Este documento define oficialmente a **equipe responsável pelo desenvolvimento do FinanceOS**, incluindo o Product Owner e as Inteligências Artificiais que participam do projeto.

Ele estabelece **quem participa, qual o papel de cada integrante e quais responsabilidades pertencem a cada um**. Não define processo de trabalho (ver AI_WORKFLOW), nem contexto operacional de IA (ver AI_CONTEXT), nem arquitetura ou stack (ver ARCHITECTURE_BASELINE).

---

# 2. Estrutura da Equipe

```
Product Owner
   ↓
ChatGPT
   ↓
Claude
   ↓
DeepSeek
   ↓
Gemini
```

Esta estrutura representa a equipe atualmente formalizada. Novas IAs poderão ser incorporadas futuramente à medida que o projeto evoluir, sem que isso exija alteração da estrutura documental estabelecida em DOCUMENT_HIERARCHY (ver Seção 10).

---

# 3. Product Owner

Responsabilidades:

- Definir e manter a visão do produto.
- Priorizar EPICs.
- Aprovar entregas em nível final.
- Definir requisitos de produto.
- Validar funcionalmente o que foi entregue.

---

# 4. ChatGPT

Papel: **Arquiteto do projeto, Technical Lead e PMO técnico.**

Responsabilidades:

- Definir a arquitetura do projeto.
- Definir a estrutura da documentação.
- Decompor EPICs.
- Gerar TASKs a serem executadas.
- Realizar revisão técnica das entregas.
- Realizar auditoria técnica do projeto.
- Conceder aprovação técnica.

O ChatGPT é a **autoridade técnica** do FinanceOS. Decisões arquiteturais novas são de sua responsabilidade exclusiva.

---

# 5. Claude

Responsabilidades:

- Implementar o que foi solicitado em cada TASK.
- Documentar decisões já aprovadas.
- Gerar código.
- Realizar pequenas refatorações, dentro do escopo da TASK.
- Executar TASKs conforme definidas.
- Reportar conflitos identificados durante a execução.

Claude **não define arquitetura**. Sua atuação é subordinada às decisões técnicas já aprovadas pelo ChatGPT e registradas nos documentos oficiais do projeto.

---

# 6. DeepSeek

Responsabilidades futuras (papel ainda não ativo no projeto):

- Refatorações de grande porte.
- Otimização de performance.
- Trabalho especializado em SQL.
- Algoritmos.
- Geração massiva de código.

---

# 7. Gemini

Responsabilidades futuras (papel ainda não ativo no projeto):

- Pesquisa técnica.
- Validação técnica complementar.
- Documentação externa.
- Integrações com APIs externas.
- Assuntos de cloud.
- Revisão complementar de entregas.

---

# 8. Responsabilidade Compartilhada

Atividades que pertencem à equipe como um todo, independentemente do papel individual:

- Preservar a qualidade geral do projeto.
- Manter a documentação consistente com o estado real do projeto.
- Respeitar a política de Single Source of Truth.
- Reportar conflitos identificados, em vez de resolvê-los unilateralmente fora do próprio papel.

---

# 9. Matriz de Responsabilidades

| | Product Owner | ChatGPT | Claude | DeepSeek | Gemini |
|---|---|---|---|---|---|
| Arquitetura | Consulta | Responsável | Apoio | Não aplicável | Consulta |
| Documentação | Consulta | Responsável | Apoio | Não aplicável | Apoio |
| Código | Não aplicável | Consulta | Responsável | Apoio | Não aplicável |
| Refatoração | Não aplicável | Consulta | Apoio | Responsável | Não aplicável |
| Review | Consulta | Responsável | Apoio | Apoio | Apoio |
| Pesquisa | Consulta | Apoio | Não aplicável | Não aplicável | Responsável |
| Roadmap | Responsável | Apoio | Não aplicável | Não aplicável | Não aplicável |
| Qualidade | Consulta | Responsável | Apoio | Apoio | Consulta |
| Auditoria | Consulta | Responsável | Apoio | Não aplicável | Apoio |

---

# 10. Evolução da Equipe

Novos agentes de IA poderão ser incorporados à equipe do FinanceOS futuramente, conforme a necessidade do projeto evoluir. A incorporação de novos agentes não exige alteração da estrutura documental definida em DOCUMENT_HIERARCHY — apenas a atualização deste documento (AI_TEAM), que é a fonte oficial e única para papéis e responsabilidades da equipe.
```