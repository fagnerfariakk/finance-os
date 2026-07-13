<#
.SYNOPSIS
    FinanceOS Documentation Validator

.DESCRIPTION
    Valida a documentação oficial do projeto.

Validações:

- Arquivos duplicados
- README duplicados
- ROADMAP duplicados
- ARCHITECTURE duplicados
- Links quebrados
- Arquivos órfãos
- Referências inexistentes

#>

$ErrorActionPreference = "Stop"

$ProjectRoot = Resolve-Path "$PSScriptRoot\.."

Set-Location $ProjectRoot

$IgnoreDirectories = @(
    ".git",
    "node_modules",
    ".pnpm",
    ".next",
    "dist",
    "build",
    "coverage",
    "archives"
)

Write-Host ""
Write-Host "========================================="
Write-Host " FINANCEOS DOCUMENT VALIDATOR"
Write-Host "========================================="
Write-Host ""

#----------------------------------------------------
# Localiza markdowns
#----------------------------------------------------

$MarkdownFiles = Get-ChildItem `
    docs `
    -Recurse `
    -File `
    -Filter *.md |
Where-Object {

    $ignore = $false

    foreach($dir in $IgnoreDirectories)
    {
        if($_.FullName -match "\\$dir\\")
        {
            $ignore = $true
        }
    }

    -not $ignore
}

$Errors = 0
$Warnings = 0

#----------------------------------------------------
# DUPLICADOS
#----------------------------------------------------

Write-Host "Verificando nomes duplicados..."

$duplicates =
$MarkdownFiles |
Group-Object Name |
Where-Object Count -gt 1

if($duplicates.Count -eq 0)
{
    Write-Host "[OK] Nenhum documento duplicado."
}
else
{
    Write-Host "[FAIL] Documentos duplicados:"
    $Errors++

    foreach($dup in $duplicates)
    {
        Write-Host ""
        Write-Host $dup.Name -ForegroundColor Yellow

        $dup.Group |
        ForEach-Object {
            Write-Host "   $($_.FullName)"
        }
    }
}

Write-Host ""

#----------------------------------------------------
# README
#----------------------------------------------------

$readmes =
$MarkdownFiles |
Where-Object Name -ieq "README.md"

if($readmes.Count -gt 2)
{
    Write-Host "[WARNING] Muitos README encontrados ($($readmes.Count))"
    $Warnings++
}
else
{
    Write-Host "[OK] README"
}

#----------------------------------------------------
# ROADMAP
#----------------------------------------------------

$roadmaps =
$MarkdownFiles |
Where-Object Name -ieq "ROADMAP.md"

if($roadmaps.Count -gt 1)
{
    Write-Host "[FAIL] ROADMAP duplicado"
    $Errors++
}
else
{
    Write-Host "[OK] ROADMAP"
}

#----------------------------------------------------
# ARCHITECTURE
#----------------------------------------------------

$architecture =
$MarkdownFiles |
Where-Object Name -like "ARCHITECTURE*"

if($architecture.Count -gt 1)
{
    Write-Host "[WARNING] Múltiplos documentos ARCHITECTURE"
    $Warnings++
}
else
{
    Write-Host "[OK] ARCHITECTURE"
}

Write-Host ""

#----------------------------------------------------
# Links internos
#----------------------------------------------------

Write-Host "Validando links..."

$linkRegex = '\[[^\]]+\]\(([^)]+)\)'

foreach($file in $MarkdownFiles)
{
    $content = Get-Content $file.FullName

    foreach($line in $content)
    {
        $matches = [regex]::Matches($line,$linkRegex)

        foreach($m in $matches)
        {
            $target = $m.Groups[1].Value

            if($target.StartsWith("http"))
            {
                continue
            }

            if($target.StartsWith("#"))
            {
                continue
            }

            $resolved =
                Join-Path $file.DirectoryName $target

            if(!(Test-Path $resolved))
            {
                Write-Host "[BROKEN] $($file.Name)"
                Write-Host "         -> $target"

                $Errors++
            }
        }
    }
}

Write-Host ""

#----------------------------------------------------
# Arquivos órfãos
#----------------------------------------------------

Write-Host "Verificando arquivos órfãos..."

$Referenced = @()

foreach($file in $MarkdownFiles)
{
    $content = Get-Content $file.FullName

    foreach($line in $content)
    {
        $matches=[regex]::Matches($line,$linkRegex)

        foreach($m in $matches)
        {
            $target=$m.Groups[1].Value

            if($target.StartsWith("http")) { continue }

            if($target.StartsWith("#")) { continue }

            $resolved =
                Resolve-Path `
                    (Join-Path $file.DirectoryName $target) `
                    -ErrorAction SilentlyContinue

            if($resolved)
            {
                $Referenced += $resolved.Path
            }
        }
    }
}

$Referenced = $Referenced | Sort-Object -Unique

$Orphans =
$MarkdownFiles |
Where-Object {

    $_.Name -ne "README.md" `
    -and
    $_.FullName -notin $Referenced
}

if($Orphans.Count -eq 0)
{
    Write-Host "[OK] Nenhum órfão."
}
else
{
    Write-Host "[WARNING] Arquivos sem referência:"
    $Warnings++

    $Orphans |
    ForEach-Object {

        Write-Host "   $($_.FullName)"
    }
}

Write-Host ""
Write-Host "========================================="

if($Errors -eq 0)
{
    Write-Host "STATUS : PASS" -ForegroundColor Green
}
else
{
    Write-Host "STATUS : FAIL" -ForegroundColor Red
}

Write-Host ""
Write-Host "Erros    : $Errors"
Write-Host "Warnings : $Warnings"

Write-Host "========================================="