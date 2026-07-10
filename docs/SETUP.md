```markdown
# FinanceOS — Setup

**Documento:** docs/SETUP.md
**Versão:** 1.0
**Status:** Aprovado
**Epic:** EPIC-000
**Task:** TASK-000.12
**Última Atualização:** 2026-07-09

---

# 1. Objetivo

Este documento contém o **procedimento oficial para preparação do ambiente de desenvolvimento** do FinanceOS, a ser seguido por qualquer desenvolvedor, humano ou IA, antes de iniciar qualquer trabalho no projeto.

---

# 2. Pré-requisitos

- Git
- Node.js
- PNPM
- Docker Desktop
- VS Code (opcional)

As versões oficiais adotadas para cada tecnologia estão registradas em ARCHITECTURE_BASELINE e não são repetidas aqui.

---

# 3. Clonando o Projeto

```bash
git clone https://github.com/fagnerfariakk/finance-os.git
cd finance-os
pnpm install
```

---

# 4. Configuração de Ambiente

O projeto utiliza arquivos `.env` para variáveis de configuração local.

- **`packages/database/.env`**: arquivo de ambiente próprio do pacote de persistência. Necessário porque o projeto utiliza `prisma.config.ts`, que não carrega `.env` automaticamente.
- **`DATABASE_URL`**: variável obrigatória em `packages/database/.env`, contendo a string de conexão com o PostgreSQL local.

Nenhuma credencial real deve ser versionada ou exposta em documentação — os valores devem ser definidos localmente por cada desenvolvedor, com base no serviço provisionado via Docker (ver Seção 5).

---

# 5. Docker

```bash
docker compose up -d
docker compose down
docker compose down -v
```

- `docker compose up -d`: sobe os serviços de infraestrutura local (PostgreSQL e Redis) em background. Use ao iniciar o ambiente de desenvolvimento.
- `docker compose down`: encerra os serviços, preservando os dados armazenados. Use ao finalizar o trabalho sem precisar resetar o banco.
- `docker compose down -v`: encerra os serviços e remove os volumes associados, apagando os dados persistidos. Use quando for necessário resetar completamente o banco local.

---

# 6. Banco de Dados

```bash
pnpm db:migrate
pnpm db:generate
```

- `pnpm db:migrate`: aplica as migrations do Prisma ao banco local, atualizando o schema físico. Use após clonar o projeto ou após alterações no schema.
- `pnpm db:generate`: gera o Prisma Client atualizado com base no schema atual. Use sempre que o schema for alterado, antes de rodar a aplicação.

---

# 7. Desenvolvimento

```bash
pnpm dev
pnpm build
pnpm lint
```

- `pnpm dev`: inicia o ambiente de desenvolvimento local.
- `pnpm build`: executa o build do projeto.
- `pnpm lint`: executa a verificação de lint em todo o projeto.

---

# 8. Estrutura do Projeto

Visão resumida da organização do repositório:

```
finance-os/
├── apps/       # Aplicações executáveis do projeto
├── packages/   # Pacotes de domínio e utilitários compartilhados
├── docs/       # Documentação oficial do projeto
└── tools/      # Ferramentas e scripts auxiliares
```

Detalhamento arquitetural completo de cada camada está registrado em ARCHITECTURE_BASELINE e não é repetido aqui.

---

# 9. Solução de Problemas

Problemas comuns durante o setup:

- **Docker não iniciado**: verifique se o Docker Desktop está em execução antes de rodar `docker compose up -d`.
- **Porta 5432 ocupada**: outro processo já está utilizando a porta padrão do PostgreSQL; encerre o processo conflitante ou ajuste a configuração local antes de subir os containers.
- **`DATABASE_URL` ausente**: confirme que o arquivo `packages/database/.env` existe e contém a variável corretamente definida.
- **Prisma Client desatualizado**: execute `pnpm db:generate` após qualquer alteração no schema.
- **Dependências não instaladas**: execute `pnpm install` na raiz do projeto antes de qualquer outro comando.

---

# 10. Próximos Passos

Após concluir o setup, antes de iniciar qualquer TASK, consulte:

- PROJECT_MASTER_PLAN
- ROADMAP
- AI_CONTEXT
```