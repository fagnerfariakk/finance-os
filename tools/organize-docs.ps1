$ProjectRoot = Split-Path $PSScriptRoot -Parent
$Docs = Join-Path $ProjectRoot "docs"

# Criar diretórios

$folders = @(
    "architecture",
    "api",
    "database",
    "guides",
    "roadmap",
    "adr",
    "epics",
    "tasks"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Force -Path "$Docs\$folder" | Out-Null
}

# Architecture

Move-Item "$Docs\01_ARCHITECTURE.md" "$Docs\architecture\ARCHITECTURE.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\02_TECH_STACK.md" "$Docs\architecture\TECH_STACK.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\18_DECISIONS.md" "$Docs\architecture\DECISIONS.md" -Force -ErrorAction SilentlyContinue

# API

Move-Item "$Docs\04_API.md" "$Docs\api\API.md" -Force -ErrorAction SilentlyContinue

# Database

Move-Item "$Docs\03_DATABASE.md" "$Docs\database\DATABASE.md" -Force -ErrorAction SilentlyContinue

# Guides

Move-Item "$Docs\05_BUSINESS_RULES.md" "$Docs\guides\BUSINESS_RULES.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\06_SECURITY.md" "$Docs\guides\SECURITY.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\07_CODING_STANDARDS.md" "$Docs\guides\CODING_STANDARDS.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\08_TESTING.md" "$Docs\guides\TESTING.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\09_FRONTEND.md" "$Docs\guides\FRONTEND.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\10_BACKEND.md" "$Docs\guides\BACKEND.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\11_IMPORTERS.md" "$Docs\guides\IMPORTERS.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\12_AI.md" "$Docs\guides\AI.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\13_INVESTMENTS.md" "$Docs\guides\INVESTMENTS.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\14_DASHBOARDS.md" "$Docs\guides\DASHBOARDS.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\15_OPEN_FINANCE.md" "$Docs\guides\OPEN_FINANCE.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\16_DEPLOYMENT.md" "$Docs\guides\DEPLOYMENT.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\17_CONTRIBUTING.md" "$Docs\guides\CONTRIBUTING.md" -Force -ErrorAction SilentlyContinue

# Roadmap

Move-Item "$Docs\19_ROADMAP.md" "$Docs\roadmap\ROADMAP.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\20_PROJECT_STATUS.md" "$Docs\roadmap\PROJECT_STATUS.md" -Force -ErrorAction SilentlyContinue
Move-Item "$Docs\CHANGELOG.md" "$Docs\roadmap\CHANGELOG.md" -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "====================================="
Write-Host " FinanceOS documentation organized"
Write-Host "====================================="
Write-Host ""