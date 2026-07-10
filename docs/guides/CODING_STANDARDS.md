```markdown
# FinanceOS — Coding Standards

**Documento:** docs/guides/CODING_STANDARDS.md
**Versão:** 1.0
**Status:** Aprovado
**Epic:** EPIC-000
**Task:** TASK-000.09
**Última Atualização:** 2026-07-09

---

# 1. Objetivo

Este documento define os **padrões oficiais de desenvolvimento** do FinanceOS.

Ele estabelece exclusivamente como o código deve ser escrito e organizado — não redefine arquitetura (ver ARCHITECTURE_BASELINE), não redefine processo de execução de TASK (ver AI_WORKFLOW), não redefine critérios de aceite de entrega (ver QUALITY_GATE) e não define regras de negócio (ver BUSINESS_RULES, quando existir).

---

# 2. Princípios Gerais

- **Legibilidade** — código deve ser compreendido sem esforço adicional por quem o lê.
- **Simplicidade** — preferir a solução mais direta que resolve o problema.
- **Coesão** — cada unidade de código (função, classe, módulo) deve ter uma responsabilidade clara e única.
- **Baixo acoplamento** — minimizar dependências desnecessárias entre unidades de código.
- **Reutilização** — antes de criar algo novo, verificar se algo equivalente já existe no projeto.
- **Código limpo** — evitar código morto, comentado ou redundante.
- **Type Safety First** — tipos explícitos e verificação estática são a primeira linha de defesa contra erros.

---

# 3. Organização do Código

- **Estrutura de pastas**: seguir a organização já estabelecida no monorepo (`apps/*`, `packages/*`); novas pastas devem seguir o mesmo padrão de agrupamento por responsabilidade já em uso.
- **Nomes de arquivos**: `kebab-case` para arquivos em geral (ex.: `user-service.ts`); arquivos de componentes React seguem `PascalCase` quando o nome do arquivo corresponde ao nome do componente exportado.
- **Nomes de classes**: `PascalCase` (ex.: `TransactionImporter`).
- **Nomes de funções**: `camelCase`, com verbo indicando a ação realizada (ex.: `calculateBalance`, `parseStatement`).
- **Nomes de interfaces**: `PascalCase`, sem prefixo `I` (ex.: `Transaction`, não `ITransaction`).
- **Nomes de tipos**: `PascalCase`, descritivos do valor que representam (ex.: `TransactionStatus`).
- **Constantes**: `UPPER_SNAKE_CASE` para constantes globais e valores fixos (ex.: `MAX_IMPORT_BATCH_SIZE`).
- **Enums**: `PascalCase` para o nome do enum, `PascalCase` para os membros (ex.: `enum TransactionType { Income, Expense, Transfer }`).

---

# 4. TypeScript

- Evitar `any`; quando o tipo não puder ser determinado, preferir `unknown` com verificação explícita.
- Preferir tipos explícitos em assinaturas de função (parâmetros e retorno), mesmo quando a inferência seria suficiente, para clareza de contrato.
- Usar `readonly` em propriedades e arrays que não devem ser mutados após a criação.
- Preferir `interface` para formas de objeto extensíveis e contratos públicos; `type` para uniões, interseções e aliases.
- Usar generics para abstrair comportamento reutilizável sem sacrificar type safety, evitando generics desnecessários que apenas adicionam complexidade sem ganho real de reuso.

---

# 5. Next.js

Padrões de uso dentro da arquitetura BFF já definida em ARCHITECTURE_BASELINE (não repetida aqui):

- **App Router**: rotas organizadas conforme a convenção de pastas já estabelecida no projeto.
- **Server Components**: padrão por default; usados sempre que não houver necessidade de interatividade no cliente.
- **Client Components**: usados apenas quando houver necessidade real de interatividade, estado local ou APIs de browser; marcados explicitamente e mantidos o menor possível.
- **Route Handlers**: usados para endpoints que precisam ser consumidos como API HTTP tradicional (ex.: por integrações externas).
- **Server Actions**: preferidas para mutações originadas diretamente da UI, evitando a criação de Route Handlers apenas para esse propósito.

---

# 6. Prisma

- **Organização dos models**: agrupados por domínio dentro do schema, seguindo a mesma separação conceitual usada na modelagem de dados (ex.: modelos de identidade agrupados entre si).
- **Nomenclatura**: nomes de model em `PascalCase` singular (ex.: `Transaction`, não `Transactions`); nomes de campos em `camelCase`.
- **Migrations**: cada migration deve refletir uma mudança de schema coesa e descrita de forma clara em seu nome; migrations não devem misturar mudanças não relacionadas.
- **Relacionamento entre entidades**: relações devem ser explícitas no schema, com nomes de campos de relação claros quanto à direção e ao papel (ex.: `owner`, `account`, em vez de nomes genéricos).

---

# 7. Tratamento de Erros

- Erros esperados (ex.: validação de entrada, regra de negócio violada) devem ser tratados explicitamente, nunca silenciados.
- Erros inesperados devem ser propagados de forma consistente, sem serem capturados e ignorados sem tratamento.
- Mensagens de erro devem ser claras o suficiente para diagnóstico, sem expor informação sensível (ver princípio de segurança em ARCHITECTURE_BASELINE/CLAUDE.md).
- Tratamento de erro deve ser consistente entre camadas equivalentes do sistema, evitando que cada módulo trate exceções de forma diferente sem justificativa.

---

# 8. Logging

- Logs devem ser estruturados, não texto livre não padronizado.
- Logs devem conter contexto suficiente para rastreabilidade (o que aconteceu, onde, e quando aplicável, para qual entidade), sem expor dados sensíveis.
- Níveis de log devem refletir a severidade real do evento (informativo, aviso, erro), evitando uso indiscriminado de um único nível.
- Este documento não escolhe uma biblioteca específica de logging — essa escolha, quando necessária, é uma decisão arquitetural a ser registrada em ARCHITECTURE_BASELINE.

---

# 9. Comentários

- Código deve ser autoexplicativo sempre que possível; nomes claros substituem a necessidade de comentário.
- Comentários são permitidos apenas para explicar **por que** uma decisão não óbvia foi tomada (ex.: workaround necessário, limitação externa), não **o que** o código faz.
- Comentários que apenas repetem o que o código já expressa devem ser evitados.
- Comentários desatualizados são considerados pior que a ausência de comentário e devem ser removidos ou corrigidos ao serem identificados.

---

# 10. Code Review

Critérios mínimos a serem verificados em revisão de código:

- O código resolve exatamente o que foi solicitado, sem escopo adicional não autorizado.
- O código segue os padrões definidos neste documento.
- Não há duplicação evitável de lógica já existente no projeto.
- Não há uso desnecessário de `any` ou supressão de checagem de tipos.
- Tratamento de erros está presente e consistente com o padrão do restante do código.
- Não há código morto, comentado ou temporário incluído na entrega.

---

# 11. Anti-padrões

Práticas proibidas no desenvolvimento do FinanceOS:

- Uso de `any` sem justificativa técnica clara.
- Código duplicado quando já existe implementação reutilizável equivalente.
- Funções ou componentes excessivamente grandes, acumulando múltiplas responsabilidades.
- Números mágicos no código, sem uso de constante nomeada.
- Comentários desatualizados ou que não refletem o comportamento real do código.
- Lógica duplicada entre módulos que deveria estar centralizada em uma única fonte.

---

# 12. Evolução

Este documento evoluirá junto com o projeto, incorporando novos padrões conforme novas camadas da arquitetura forem implementadas (ex.: padrões específicos de testes, padrões de validação de entrada). Este documento é a fonte oficial e única para convenções de código do FinanceOS.
```