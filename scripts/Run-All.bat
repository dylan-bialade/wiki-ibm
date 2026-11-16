@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Build-Wiki.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Verify-JobI.ps1"
