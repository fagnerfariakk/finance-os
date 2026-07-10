<#
.SYNOPSIS
Bootstrap da documentação e workflow de IA do FinanceOS.

.DESCRIPTION
Cria a estrutura de diretórios e arquivos da EPIC-001
(AI Engineering Workflow), preservando arquivos já existentes.

.AUTHOR
FinanceOS Engineering Team
#>

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host " FinanceOS - AI Workflow Bootstrap" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

$Directories = @(
    "docs",
    "docs\architecture",
    "docs\architecture\ADR",
    "docs\guides",
    ".github",
    ".github\ISSUE_TEMPLATE"
)

foreach ($dir in $Directories) {

    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
        Write-Host "[CREATE] Directory $dir" -ForegroundColor Green
    }
    else {
        Write-Host "[ OK ] Directory $dir"
    }

}

$Files = @(

    "docs\TEAM.md",

    "docs\DEVELOPMENT_WORKFLOW.md",

    "docs\GIT_WORKFLOW.md",

    "docs\QUALITY_GATE.md",

    "docs\AI_PROMPTS.md",

    "docs\SETUP.md",

    "docs\architecture\ADR\0001-ai-workflow.md",

    ".github\PULL_REQUEST_TEMPLATE.md",

    ".github\ISSUE_TEMPLATE\feature.yml",

    ".github\ISSUE_TEMPLATE\bug.yml",

    ".github\ISSUE_TEMPLATE\task.yml"
)

foreach ($file in $Files) {

    if (-not (Test-Path $file)) {

        New-Item -ItemType File -Path $file | Out-Null

        Write-Host "[CREATE] $file" -ForegroundColor Green

    }
    else {

        Write-Host "[ OK ] $file"

    }

}

Write-Host ""
Write-Host "Bootstrap concluído." -ForegroundColor Green
Write-Host ""