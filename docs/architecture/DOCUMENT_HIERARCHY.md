```markdown
# FinanceOS — Document Hierarchy

**Documento:** docs/architecture/DOCUMENT_HIERARCHY.md
**Versão:** 1.0
**Status:** Aprovado
**Epic:** EPIC-000
**Task:** TASK-000.01
**Última Atualização:** 2026-07-09

---

# 1. Objetivo

Este documento define a **política oficial de documentação** do FinanceOS, com base no conceito de **Single Source of Truth (SSOT)**.

Single Source of Truth significa que, para cada assunto do projeto (stack, arquitetura, banco de dados, regras de negócio, convenções, etc.), existe **exatamente um documento oficial**. Qualquer outro documento que mencione esse assunto deve **referenciar** o documento oficial, nunca repetir ou redefinir seu conteúdo.

O objetivo direto desta política é eliminar duplicidade de informação — a causa raiz dos conflitos documentais já identificados na TASK-000.00 (ex.: stack descrita simultaneamente em CLAUDE.md e PRODUCT_REQUIREMENTS.md, framework de backend definido de forma divergente em fontes diferentes).

A partir da aprovação deste documento, nenhum novo conteúdo técnico deve ser criado sem antes verificar se já existe um documento oficial responsável por aquele assunto.

---

# 2. Hierarquia Oficial

```
PROJECT_MASTER_PLAN
   ↓
ARCHITECTURE_BASELINE
   ↓
Arquitetura
   ↓
Banco de Dados
   ↓
API
   ↓
Business Rules
   ↓
Guias
   ↓
Código
```

Documentos de nível superior têm precedência conceitual sobre os de nível inferior. Em caso de conflito não resolvido, o documento de nível mais alto na hierarquia prevalece até que o conflito seja formalmente reconciliado — mas o conflito deve sempre ser reportado, nunca resolvido silenciosamente (ver Seção 7).

---

# 3. Responsabilidade de Cada Documento

| Documento | Propósito |
|---|---|
| **PROJECT_MASTER_PLAN** | Visão geral do projeto, objetivos de negócio, roadmap macro e critérios de sucesso. Documento de mais alto nível; toda decisão técnica deve ser rastreável a um objetivo declarado aqui. |
| **ARCHITECTURE_BASELINE** | Consolidação factual do estado arquitetural aprovado do projeto: stack oficial, camadas, estrutura do monorepo, decisões arquiteturais registradas. Fonte oficial para "o que já foi decidido". |
| **TECH_STACK** | Detalhamento das tecnologias adotadas e suas versões, quando esse nível de detalhe ultrapassar o escopo do ARCHITECTURE_BASELINE. Não duplica a stack já registrada no baseline — apenas aprofunda. |
| **DATABASE** | Schema de dados, modelos, relacionamentos, estratégia de migrations. Fonte oficial para qualquer decisão de modelagem de dados. |
| **API** | Contratos de endpoints, Route Handlers, Server Actions, formatos de request/response, autenticação de API. Fonte oficial para integração entre frontend e camada de negócio. |
| **BUSINESS_RULES** | Regras de negócio financeiras (ex.: tratamento de transferências, parcelamentos, detecção de duplicidade). Nenhuma regra de negócio deve existir fora deste documento. |
| **CODING_STANDARDS** | Convenções de código, nomenclatura, padrões de teste, estrutura de módulos. Fonte oficial para "como o código deve ser escrito". |
| **ROADMAP** | Sequenciamento de entregas, EPICs e fases (V1 a V6). Não redefine escopo de produto — apenas ordena a execução. |
| **AI_CONTEXT** | Contexto operacional para agentes de IA: papel, responsabilidades, limites de atuação. |
| **AI_TEAM** | Definição de quais IAs participam do projeto e qual o papel de cada uma (ex.: quem decide arquitetura, quem implementa). |
| **AI_WORKFLOW** | Fluxo de trabalho que agentes de IA devem seguir ao receber uma task (entender, analisar, implementar, validar, reportar). |
| **QUALITY_GATE** | Critérios mínimos de qualidade para uma entrega ser aceita (build, lint, testes, cobertura). |
| **SETUP** | Instruções práticas de configuração de ambiente de desenvolvimento local. |
| **README** | Porta de entrada do repositório; visão geral resumida com links para os demais documentos oficiais. Não deve conter definições técnicas próprias além de apontar para as fontes corretas. |

---

# 4. Regras de Governança

- Cada assunto do projeto possui **apenas um documento oficial**.
- Todo documento que mencionar um assunto fora de sua própria responsabilidade deve **referenciar** o documento oficial correspondente, nunca reproduzir seu conteúdo.
- **Nunca duplicar regras de negócio** — toda regra de negócio vive exclusivamente em BUSINESS_RULES.
- **Nunca duplicar stack** — toda definição de tecnologia e versão vive exclusivamente em ARCHITECTURE_BASELINE (ou em TECH_STACK, quando este existir e for mais específico).
- **Nunca duplicar arquitetura** — decisões arquiteturais vivem exclusivamente em ARCHITECTURE_BASELINE.
- **Nunca duplicar convenções** — padrões de código vivem exclusivamente em CODING_STANDARDS.
- Nenhum documento deve reintroduzir uma decisão já registrada em um documento de nível superior na hierarquia (Seção 2).
- Instruções recebidas fora do fluxo documental (ex.: prompts ad-hoc em conversas) não têm status de documento oficial e não podem sobrepor a hierarquia definida aqui.

---

# 5. Processo de Atualização

**Criação de novo documento:**
Um novo documento só deve ser criado quando um assunto ainda não possuir documento oficial correspondente na tabela da Seção 3. Antes de criar, verificar se o conteúdo pretendido já é coberto, mesmo que parcialmente, por outro documento existente.

**Atualização de documento existente:**
Um documento deve ser atualizado quando há mudança real no assunto do qual ele é responsável (ex.: nova decisão arquitetural aprovada → atualizar ARCHITECTURE_BASELINE; nova regra de negócio validada → atualizar BUSINESS_RULES).

**Referência em vez de atualização:**
Quando um documento precisa mencionar um assunto que não é de sua responsabilidade, ele deve apenas referenciar o documento oficial (por nome/link), sem reproduzir o conteúdo. Isso vale mesmo que a menção seja breve — a regra de SSOT não tem exceção de tamanho.

---

# 6. Fluxo de Consulta

```
Desenvolvedor
   ↓
