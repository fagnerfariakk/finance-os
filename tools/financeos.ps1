<#
===============================================================================
 FinanceOS CLI
-------------------------------------------------------------------------------
 Version : 1.0.0
 Author  : FinanceOS
===============================================================================
#>

param(
    [Parameter(Position = 0)]
    [string]$Command = "help",

    [Parameter(Position = 1)]
    [string]$Arg1,

    [Parameter(Position = 2)]
    [string]$Arg2
)

$ErrorActionPreference = "Stop"

# -----------------------------------------------------------------------------
# Paths
# -----------------------------------------------------------------------------

$ScriptRoot  = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path $ScriptRoot -Parent

# -----------------------------------------------------------------------------
# Metadata
# -----------------------------------------------------------------------------

$CliVersion = "1.0.0"

# -----------------------------------------------------------------------------
# Colors
# -----------------------------------------------------------------------------

function Write-Title {

    param([string]$Text)

    Write-Host ""
    Write-Host "===================================================" -ForegroundColor Cyan
    Write-Host " FinanceOS CLI $CliVersion" -ForegroundColor Cyan
    Write-Host "===================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host $Text -ForegroundColor White
    Write-Host ""
}

function Write-Success {

    param([string]$Text)

    Write-Host "[ OK ] $Text" -ForegroundColor Green

}

function Write-WarningMsg {

    param([string]$Text)

    Write-Host "[WARN] $Text" -ForegroundColor Yellow

}

function Write-ErrorMsg {

    param([string]$Text)

    Write-Host "[FAIL] $Text" -ForegroundColor Red

}

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------

function Test-PathExists {

    param([string]$Path)

    return (Test-Path $Path)

}

function Test-Command {

    param([string]$Name)

    return [bool](Get-Command $Name -ErrorAction SilentlyContinue)

}

# -----------------------------------------------------------------------------
# Version
# -----------------------------------------------------------------------------

function Show-Version {

    Write-Host ""
    Write-Host "FinanceOS CLI $CliVersion"
    Write-Host ""

}

# -----------------------------------------------------------------------------
# Help
# -----------------------------------------------------------------------------

function Show-Help {

    Write-Title "Available Commands"

    @(
        "help"
        "version"
        "doctor"
        "validate"
    ) | ForEach-Object {

        Write-Host " - $_"

    }

    Write-Host ""

    Write-Host "Examples"

    Write-Host ""

    Write-Host ".\tools\financeos.ps1 doctor"
    Write-Host ".\tools\financeos.ps1 validate"
    Write-Host ".\tools\financeos.ps1 version"

}

# -----------------------------------------------------------------------------
# Doctor
# -----------------------------------------------------------------------------

function Invoke-Doctor {

    Write-Title "Environment Diagnostics"

    # -------------------------------------------------------------

    if (Test-Command git) {

        Write-Success "Git"

    }
    else {

        Write-ErrorMsg "Git"

    }

    # -------------------------------------------------------------

    if (Test-Command node) {

        Write-Success "Node.js"

    }
    else {

        Write-ErrorMsg "Node.js"

    }

    # -------------------------------------------------------------

    if (Test-Command pnpm) {

        Write-Success "pnpm"

    }
    else {

        Write-ErrorMsg "pnpm"

    }

    # -------------------------------------------------------------

    if (Test-Command docker) {

        Write-Success "Docker"

    }
    else {

        Write-WarningMsg "Docker"

    }

    # -------------------------------------------------------------

    if (Test-PathExists "$ProjectRoot\package.json") {

        Write-Success "package.json"

    }
    else {

        Write-ErrorMsg "package.json"

    }

    # -------------------------------------------------------------

    if (Test-PathExists "$ProjectRoot\pnpm-workspace.yaml") {

        Write-Success "pnpm-workspace.yaml"

    }
    else {

        Write-ErrorMsg "pnpm-workspace.yaml"

    }

    # -------------------------------------------------------------

    if (Test-PathExists "$ProjectRoot\turbo.json") {

        Write-Success "turbo.json"

    }
    else {

        Write-ErrorMsg "turbo.json"

    }

    # -------------------------------------------------------------

    if (Test-PathExists "$ProjectRoot\apps") {

        Write-Success "apps"

    }
    else {

        Write-ErrorMsg "apps"

    }

    # -------------------------------------------------------------

    if (Test-PathExists "$ProjectRoot\packages") {

        Write-Success "packages"

    }
    else {

        Write-ErrorMsg "packages"

    }

    # -------------------------------------------------------------

    if (Test-PathExists "$ProjectRoot\docs") {

        Write-Success "docs"

    }
    else {

        Write-ErrorMsg "docs"

    }

    Write-Host ""

    Write-Host "Doctor completed."

    Write-Host ""

}

# -----------------------------------------------------------------------------
# Validate
# -----------------------------------------------------------------------------

function Invoke-Validate {

    Write-Title "Project Validation"

    $Required = @(
    @{
        Name = "README.md"
        Required = $true
    },
    @{
        Name = "CLAUDE.md"
        Required = $false
    },
    @{
        Name = "PRODUCT_REQUIREMENTS.md"
        Required = $false
    },
    @{
        Name = "package.json"
        Required = $true
    },
    @{
        Name = "pnpm-workspace.yaml"
        Required = $true
    },
    @{
        Name = "turbo.json"
        Required = $true
    }
)

    foreach ($File in $Required) {

    $Path = Join-Path $ProjectRoot $File.Name

    if (Test-PathExists $Path) {

        Write-Success $File.Name

    }
    else {

        if ($File.Required) {

            Write-ErrorMsg $File.Name

        }
        else {

            Write-WarningMsg "$($File.Name) (optional)"

        }

    }

}

    Write-Host ""

    Write-Host "Validation completed."

    Write-Host ""

}

# -----------------------------------------------------------------------------
# Command Dispatcher
# -----------------------------------------------------------------------------

switch ($Command.ToLower()) {

    "help" {

        Show-Help

    }

    "version" {

        Show-Version

    }

    "doctor" {

        Invoke-Doctor

    }

    "validate" {

        Invoke-Validate

    }

    default {

        Write-Host ""

        Write-Host "Unknown command: $Command" -ForegroundColor Red

        Write-Host ""

        Show-Help

    }

}