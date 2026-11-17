# Report-ToWiki.ps1 - Remonte automatiquement une information au wiki (docs/apports/), puis lance l'evaluation de pertinence.
# Utilise par l'assistant (CLAUDE.md section 8) quand il detecte un manque, une erreur ou une information verifiee.
# Compatible Windows PowerShell 5.1 et PowerShell 7. ASCII uniquement. Aucun jeton, aucun mot de passe.
# Mode Git : env WIKI_REPORT_MODE = branche (defaut : branche apport/<slug>, push, PR si gh existe) | main (proprietaire : commit + push sur main) | aucun (fichier seul).
param(
  [Parameter(Mandatory = $true)][string]$Titre,
  [Parameter(Mandatory = $true)][string]$Contenu,
  [string]$Fiche = '03-rpg-par-version',
  [ValidateSet('manque', 'erreur', 'verification', 'exemple')][string]$Type = 'manque',
  [string]$Source = '',
  [ValidateSet('verifie', 'non verifie', 'hypothese')][string]$Statut = 'non verifie',
  [string]$Root,
  [ValidateSet('', 'branche', 'main', 'aucun')][string]$Mode = ''
)
$ErrorActionPreference = 'Stop'
if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }
. (Join-Path $PSScriptRoot 'Contrib-Common.ps1')
if (-not $Mode) { $Mode = $(if ($env:WIKI_REPORT_MODE) { $env:WIKI_REPORT_MODE } else { 'branche' }) }
function Stop-Report([string]$m) { Write-Output ("REFUSE : " + $m); exit 2 }

if ($Titre.Trim().Length -lt 5 -or $Contenu.Trim().Length -lt 40) { Stop-Report 'titre ou contenu trop court' }
if ($Statut -eq 'verifie' -and -not $Source) { Stop-Report 'un statut verifie exige une source (URL ou chemin)' }
$all = $Titre + "`n" + $Contenu + "`n" + $Source
if ($all -match $script:SecretHard) { Stop-Report 'secret (cle ou jeton) detecte' }
if ($all -match $script:SecretSoft) { Stop-Report 'mot de passe ou jeton possible detecte' }
# Noms reels de bibliotheques : refuses (fichier de correspondance prive, jamais dans le depot)
$aliasFile = $(if ($env:WIKI_ALIAS_FILE) { $env:WIKI_ALIAS_FILE } else { Join-Path (Split-Path $Root -Parent) 'lib-alias.private.json' })
if (Test-Path $aliasFile) {
  foreach ($p in (Get-Content $aliasFile -Raw -Encoding UTF8 | ConvertFrom-Json).PSObject.Properties) {
    if ($p.Name.Length -ge 3 -and $all -match ('(?i)(?<![A-Za-z0-9])' + [regex]::Escape($p.Name) + '(?![A-Za-z0-9])')) { Stop-Report 'nom reel de bibliotheque detecte : utiliser BIBnn' }
  }
}
if ($Fiche -notmatch '^0[1-8]-[a-z0-9-]+$') { Stop-Report "fiche invalide ($Fiche) : voir docs/cheatsheets/README.md" }

$slug = ($Titre.ToLower() -replace '[^a-z0-9]+', '-').Trim('-'); if ($slug.Length -gt 40) { $slug = $slug.Substring(0, 40).Trim('-') }
$dir = Join-Path $Root 'docs/apports'; if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }
$name = (Get-Date -Format 'yyyy-MM-dd') + '-' + $slug; $file = Join-Path $dir ($name + '.md'); $i = 2
while (Test-Path $file) { $file = Join-Path $dir ($name + '-' + $i + '.md'); $i++ }
$nl = "`n"
$body = '---' + $nl + 'fiche: ' + $Fiche + $nl + 'titre: ' + $Titre.Replace("`n", ' ') + $nl + 'type: ' + $Type + $nl + 'statut: ' + $Statut + $nl + 'source: ' + $(if ($Source) { $Source } else { 'aucune' }) + $nl + 'origine: remontee automatique par l assistant' + $nl + 'date: ' + (Get-Date -Format 'yyyy-MM-dd') + $nl + '---' + $nl + $Contenu.TrimEnd() + $nl
[IO.File]::WriteAllText($file, $body, (New-Object Text.UTF8Encoding($false)))
$rel = $file.Substring($Root.TrimEnd('\', '/').Length + 1).Replace('\', '/')
Write-Output ("CREE : " + $rel)
try { & (Join-Path $PSScriptRoot 'Assess-Document.ps1') -Root $Root -Path $file -Summary | ForEach-Object { Write-Output ("EVALUATION : " + $_) } } catch { Write-Output ("EVALUATION : non disponible (" + $_.Exception.Message + ")") }

if ($Mode -eq 'aucun') { Write-Output 'GIT : aucun (fichier seul)'; exit 0 }
$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git -or -not (Test-Path (Join-Path $Root '.git'))) { Write-Output 'GIT : depot non disponible, fichier cree seulement'; exit 0 }
Push-Location $Root
try {
  $cur = (& git rev-parse --abbrev-ref HEAD).Trim()
  $msg = "Apport automatique : $Titre`n`nCo-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>"
  if ($Mode -eq 'main') {
    & git add -- $rel; & git commit -q -m $msg; & git push -q origin $cur
    Write-Output ("GIT : commit et push sur " + $cur)
  } else {
    $br = 'apport/' + $name
    & git checkout -q -b $br; & git add -- $rel; & git commit -q -m $msg
    & git push -q -u origin $br
    Write-Output ("GIT : branche " + $br + " poussee")
    if (Get-Command gh -ErrorAction SilentlyContinue) { & gh pr create --base main --head $br --title ("Apport : " + $Titre) --body ("Remontee automatique (statut : " + $Statut + "). Evaluation : docs/EVALUATION-APPORTS.md.") | ForEach-Object { Write-Output ("PR : " + $_) } } else { Write-Output 'PR : gh absent, ouvrir la Pull Request depuis GitHub' }
    & git checkout -q $cur
  }
} catch { Write-Output ("GIT : echec (" + $_.Exception.Message + ") ; le fichier est cree, a commiter a la main") } finally { Pop-Location }
exit 0