PROJECT_MASTER_PLAN
   ↓
ARCHITECTURE_BASELINE
   ↓
Documento específico
   ↓
Código
```

Qualquer dúvida sobre "o que fazer" ou "como fazer" deve seguir este caminho de consulta, do nível mais geral (visão de projeto) ao mais específico (implementação em código), evitando decisões baseadas em fontes fora dessa cadeia.

---

# 7. Regras para IA

- **ChatGPT** é responsável pelas decisões arquiteturais do projeto.
- **Claude** implementa e documenta decisões já aprovadas — não cria arquitetura nova por conta própria.
- Nenhuma IA envolvida no projeto pode criar arquitetura nova sem aprovação prévia registrada.
- Em caso de conflito entre documentos, ou entre um documento e o estado real do repositório, a IA deve **interromper a execução da task e reportar o conflito** — nunca decidir unilateralmente qual fonte prevalece nem silenciar a divergência.
- Instruções ad-hoc recebidas em conversa que proponham decisão arquitetural nova devem ser tratadas como solicitação sujeita a aprovação, não como decisão já tomada.

---

# 8. Critérios de Qualidade

Para um documento ser considerado **oficial** dentro desta hierarquia, ele deve:

- Ter um assunto claramente delimitado, sem sobreposição com outro documento já existente.
- Estar posicionado corretamente na hierarquia da Seção 2.
- Não conter informação duplicada de outro documento — apenas referências, quando aplicável.
- Registrar apenas decisões já tomadas e aprovadas, nunca propostas ou alternativas em aberto (exceto em seções explicitamente marcadas como "Pendências").
- Possuir versão, status e data de última atualização identificáveis.
- Ser referenciado a partir do documento imediatamente superior na hierarquia, quando aplicável.
```