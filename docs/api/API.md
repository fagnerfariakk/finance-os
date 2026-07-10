```markdown
# FinanceOS — API Strategy

**Documento:** docs/api/API.md
**Versão:** 1.0
**Status:** Aprovado
**Epic:** EPIC-000
**Task:** TASK-000.11
**Última Atualização:** 2026-07-09

---

# 1. Objetivo

Este documento representa a **referência oficial da estratégia de APIs** do FinanceOS.

Ele documenta como a comunicação entre frontend, backend e integrações externas deve ser estruturada — princípios, convenções e categorias de comunicação — sem definir endpoints específicos, sem repetir decisões já registradas em ARCHITECTURE_BASELINE, DATABASE ou CODING_STANDARDS.

---

# 2. Princípios

- **API First** — contratos de comunicação são definidos e documentados antes da implementação, não descobertos a posteriori pelo consumo do código.
- **Consistência** — toda comunicação segue os mesmos padrões de estrutura, nomenclatura e resposta, independentemente do módulo.
- **Segurança** — nenhuma comunicação é implementada sem considerar autenticação, autorização e validação de entrada.
- **Versionamento** — mudanças incompatíveis em contratos são tratadas de forma explícita, nunca silenciosa.
- **Idempotência** — operações que podem ser repetidas (ex.: reenvio de requisição por falha de rede) devem ser seguras de executar mais de uma vez quando a natureza da operação permitir.
- **Contratos explícitos** — formato de entrada e saída de cada comunicação é definido de forma clara, não implícito no comportamento do código.

---

# 3. Arquitetura de Comunicação

Em alto nível, a comunicação no FinanceOS flui do Frontend através da camada de Backend for Frontend (implementada via Next.js, conforme já definido em ARCHITECTURE_BASELINE), que se comunica com a camada de persistência (Banco de Dados, via Prisma, conforme já definido em DATABASE).

Route Handlers e Server Actions são os mecanismos de comunicação dentro dessa camada BFF. Detalhes de camadas, posicionamento arquitetural e tecnologia associada não são repetidos aqui — ver ARCHITECTURE_BASELINE.

---

# 4. Tipos de Comunicação

- **Server Actions** — utilizadas para mutações originadas diretamente da interação do usuário na interface, quando a comunicação ocorre inteiramente dentro do ciclo de vida da aplicação Next.js.
- **Route Handlers** — utilizados quando a comunicação precisa ser exposta como endpoint HTTP tradicional, seja para consumo por múltiplos clientes, seja para integração com sistemas externos.
- **Integrações externas** — comunicação com serviços de terceiros (ex.: provedores de Open Finance, serviços de importação), tratada como categoria própria, sujeita a princípios adicionais de resiliência e isolamento de falha externa.

A escolha entre esses tipos, em cada caso concreto, é decidida no momento da implementação da funcionalidade correspondente, respeitando os princípios desta seção.

---

# 5. Convenções

- **Nomenclatura de endpoints**: substantivos no plural, representando recursos, não ações (ex.: recurso identificado pelo nome da entidade, não pelo verbo da operação).
- **Estrutura de URLs**: hierárquica e previsível, refletindo a relação entre recursos quando aplicável.
- **Verbos HTTP**: usados conforme semântica padrão — leitura, criação, atualização e remoção mapeadas para os verbos correspondentes, sem sobrecarregar um único verbo com múltiplas semânticas.
- **Payloads**: estruturados de forma consistente entre endpoints, com nomenclatura de campos alinhada às convenções já definidas em CODING_STANDARDS.
- **Códigos de resposta**: usados de forma semântica, refletindo o resultado real da operação (sucesso, erro de validação, erro de autenticação, erro de autorização, erro interno), sem uso genérico indiscriminado de um único código para múltiplos cenários.
- **Paginação**: aplicada a toda listagem que possa crescer de forma não limitada, com contrato consistente entre diferentes recursos.
- **Filtros**: expressos de forma previsível e documentada no contrato de cada recurso, quando existirem.
- **Ordenação**: expressa de forma explícita e consistente entre recursos que suportam múltiplos critérios de ordenação.

Nenhum endpoint real é definido nesta seção — apenas o padrão que endpoints futuros deverão seguir.

---

# 6. Autenticação

A comunicação de API do FinanceOS deve considerar, como princípio geral:

- Toda comunicação que exponha ou modifique dados sensíveis exige autenticação.
- A identidade do solicitante deve ser verificável de forma consistente entre todos os pontos de comunicação.
- Autorização é tratada como camada distinta da autenticação — estar autenticado não implica estar autorizado para toda operação.

Este documento não escolhe biblioteca, mecanismo ou implementação de autenticação — essa é uma decisão arquitetural a ser registrada separadamente quando tomada.

---

# 7. Tratamento de Erros

- **Erros de validação**: devem ser retornados de forma clara, indicando qual parte da entrada é inválida, sem expor detalhes internos de implementação.
- **Erros de autenticação**: devem indicar de forma inequívoca que a identidade do solicitante não pôde ser verificada, sem revelar informação que auxilie tentativas de acesso indevido.
- **Erros de autorização**: devem indicar que a operação não é permitida para o solicitante identificado, distinguindo-se claramente de erro de autenticação.
- **Erros internos**: nunca devem expor detalhes de implementação, stack traces ou informação sensível ao consumidor da API.
- **Respostas consistentes**: toda resposta de erro segue uma estrutura única e previsível em todo o projeto, independentemente do tipo de erro ou do endpoint envolvido.

---

# 8. Versionamento

Mudanças incompatíveis em contratos de comunicação devem ser tratadas por meio de uma estratégia de versionamento explícita, garantindo que consumidores existentes não sejam quebrados sem transição planejada.

A forma concreta de versionamento (ex.: por URL, por cabeçalho, ou outra abordagem) é uma decisão a ser tomada e registrada quando a necessidade de versionamento se tornar real — este documento não escolhe a tecnologia ou mecanismo específico.

---

# 9. Observabilidade

- **Logs**: toda comunicação relevante deve gerar registro estruturado, suficiente para diagnóstico posterior.
- **Rastreabilidade**: deve ser possível acompanhar o caminho de uma requisição através das camadas envolvidas.
- **Correlation ID**: cada requisição deve poder ser identificada de forma única, permitindo correlacionar logs e eventos gerados por ela em diferentes pontos do sistema.
- **Auditoria**: operações que alteram dados sensíveis ou financeiros devem ser auditáveis, alinhado ao princípio de auditabilidade já registrado em DATABASE.

Nenhuma ferramenta específica de observabilidade é escolhida neste documento.

---

# 10. Futuras Expansões

Áreas de comunicação previstas para expansão futura, ainda não implementadas:

- Open Finance
- Importadores
- APIs públicas
- Webhooks
- Integrações bancárias

Nenhum detalhe de implementação para essas áreas é definido neste documento — serão detalhadas quando efetivamente implementadas.
```