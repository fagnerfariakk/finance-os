# FinanceOS — Ferramentas de Engenharia

**Documento:** docs/tools/TOOLS.md
**Versão:** 1.0
**Status:** Aprovado
**Epic:** EPIC-001
**Task:** TASK-001.6.02
**Última Atualização:** 2026-07-13

---

# 1. Objetivo

Este documento registra as ferramentas oficiais de engenharia do FinanceOS localizadas em `tools/`: o que cada uma faz, como executá-las e quando utilizá-las.

Não redefine arquitetura (ver ARCHITECTURE_BASELINE), critérios de qualidade (ver QUALITY_GATE) ou procedimento de configuração de ambiente (ver SETUP) — apenas referencia esses documentos quando aplicável.

Documenta exclusivamente ferramentas **oficiais e permanentes**. Scripts de uso pontual (ex.: bootstrap inicial de estrutura, executados uma única vez durante uma EPIC específica) não são registrados aqui — ver Seção 6.

---

# 2. Ferramentas Oficiais

| Ferramenta | Arquivo | Função |
|---|---|---|
| FinanceOS CLI | `tools/financeos.ps1` | Diagnóstico de ambiente local e verificação de arquivos de configuração básicos do projeto. |
| Validador de Documentação | `tools/validate-docs.ps1` | Valida a documentação oficial: existência de documentos obrigatórios, unicidade SSOT, links markdown e documentos órfãos. |

Ambas são scripts PowerShell, compatíveis com PowerShell 5.1, sem dependências externas além do próprio PowerShell.

---

# 3. Scripts PowerShell

## 3.1 `tools/financeos.ps1`

CLI de entrada única para comandos comuns de desenvolvimento.

**Uso:**
```powershell
.\tools\financeos.ps1 <comando>
```

**Comandos disponíveis:**

| Comando | Descrição |
|---|---|
| `help` | Lista os comandos disponíveis (comando padrão quando nenhum é informado). |
| `version` | Exibe a versão da CLI. |
| `doctor` | Diagnostica o ambiente local: presença de `git`, `node`, `pnpm`, `docker` (aviso, não falha, se ausente), `package.json`, `pnpm-workspace.yaml`, `turbo.json`, e das pastas `apps/`, `packages/`, `docs/`. |
| `validate` | Verifica a existência de arquivos de configuração do projeto na raiz: `README.md`, `package.json`, `pnpm-workspace.yaml` e `turbo.json` (obrigatórios); `CLAUDE.md` e `PRODUCT_REQUIREMENTS.md` (opcionais, geram aviso se ausentes). |

**Nota de desambiguação:** o comando `financeos.ps1 validate` verifica arquivos de **configuração do projeto** (root-level), e é distinto de `validate-docs.ps1`, que verifica a **documentação oficial**. Os dois não se sobrepõem.

## 3.2 `tools/validate-docs.ps1`

Validador da documentação oficial, conforme a política de Single Source of Truth definida em DOCUMENT_HIERARCHY.

**Uso:**
```powershell
.\tools\validate-docs.ps1
```

**Verificações realizadas:**
- Existência dos documentos oficiais obrigatórios (conforme índice em `docs/README.md`).
- Duplicidade de documentos oficiais — mais de um arquivo ativo com o mesmo nome de um documento SSOT.
- Links markdown relativos quebrados (resolução tentando caminho relativo à raiz do projeto e, em seguida, ao diretório do arquivo).
- Documentos órfãos — arquivos `.md` sem nenhuma referência de entrada a partir de outro documento oficial (exceto README.md e PROJECT_MASTER_PLAN.md, tratados como pontos de entrada válidos).

Ignora automaticamente: `node_modules/`, `docs/archives/`, `.git/`, `coverage/`, `dist/`, `.next/`.

**Exit codes:**

| Código | Significado |
|---|---|
| `0` | Sucesso — nenhuma falha ou aviso. |
| `1` | Sucesso com avisos (`WARNING`) — nenhuma falha. |
| `2` | Falha (`FAIL`) — pelo menos uma violação crítica encontrada. |

---

# 4. Quando Utilizar

| Situação | Ferramenta |
|---|---|
| Configurando o ambiente local pela primeira vez | `financeos.ps1 doctor` — ver também SETUP para o procedimento completo. |
| Verificação rápida de arquivos de configuração da raiz do projeto | `financeos.ps1 validate` |
| Antes de qualquer commit que crie, mova ou edite documentação oficial | `validate-docs.ps1` — atende ao critério "Documentação" do Quality Gate (ver QUALITY_GATE Seção 3). |
| Após aplicar uma TASK de reorganização documental (ex.: arquivamento, criação de novo documento oficial) | `validate-docs.ps1` |

---

# 5. Convenções

Convenções observadas e mantidas em todos os scripts de `tools/`:

- **Compatibilidade:** PowerShell 5.1, sem recursos exclusivos de versões posteriores.
- **Interrupção em erro:** `$ErrorActionPreference = "Stop"` no início do script.
- **Resolução de caminho:** a raiz do projeto é sempre resolvida relativamente à localização do próprio script (`$PSScriptRoot` ou `$MyInvocation.MyCommand.Path`), nunca fixada como caminho absoluto.
- **Saída padronizada:** mensagens de status usam `Write-Host` com prefixo textual e cor (`[OK]`/verde, `[WARN]`/`[WARNING]`/amarelo, `[FAIL]`/vermelho).
- **Localização única:** todo script oficial reside em `tools/`, na raiz do repositório.

---

# 6. Evolução

Novas ferramentas devem ser adicionadas a este documento quando se tornarem **oficiais e permanentes** — ou seja, destinadas a uso recorrente pela equipe, e não a uma execução pontual vinculada a uma TASK ou EPIC específica.

Scripts de uso pontual atualmente presentes em `tools/` (`bootstrap-ai-workflow.ps1`, `organize-docs.ps1`) foram utilizados para configuração inicial de estrutura durante EPIC-000/EPIC-001 e não são documentados aqui por esse motivo.

Evolução planejada da plataforma de engenharia como um todo é responsabilidade de **ROADMAP** — não antecipada neste documento.

---

# 7. Referências

Este documento não repete conteúdo já registrado em:

- **SETUP** — procedimento completo de configuração de ambiente local.
- **QUALITY_GATE** — critérios de aceite de entrega, incluindo o critério de Documentação.
- **DOCUMENT_HIERARCHY** — política de SSOT e hierarquia documental.
- **DOCUMENTATION_GUIDE** — ciclo de vida e convenções da documentação.

Fim do documento.