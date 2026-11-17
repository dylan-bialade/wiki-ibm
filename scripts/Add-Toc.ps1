# Add-Toc.ps1 - Insere (ou met a jour) un sommaire en tete de chaque page Markdown, juste avant le premier titre de niveau 2.
# Bloc delimite par <!-- TOC:START --> ... <!-- TOC:END --> ; idempotent ; ignore les blocs de code. ASCII uniquement.
# Fonctionne sous Windows PowerShell 5.1 et PowerShell 7.
param([string]$Root)
if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }
function Get-Slug([string]$h) {
  $h = [regex]::Replace($h, '\[([^\]]*)\]\([^)]*\)', '$1')
  $h = $h -replace '[`*]', ''
  $h = $h.ToLowerInvariant().Trim()
  $h = [regex]::Replace($h, '[^\p{L}\p{Nd}\s\-_]', '')
  return ($h -replace '\s', '-')
}
function Get-Headings([string[]]$lines) {
  $res = New-Object System.Collections.ArrayList; $fence = $false; $inToc = $false; $seen = @{}
  for ($i = 0; $i -lt $lines.Count; $i++) {
    $l = $lines[$i]
    if ($l -match '^\s*<!-- TOC:START -->') { $inToc = $true; continue }
    if ($l -match '^\s*<!-- TOC:END -->') { $inToc = $false; continue }
    if ($inToc) { continue }
    if ($l -match '^\s*(```|~~~)') { $fence = -not $fence; continue }
    if ($fence) { continue }
    $m = [regex]::Match($l, '^(#{1,6})\s+(.+?)\s*#*\s*$')
    if (-not $m.Success) { continue }
    $slug = Get-Slug $m.Groups[2].Value
    if ($seen.ContainsKey($slug)) { $seen[$slug]++; $anchor = $slug + '-' + $seen[$slug] } else { $seen[$slug] = 0; $anchor = $slug }
    [void]$res.Add([pscustomobject]@{ Level = $m.Groups[1].Value.Length; Text = ([regex]::Replace($m.Groups[2].Value, '\[([^\]]*)\]\([^)]*\)', '$1')); Anchor = $anchor; Line = $i })
  }
  return ,$res
}
$targets = New-Object System.Collections.ArrayList
[void]$targets.Add((Join-Path $Root 'README.md'))
foreach ($d in 'docs', 'docs/cheatsheets', 'docs/enonces', 'docs/apports', 'contributions') {
  $p = Join-Path $Root $d
  if (Test-Path $p) { foreach ($f in (Get-ChildItem $p -Filter '*.md' -File)) { if ($f.Name -ne 'SOMMAIRE.md') { [void]$targets.Add($f.FullName) } } }
}
$sommaire = Join-Path $Root 'docs/SOMMAIRE.md'
$done = 0; $skipped = 0
foreach ($file in ($targets | Sort-Object { $_.ToLowerInvariant() })) {
  if (-not (Test-Path $file)) { continue }
  $raw = [IO.File]::ReadAllText($file)
  $lines = @($raw -split "`r?`n")
  # retirer l'ancien bloc
  $clean = New-Object System.Collections.ArrayList; $skip = $false
  foreach ($l in $lines) {
    if ($l -match '^\s*<!-- TOC:START -->') { $skip = $true; continue }
    if ($skip) { if ($l -match '^\s*<!-- TOC:END -->') { $skip = $false }; continue }
    [void]$clean.Add($l)
  }
  # retirer une ligne vide en trop laissee a la place du bloc
  $lines = @($clean)
  $heads = Get-Headings $lines
  $sel = @($heads | Where-Object { $_.Level -eq 2 -or $_.Level -eq 3 })
  $firstH2 = $heads | Where-Object { $_.Level -eq 2 } | Select-Object -First 1
  $out = $null
  if ($sel.Count -ge 3 -and $firstH2) {
    $fromUri = New-Object System.Uri(([IO.Path]::GetFullPath($file)))
    $toUri = New-Object System.Uri(([IO.Path]::GetFullPath($sommaire)))
    $link = [System.Uri]::UnescapeDataString($fromUri.MakeRelativeUri($toUri).ToString())
    $b = New-Object System.Collections.ArrayList
    [void]$b.Add('<!-- TOC:START -->')
    [void]$b.Add('**Sommaire** (' + 'retour : [sommaire general](' + $link + '))')
    [void]$b.Add('')
    foreach ($h in $sel) { $ind = $(if ($h.Level -eq 3) { '  ' } else { '' }); [void]$b.Add($ind + '- [' + $h.Text + '](#' + $h.Anchor + ')') }
    [void]$b.Add('<!-- TOC:END -->')
    [void]$b.Add('')
    $pre = @($lines[0..($firstH2.Line - 1)])
    while ($pre.Count -gt 0 -and $pre[-1] -eq '') { $pre = @($pre[0..($pre.Count - 2)]) }
    $post = @($lines[$firstH2.Line..($lines.Count - 1)])
    $out = (@($pre) + @('') + @($b) + @($post)) -join "`n"
    $done++
  } else { $out = ($lines -join "`n"); $skipped++ }
  $out = $out.TrimEnd() + "`n"
  if ($out -ne $raw) { [IO.File]::WriteAllText($file, $out, (New-Object Text.UTF8Encoding($false))) }
}
Write-Output ("OK : sommaire dans {0} page(s), {1} page(s) trop courte(s) ignoree(s)." -f $done, $skipped)