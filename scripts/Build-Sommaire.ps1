# Build-Sommaire.ps1 - Genere docs/SOMMAIRE.md : sommaire general par sujet, avec les titres de chaque page (liens d'ancre).
# Configuration (groupes, titres, descriptions) : scripts/sommaire.json (UTF-8). Les fichiers absents sont ignores. ASCII uniquement.
# Fonctionne sous Windows PowerShell 5.1 et PowerShell 7.
param([string]$Root)
if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }
function Get-Slug([string]$h) {
  $h = [regex]::Replace($h, '\[([^\]]*)\]\([^)]*\)', '$1'); $h = $h -replace '[`*]', ''
  $h = $h.ToLowerInvariant().Trim(); $h = [regex]::Replace($h, '[^\p{L}\p{Nd}\s\-_]', ''); return ($h -replace '\s', '-')
}
function Get-H2([string]$path) {
  $res = New-Object System.Collections.ArrayList; $fence = $false; $inToc = $false; $seen = @{}
  foreach ($l in ([IO.File]::ReadAllText($path) -split "`r?`n")) {
    if ($l -match '^\s*<!-- TOC:START -->') { $inToc = $true; continue }
    if ($l -match '^\s*<!-- TOC:END -->') { $inToc = $false; continue }
    if ($inToc) { continue }
    if ($l -match '^\s*(```|~~~)') { $fence = -not $fence; continue }
    if ($fence) { continue }
    $m = [regex]::Match($l, '^(#{1,6})\s+(.+?)\s*#*\s*$'); if (-not $m.Success) { continue }
    $slug = Get-Slug $m.Groups[2].Value
    if ($seen.ContainsKey($slug)) { $seen[$slug]++; $anchor = $slug + '-' + $seen[$slug] } else { $seen[$slug] = 0; $anchor = $slug }
    if ($m.Groups[1].Value.Length -eq 2) { [void]$res.Add([pscustomobject]@{ Text = ([regex]::Replace($m.Groups[2].Value, '\[([^\]]*)\]\([^)]*\)', '$1')); Anchor = $anchor }) }
  }
  return ,$res
}
$cfgPath = Join-Path $PSScriptRoot 'sommaire.json'
$groups = [IO.File]::ReadAllText($cfgPath, [Text.Encoding]::UTF8) | ConvertFrom-Json
$docsDir = Join-Path $Root 'docs'
$sb = New-Object System.Text.StringBuilder
$e1 = [string][char]0xE9
[void]$sb.AppendLine('# Sommaire g' + $e1 + 'n' + $e1 + 'ral du wiki')
[void]$sb.AppendLine('')
[void]$sb.AppendLine(('> Page g{0}n{0}r{0}e par `scripts/Build-Sommaire.ps1` (configuration : `scripts/sommaire.json`). Chaque page poss{2}de aussi son propre sommaire en t{3}te. Retour {1} la [carte rapide du README](../README.md).' -f $e1, [string][char]0xE0, [string][char]0xE8, [string][char]0xEA))
[void]$sb.AppendLine('')
foreach ($g in $groups) {
  $block = New-Object System.Text.StringBuilder; $count = 0
  foreach ($e in $g.entrees) {
    $full = Join-Path $Root $e.fichier
    if (-not (Test-Path $full)) { continue }
    $count++
    $rel = '../' + $e.fichier
    if ($e.fichier.StartsWith('docs/')) { $rel = $e.fichier.Substring(5) }
    [void]$block.AppendLine('- [' + $e.titre + '](' + $rel + ') : ' + $e.description)
    if ($e.sections -and (Test-Path $full -PathType Leaf)) {
      $heads = @(Get-H2 $full) | Where-Object { $_.Text -notmatch '^Sommaire' }
      foreach ($h in ($heads | Select-Object -First 24)) { [void]$block.AppendLine('  - [' + $h.Text + '](' + $rel + '#' + $h.Anchor + ')') }
    }
  }
  if ($count -eq 0) { continue }
  [void]$sb.AppendLine('## ' + $g.titre); [void]$sb.AppendLine(''); [void]$sb.AppendLine($g.intro); [void]$sb.AppendLine('')
  [void]$sb.Append($block.ToString()); [void]$sb.AppendLine('')
}
$out = $sb.ToString().TrimEnd() + "`n"
[IO.File]::WriteAllText((Join-Path $docsDir 'SOMMAIRE.md'), $out, (New-Object Text.UTF8Encoding($false)))
Write-Output ("OK : docs/SOMMAIRE.md ({0} lignes)" -f (($out -split "`n").Count))