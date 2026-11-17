# Run-All.ps1 - Regenere tout le wiki. Fonctionne avec Windows PowerShell 5.1 et PowerShell 7 (Windows, Linux, macOS).
# Variables d'environnement utiles :
#   WIKI_EXPORT_DIR  dossier des exports ACS (*.LIB) ; sans lui, la conversion des exports est ignoree (le reste tourne)
#   WIKI_ALIAS_FILE  fichier PRIVE de correspondance des noms de bibliotheques (jamais dans le depot)
param([switch]$SansConversion)
$ErrorActionPreference = 'Continue'
$ps = (Get-Process -Id $PID).Path
$steps = @('Build-Wiki','Verify-JobI','Fix-Markdown','Verify-Contributions','Build-Variantes','Build-Comparaison','Find-Gaps','Assess-Document')
if ($SansConversion) { $steps = $steps | Where-Object { $_ -ne 'Build-Wiki' } }
foreach ($s in $steps) {
  Write-Output "=== $s"
  & $ps -NoProfile -File (Join-Path $PSScriptRoot "$s.ps1")
  if ($LASTEXITCODE -ne 0) { Write-Output "(code de sortie $LASTEXITCODE pour $s)" }
}