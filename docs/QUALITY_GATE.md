```markdown
# FinanceOS — Quality Gate

**Documento:** docs/QUALITY_GATE.md
**Versão:** 1.0
**Status:** Aprovado
**Epic:** EPIC-000
**Task:** TASK-000.06
**Última Atualização:** 2026-07-09

---

# 1. Objetivo

Este documento define os **critérios mínimos de qualidade** que qualquer entrega do FinanceOS deve atender antes de ser considerada pronta para revisão ou merge.

Ele não define processo de execução de TASK (ver AI_WORKFLOW), papéis da equipe (ver AI_TEAM), princípios gerais de atuação de IA (ver AI_CONTEXT) ou arquitetura (ver ARCHITECTURE_BASELINE) — trata exclusivamente do que caracteriza uma entrega **qualificada**.

---

# 2. Filosofia

Qualidade no FinanceOS é validada **continuamente**, não apenas ao final de uma entrega.

Nenhuma entrega deve ser considerada concluída apenas porque "funciona". Funcionar é condição necessária, mas não suficiente — a entrega também precisa respeitar escopo, preservar arquitetura, manter documentação consistente e não introduzir riscos ocultos.

---

# 3. Critérios Obrigatórios

| Critério | Obrigatório | Descrição |
|---|---|---|
| Build | Sim | O projeto deve compilar/buildar com sucesso após a alteração. |
| Lint | Sim | O código deve passar nas regras de lint configuradas no projeto. |
| Testes | Condicional | Testes existentes devem passar; novos testes são obrigatórios quando aplicável ao escopo da TASK. |
| Documentação | Sim | Documentos oficiais impactados pela mudança devem permanecer consistentes com o estado real do código. |
| Escopo | Sim | Apenas os arquivos autorizados pela TASK podem ser alterados. |
| Arquitetura | Sim | A entrega deve respeitar as decisões registradas em ARCHITECTURE_BASELINE, sem introduzir desvio não aprovado. |
| Sem conflitos | Sim | Nenhum conflito documental, arquitetural ou de escopo pode permanecer sem ser reportado. |
| Sem arquivos temporários | Sim | Nenhum arquivo de uso temporário, debug ou gerado acidentalmente pode integrar a entrega. |

---

# 4. Checklist Pré-Review

- ☐ Build executado
- ☐ Lint executado
- ☐ Testes executados (quando existirem)
- ☐ Documentação atualizada
- ☐ Escopo respeitado
- ☐ Nenhum arquivo temporário
- ☐ Nenhum segredo versionado
- ☐ Nenhum conflito oculto
- ☐ Commits coerentes

---

# 5. Critérios de Reprovação

Uma entrega é reprovada quando apresenta, entre outras, as seguintes situações:

- Build quebrado.
- Lint falhando.
- Arquivos alterados fora do escopo autorizado pela TASK.
- Documentação inconsistente com o estado real do código.
- Presença de código morto ou comentado sem justificativa.
- Introdução de dependências desnecessárias ao escopo da TASK.
- Alterações sem justificativa clara ou rastreável à TASK correspondente.

---

# 6. Evidências Esperadas

Toda entrega deve ser acompanhada das seguintes evidências:

- Resultado do build.
- Resultado do lint.
- Resultado dos testes (quando aplicável).
- Lista de arquivos alterados.
- Riscos conhecidos identificados durante a execução.

---

# 7. Exceções

Determinados critérios podem ser dispensados em situações específicas, desde que a exceção seja **explicitamente justificada** no reporte da entrega. Exemplos:

- Ausência de testes automatizados, quando a infraestrutura de testes ainda não está estabelecida para aquele módulo.
- Documentação ainda inexistente para um assunto específico, quando a criação do respectivo documento oficial estiver fora do escopo da TASK atual.

Nenhuma exceção é assumida silenciosamente — toda dispensa de critério deve constar explicitamente no reporte da TASK.

---

# 8. Critérios para Merge

Uma entrega está apta para merge quando:

- A revisão técnica foi concluída.
- O Quality Gate foi aprovado, conforme os critérios desta política.
- A documentação permanece consistente com o estado real do projeto.
- Não há pendências críticas em aberto.

---

# 9. Evolução do Quality Gate

Novos critérios de qualidade poderão ser adicionados a este documento conforme o projeto amadurecer — por exemplo, com a introdução de cobertura mínima de testes, métricas de performance ou critérios de segurança adicionais. Este documento é a fonte oficial e única para os critérios de qualidade do FinanceOS.
```