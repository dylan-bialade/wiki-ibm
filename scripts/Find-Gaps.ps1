# Find-Gaps.ps1 - Ce qui est UTILISE dans le code des bibliotheques mais ABSENT des fiches (docs/cheatsheets/0*.md).
# Sortie : docs/MANQUES.md (genere) + resume console. Lecture seule sur sources/ et fiches. ASCII uniquement.
param([string]$Root)
if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }
. (Join-Path $PSScriptRoot 'Wiki-Common.ps1')
$ref = Get-JobiRef
$sheets = Get-SheetsText $Root
$items = Read-SourceItems $Root
$cat = @{ cl=@{}; rpg=@{}; msg=@{}; svc=@{}; dds=@{} }
$libsOf = @{}
function Add-Terms($it, $kind) {
  $t = Get-CodeTerms ($it.Code -join "`n") $ref $kind
  foreach ($c in $t.Keys) { foreach ($k in $t[$c].Keys) { $key = "$c|$k"; $cat[$c][$k] = $t[$c][$k] + [int]$cat[$c][$k]; if (-not $libsOf[$key]) { $libsOf[$key] = New-Set }; [void]$libsOf[$key].Add($it.Lib) } }
}
foreach ($it in $items) {
  $kind = if ($it.Type -like 'CL/*') { 'cl' } elseif ($it.Type -like 'RPG/*' -or $it.Type -eq 'COBOL') { 'rpg' } elseif ($it.Type -eq 'SQL') { 'text' } else { 'dds' }
  if ($it.Type -like 'DDS') { $kind = 'dds' }
  Add-Terms $it $kind
}
$names = @{ cl='Commandes CL'; rpg='Instructions / fonctions RPG (reconnues par job-i)'; msg='Messages (MONMSG, SQLCODE...)'; svc='Services SQL (QSYS2, SYSTOOLS)'; dds='Mots-cles DDS / ecran' }
$md = New-Object System.Collections.ArrayList
[void]$md.Add('# Ce qui manque dans les fiches (utilise dans le code, absent des fiches)'); [void]$md.Add('')
[void]$md.Add("Genere le $(Get-Date -Format 'yyyy-MM-dd HH:mm') a partir de $($items.Count) sources. Un terme est 'manquant' s'il n'apparait dans aucune fiche 01-05. Les comptes sont des occurrences dans le code ; voir 'Bibliotheques' pour la dispersion. Heuristique : verifier chaque terme sur job-i.fr avant d'ecrire la fiche.")
[void]$md.Add('')
$summary = @()
foreach ($c in 'cl','rpg','msg','svc','dds') {
  $all = $cat[$c].GetEnumerator() | Sort-Object Value -Descending
  $gap = @($all | Where-Object { -not (Test-InSheets $sheets $_.Key) })
  $summary += "$($names[$c]) : $($gap.Count) manquants sur $(@($all).Count) utilises"
  [void]$md.Add("## $($names[$c]) : $($gap.Count) manquants sur $(@($all).Count) utilises"); [void]$md.Add('')
  if ($gap.Count) {
    [void]$md.Add('| Terme | Occurrences | Bibliotheques |'); [void]$md.Add('|---|---|---|')
    foreach ($g in ($gap | Select-Object -First 45)) { [void]$md.Add("| $($g.Key) | $($g.Value) | $(@($libsOf["$c|$($g.Key)"]).Count) |") }
  }
  [void]$md.Add('')
}
# couverture par type
[void]$md.Add('## Sources par type et bibliotheque'); [void]$md.Add('')
[void]$md.Add('| Type | Sources |'); [void]$md.Add('|---|---|')
foreach ($g in ($items | Group-Object Type | Sort-Object Count -Descending)) { [void]$md.Add("| $($g.Name) | $($g.Count) |") }
[void]$md.Add('')
[IO.File]::WriteAllText((Join-Path $Root 'docs/MANQUES.md'), (($md -join "`n").TrimEnd() + "`n"), (New-Object Text.UTF8Encoding($false)))
$summary | ForEach-Object { Write-Output $_ }
Write-Output "Detail : docs/MANQUES.md"
