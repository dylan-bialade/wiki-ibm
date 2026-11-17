# Check-JobIUpdates.ps1 - Detecte les mises a jour de https://job-i.fr/ (sitemaps + contenu des pages sources des fiches).
# Code de sortie : 0 = rien de nouveau (ou premiere execution : base creee) ; 10 = changements detectes.
# Ecrit : docs\.jobi-state.json (etat) et docs\JOBI-CHANGES.md (rapport, ecrase a chaque changement).
param([string]$Wiki = (Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference = "Stop"
$base = "https://job-i.fr"
$stateFile = Join-Path $Wiki "docs/.jobi-state.json"
function Sort-Ord($a){ $arr=[string[]]@($a); [Array]::Sort($arr,[StringComparer]::Ordinal); $arr }
function Get-Raw($url) { for ($try = 1; $try -le 4; $try++) { try { return (Invoke-WebRequest $url -UseBasicParsing -TimeoutSec 60).Content } catch { if ($try -eq 4) { throw }; Start-Sleep -Seconds (2 * $try) } } }
function Get-Hash($s) { $sha = [Security.Cryptography.SHA256]::Create(); ([BitConverter]::ToString($sha.ComputeHash([Text.Encoding]::UTF8.GetBytes($s)))).Replace("-","").Substring(0,16) }

# --- 1. Sitemaps : lastmod, nombre d'URL, hash de la liste
$idx = Get-Raw "$base/sitemap.xml"
$sitemaps = @{}
foreach ($m in [regex]::Matches($idx, '<loc>([^<]+)</loc>\s*<lastmod>([^<]+)</lastmod>')) {
  $loc = $m.Groups[1].Value; $name = ($loc -split '/')[-1]
  $urls = Sort-Ord ([regex]::Matches((Get-Raw $loc), '<loc>([^<]+)</loc>') | % { $_.Groups[1].Value })
  $sitemaps[$name] = @{ lastmod = $m.Groups[2].Value; count = @($urls).Count; hash = (Get-Hash ($urls -join "`n")); urls = @($urls) }
}

# --- 2. Pages sources des fiches : hash du texte (hors scripts/styles/balises)
$pages = Get-ChildItem (Join-Path $Wiki "docs/cheatsheets") -Filter "0*.md" | % { Get-Content $_.FullName -Raw -Encoding UTF8 } |
  % { [regex]::Matches($_, 'https://job-i\.fr(/[a-z0-9\-/]+)') | % { $_.Groups[1].Value } } |
  Where-Object { $_ -notmatch '^/(aller|offres|emploi|ibm-i$|commandes-ibm-i/)' } | Select-Object -Unique
$pages = Sort-Ord $pages
$pageHash = @{}
foreach ($p in $pages) {
  try {
    $h = Get-Raw "$base$p"
    $t = [regex]::Replace($h, '(?is)<(script|style|nav|footer|header)[^>]*>.*?</\1>', ' ')
    $t = [regex]::Replace($t, '<[^>]+>', ' ') -replace '\s+', ' '
    $pageHash[$p] = Get-Hash $t
  } catch { $pageHash[$p] = "ERREUR" }
}

$today = Get-Date -Format "yyyy-MM-dd HH:mm"
$new = @{ date = $today; sitemaps = @{}; pages = $pageHash }
foreach ($k in $sitemaps.Keys) { $new.sitemaps[$k] = @{ lastmod = $sitemaps[$k].lastmod; count = $sitemaps[$k].count; hash = $sitemaps[$k].hash } }

$changes = New-Object System.Collections.ArrayList
if (Test-Path $stateFile) {
  $old = Get-Content $stateFile -Raw -Encoding UTF8 | ConvertFrom-Json
  foreach ($k in (Sort-Ord $sitemaps.Keys)) {
    $o = $old.sitemaps.$k
    if (-not $o) { [void]$changes.Add("Nouveau sitemap : $k ($($sitemaps[$k].count) URL)"); continue }
    if ($o.hash -ne $sitemaps[$k].hash -or $o.count -ne $sitemaps[$k].count) {
      $diff = ""; if ($k -ne "sitemap-pages.xml") { $diff = " (" + ($sitemaps[$k].count - $o.count) + " URL)" }
      [void]$changes.Add("Liste modifiee : $k$diff, lastmod $($o.lastmod) -> $($sitemaps[$k].lastmod)")
    } elseif ($o.lastmod -ne $sitemaps[$k].lastmod -and $k -ne "sitemap-pages.xml") {
      [void]$changes.Add("Contenu mis a jour : $k, lastmod $($o.lastmod) -> $($sitemaps[$k].lastmod)")
    }
  }
  foreach ($p in (Sort-Ord $pageHash.Keys)) {
    $o = $old.pages.$p
    if ($o -and $pageHash[$p] -ne "ERREUR" -and $o -ne $pageHash[$p]) { [void]$changes.Add("Page modifiee : $base$p") }
    elseif (-not $o) { [void]$changes.Add("Page source ajoutee au suivi : $base$p") }
  }
  $mode = "comparaison"
} else { $mode = "base initiale creee" }

# Etat canonique (cles triees, sans date, sans BOM) : identique sous PowerShell 5.1 et 7, ecrit seulement s'il change.
$canon = [ordered]@{ sitemaps = [ordered]@{}; pages = [ordered]@{} }
foreach ($k in (Sort-Ord $new.sitemaps.Keys)) { $canon.sitemaps[$k] = [ordered]@{ count = $new.sitemaps[$k].count; hash = $new.sitemaps[$k].hash; lastmod = $new.sitemaps[$k].lastmod } }
foreach ($k in (Sort-Ord $new.pages.Keys)) { $canon.pages[$k] = $new.pages[$k] }
$json = ($canon | ConvertTo-Json -Depth 5 -Compress)
$prev = if (Test-Path $stateFile) { [IO.File]::ReadAllText($stateFile).TrimStart([char]0xFEFF).Trim() } else { '' }
if ($prev -ne $json) { [IO.File]::WriteAllText($stateFile, $json + "`n", (New-Object Text.UTF8Encoding($false))) }
$report = Join-Path $Wiki "docs/JOBI-CHANGES.md"
if ($changes.Count -gt 0) {
  $lines = @("# Changements detectes sur job-i.fr", "", "Verifie le $($new.date).", "")
  $lines += ($changes | % { "- $_" })
  $lines += @("", "Fiches a mettre a jour : voir la table de correspondance dans docs/PROMPT-SYSTEME.md.")
  [IO.File]::WriteAllText($report, (($lines -join "`n") + "`n"), (New-Object Text.UTF8Encoding($false)))
  Write-Output "CHANGEMENTS ($($changes.Count)) :"; $changes | % { Write-Output "- $_" }
  exit 10
}
Write-Output "Aucun changement ($mode). Sitemaps : $($sitemaps.Count), pages suivies : $($pageHash.Count)."
exit 0
