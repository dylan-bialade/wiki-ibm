@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Build-Wiki.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Verify-JobI.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Fix-Markdown.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Verify-Contributions.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Build-Variantes.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Build-Comparaison.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Find-Gaps.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Assess-Document.ps1"
