# FinanceOS Documentation

**Document:** 11_IMPORTERS.md
**Version:** 2.0

# Objective
Standardize financial data imports.

## Supported Formats
- OFX
- CSV
- XLSX
- PDF (future)

## Pipeline
Parser -> Normalizer -> Validator -> Duplicate Detector -> Import Service -> Audit Log

## Rules
- Preserve original file metadata.
- Never overwrite transactions automatically.
- All imports must be auditable.
- AI may assist classification only after import.
