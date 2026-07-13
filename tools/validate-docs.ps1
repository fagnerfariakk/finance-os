#Requires -Version 5.1
<#
.SYNOPSIS
    FinanceOS Documentation Validator (ferramenta oficial)

.DESCRIPTION
    Valida a documentação oficial do FinanceOS, conforme a política de
    Single Source of Truth definida em DOCUMENT_HIERARCHY e DOCUMENTATION_GUIDE.

    Verificações realizadas:
    1. Existência dos documentos oficiais obrigatórios.
    2. Duplicidade de documentos oficiais (mesmo nome em mais de um caminho ativo).
    3. Links markdown relativos quebrados (resolução root-relative e file-relative).
    4. Documentos órfãos (sem nenhuma referência a partir de outro documento oficial).
    5. Existência de um único documento SSOT por assunto oficial.

    Diretórios ignorados automaticamente: node_modules/, docs/archives/, .git/,
    coverage/, dist/, .next/

.NOTES
    Compatível com Windows PowerShell 5.1.
    Exit Code 0 = sucesso | 1 = warnings | 2 = erros
#>

$ErrorActionPreference = "Stop"

$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Set-Location $ProjectRoot

# ---------------------------------------------------------------------------
# Configuração
# ---------------------------------------------------------------------------

# Nomes de diretório ignorados em qualquer nível da árvore.
$IgnoreLeafNames = @(".git", "node_modules", "coverage", "dist", ".next")

# Prefixos de caminho (relativos à raiz do projeto) ignorados por completo.
$IgnorePathPrefixes = @("docs\archives", "docs/archives")

# Documentos oficiais obrigatórios, conforme docs/README.md (índice oficial)
# e README.md (ponto de entrada raiz). Caminho relativo à raiz do projeto.
$RequiredDocuments = @(
    "README.md",
    "docs/PROJECT_MASTER_PLAN.md",
    "docs/architecture/ARCHITECTURE_BASELINE.md",
    "docs/architecture/DOCUMENT_HIERARCHY.md",
    "docs/ROADMAP.md",
    "docs/database/DATABASE.md",
    "docs/api/API.md",
    "docs/guides/CODING_STANDARDS.md",
    "docs/AI_CONTEXT.md",
    "docs/AI_TEAM.md",
    "docs/AI_WORKFLOW.md",
    "docs/QUALITY_GATE.md",
    "docs/SETUP.md"
)

# Subconjunto de documentos com exigência estrita de unicidade (um único
# arquivo com esse nome em toda a arvore ativa). README.md e outros
# READMEs de pacote são legitimamente multiplos em um monorepo e por
# isso NAO participam desta checagem — evita falso positivo.
$SsotDocuments = $RequiredDocuments | Where-Object { (Split-Path $_ -Leaf) -ne "README.md" }

# Nomes de arquivo considerados pontos de entrada válidos — nunca reportados
# como órfãos, mesmo sem referência de entrada (README e PROJECT_MASTER_PLAN).
$ValidEntryPointNames = @("README.md", "PROJECT_MASTER_PLAN.md")

$OkCount = 0
$WarningCount = 0
$FailCount = 0

function Write-Result {
    param(
        [ValidateSet("OK", "WARNING", "FAIL")] [string]$Level,
        [string]$Message
    )

    switch ($Level) {
        "OK"      { Write-Host "[OK]      $Message" -ForegroundColor Green;  $script:OkCount++ }
        "WARNING" { Write-Host "[WARNING] $Message" -ForegroundColor Yellow; $script:WarningCount++ }
        "FAIL"    { Write-Host "[FAIL]    $Message" -ForegroundColor Red;    $script:FailCount++ }
    }
}

