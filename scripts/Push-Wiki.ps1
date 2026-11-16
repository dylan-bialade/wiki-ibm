# Push-Wiki.ps1 - Configure le depot distant et pousse le wiki, avec confirmation.
# L'authentification est geree par Git Credential Manager (fenetre de connexion GitHub) :
# AUCUN token ni mot de passe n'est lu, stocke ou ecrit par ce script.
param(
  [string]$RemoteUrl = "https://github.com/dylan-bialade/wiki-ibm.git",   # depot par defaut (modifiable via -RemoteUrl)
  [string]$Branch = "main",
  [switch]$Yes                             # saute la confirmation (a eviter)
)
$ErrorActionPreference = "Continue"   # git ecrit sa progression sur stderr ; on se fie a $LASTEXITCODE
$env:Path = [Environment]::GetEnvironmentVariable("Path","Machine")+";"+[Environment]::GetEnvironmentVariable("Path","User")
Set-Location (Split-Path $PSScriptRoot -Parent)

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "Git est introuvable. Installez Git for Windows." }
if (-not (Test-Path .git)) { git init -q }

# URL : refuse toute URL contenant des identifiants (https://user:token@...)
$current = $null
if (@(git remote) -contains "origin") { $current = git remote get-url origin }
if (-not $RemoteUrl) { $RemoteUrl = $current }
if (-not $RemoteUrl) { $RemoteUrl = Read-Host "URL du depot (https://github.com/<vous>/<depot>.git)" }
if ($RemoteUrl -notmatch '^(https://[^/@\s]+/\S+|git@[^:\s]+:\S+)$') { throw "URL invalide ou contenant des identifiants. Utilisez une URL sans token." }
if ($current) { git remote set-url origin $RemoteUrl } else { git remote add origin $RemoteUrl }

# Commit des changements en attente
git add -A
if (git status --porcelain) { git commit -q -m "Mise a jour du wiki $(Get-Date -Format 'yyyy-MM-dd HH:mm')" }
git branch -M $Branch

Write-Host ""
Write-Host "Depot distant : $RemoteUrl"
Write-Host "Branche       : $Branch"
Write-Host "Commits a pousser :"; git log --oneline -5
Write-Host ""
if (-not $Yes) {
  $a = Read-Host "Pousser maintenant ? Cela publie le contenu du wiki (o/N)"
  if ($a -notmatch '^[oOyY]') { Write-Host "Annule. Rien n'a ete publie."; exit 0 }
}
git push -u origin $Branch
if ($LASTEXITCODE -eq 0) { Write-Host "Push termine." } else { Write-Host "Echec du push (code $LASTEXITCODE). Verifiez l'URL et votre connexion GitHub." }