function Test-IsIgnored {
    param([string]$RelativePath)

    $normalized = $RelativePath.Replace("/", "\")

    foreach ($leaf in $IgnoreLeafNames) {
        if ($normalized -match "(^|\\)$([regex]::Escape($leaf))(\\|$)") {
            return $true
        }
    }

    foreach ($prefix in $IgnorePathPrefixes) {
        $normalizedPrefix = $prefix.Replace("/", "\")
        if ($normalized -like "$normalizedPrefix*") {
            return $true
        }
    }

    return $false
}

Write-Host ""
Write-Host "========================================="
Write-Host " FINANCEOS DOCUMENT VALIDATOR"
Write-Host "========================================="
Write-Host ""

# ---------------------------------------------------------------------------
# Coleta de todos os arquivos .md relevantes (repositório inteiro, exceto ignorados)
# ---------------------------------------------------------------------------

$AllMarkdownFiles = Get-ChildItem -Path $ProjectRoot -Recurse -File -Filter "*.md" |
    ForEach-Object {
        $relative = $_.FullName.Substring($ProjectRoot.Length).TrimStart("\", "/")
        [PSCustomObject]@{
            FullName     = $_.FullName
            RelativePath = $relative
            DirectoryName = $_.DirectoryName
            Name         = $_.Name
        }
    } |
    Where-Object { -not (Test-IsIgnored $_.RelativePath) }

# ---------------------------------------------------------------------------
# 1. Documentos obrigatórios
# ---------------------------------------------------------------------------

Write-Host "-- Documentos obrigatórios --"

foreach ($doc in $RequiredDocuments) {
    $fullPath = Join-Path $ProjectRoot $doc.Replace("/", "\")
    if (Test-Path $fullPath) {
        Write-Result -Level "OK" -Message $doc
    }
    else {
        Write-Result -Level "FAIL" -Message "Documento obrigatorio ausente: $doc"
    }
}

Write-Host ""

# ---------------------------------------------------------------------------
# 2 e 5. Duplicidade / SSOT único por documento oficial
# ---------------------------------------------------------------------------

Write-Host "-- Duplicidade de documentos oficiais (SSOT) --"

foreach ($doc in $SsotDocuments) {
    $docName = Split-Path $doc -Leaf

    $matches = $AllMarkdownFiles | Where-Object { $_.Name -ieq $docName }

    if ($matches.Count -le 1) {
        Write-Result -Level "OK" -Message "$docName (documento unico)"
    }
    else {
        Write-Result -Level "FAIL" -Message "$docName encontrado em mais de um caminho ativo:"
        foreach ($m in $matches) {
            Write-Host "             -> $($m.RelativePath)"
        }
    }
}

Write-Host ""

# ---------------------------------------------------------------------------
# 3. Links markdown relativos
# ---------------------------------------------------------------------------
# Convenção observada no repositório: links são escritos como caminhos
# relativos à RAIZ do projeto (ex.: em docs/README.md, o link para
# PROJECT_MASTER_PLAN.md é escrito como "docs/PROJECT_MASTER_PLAN.md",
# mesmo o arquivo estando dentro de docs/). Para evitar falsos positivos,
# cada link é resolvido em duas tentativas: relativo à raiz do projeto
# primeiro, e relativo ao diretório do arquivo em seguida.

Write-Host "-- Links markdown --"

$LinkRegex = '\[[^\]]+\]\(([^)]+)\)'
$ReferencedFullPaths = New-Object System.Collections.Generic.HashSet[string]
$BrokenLinksFound = $false

foreach ($file in $AllMarkdownFiles) {
    $lines = Get-Content -Path $file.FullName -ErrorAction SilentlyContinue
    if (-not $lines) { continue }

    foreach ($line in $lines) {
        $linkMatches = [regex]::Matches($line, $LinkRegex)

        foreach ($m in $linkMatches) {
            $target = $m.Groups[1].Value.Trim()

            if ($target.StartsWith("http://") -or $target.StartsWith("https://")) { continue }
            if ($target.StartsWith("mailto:")) { continue }
            if ($target.StartsWith("#")) { continue }
            if ([string]::IsNullOrWhiteSpace($target)) { continue }

            # Remove âncora final, se houver (ex.: arquivo.md#secao)
            $targetPath = $target.Split("#")[0]
            if ([string]::IsNullOrWhiteSpace($targetPath)) { continue }

            $resolvedRoot = Join-Path $ProjectRoot $targetPath.Replace("/", "\")
            $resolvedFile = Join-Path $file.DirectoryName $targetPath.Replace("/", "\")

            $resolved = $null

            if (Test-Path $resolvedRoot) {
                $resolved = (Resolve-Path $resolvedRoot).Path
            }
            elseif (Test-Path $resolvedFile) {
                $resolved = (Resolve-Path $resolvedFile).Path
            }

            if ($null -eq $resolved) {
                Write-Result -Level "FAIL" -Message "Link quebrado em $($file.RelativePath) -> $target"
                $BrokenLinksFound = $true
            }
            else {
                [void]$ReferencedFullPaths.Add($resolved)
            }
        }
    }
}

if (-not $BrokenLinksFound) {
    Write-Result -Level "OK" -Message "Nenhum link quebrado encontrado."
}

Write-Host ""

# ---------------------------------------------------------------------------
# 4. Documentos órfãos
# ---------------------------------------------------------------------------

Write-Host "-- Documentos órfãos --"

$Orphans = $AllMarkdownFiles | Where-Object {
    ($ValidEntryPointNames -notcontains $_.Name) -and
    (-not $ReferencedFullPaths.Contains((Resolve-Path $_.FullName).Path))
}

if (-not $Orphans -or $Orphans.Count -eq 0) {
    Write-Result -Level "OK" -Message "Nenhum documento orfao encontrado."
}
else {
    foreach ($orphan in $Orphans) {
        Write-Result -Level "WARNING" -Message "Documento sem referencia de entrada: $($orphan.RelativePath)"
    }
}

Write-Host ""

# ---------------------------------------------------------------------------
# Resumo final
# ---------------------------------------------------------------------------

Write-Host "========================================="
Write-Host " RESUMO"
Write-Host "========================================="
Write-Host "OK       : $OkCount"
Write-Host "Warnings : $WarningCount"
Write-Host "Falhas   : $FailCount"
Write-Host ""

if ($FailCount -gt 0) {
    Write-Host "STATUS : FAIL" -ForegroundColor Red
    Write-Host "========================================="
    exit 2
}
elseif ($WarningCount -gt 0) {
    Write-Host "STATUS : PASS COM WARNINGS" -ForegroundColor Yellow
    Write-Host "========================================="
    exit 1
}
else {
    Write-Host "STATUS : PASS" -ForegroundColor Green
    Write-Host "========================================="
    exit 0
}