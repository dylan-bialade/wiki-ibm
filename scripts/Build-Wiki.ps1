# Build-Wiki.ps1 - Transforme les exports ACS (*.LIB) en documents Markdown classes.
# Lecture seule sur la source : rien n'est execute, rien n'est modifie dans "cour et autre".
param(
  [string]$Source = "C:\Users\ARM-NOTOS\Documents\cour et autre",
  [string]$Wiki   = "C:\Users\ARM-NOTOS\Documents\IBM\wiki-ibmi"
)
$ErrorActionPreference = "Stop"
$enc = [Text.Encoding]::GetEncoding(1147)   # EBCDIC francais
$widths = 100,112,92,80,120,132,96,160       # longueurs d'enregistrement candidates (ordre de preference)

$typeMap = @{
  QRPGLESRC="RPG\RPG-ILE"; QRPGSRC="RPG\RPG-III-400"; QCLPSRC="CL\CL-procedural"; QCLLESRC="CL\CL-ILE";
  QDDSSRC="DDS"; QLFSRC="DDS"; QPFSRC="DDS"; QDSPSRC="DDS"; QMNUSRC="Menus";
  QCPYSRC="RPG\Copy"; QSRVSRC="Autres\Service-programs"; QWEBSRC="Autres\Web"; QSQLSRC="SQL"
}

function Get-Width($bytes) {
  $best = $null; $bestScore = 0
  foreach ($w in $widths) {
    if ($bytes.Length -lt $w -or ($bytes.Length % $w) -ne 0) { continue }
    $n = $bytes.Length / $w; $ok = 0
    for ($i = 0; $i -lt $n; $i++) {
      $e = $i*$w + $w - 1
      if ($bytes[$e] -eq 0x40 -and $bytes[$e-1] -eq 0x40 -and $bytes[$e-2] -eq 0x40 -and $bytes[$e-3] -eq 0x40) { $ok++ }
    }
    $s = $ok / $n
    if ($s -gt $bestScore) { $bestScore = $s; $best = $w }
  }
  if ($bestScore -ge 0.5) { return $best } else { return $null }
}

$out = Join-Path $Wiki "sources"
Get-ChildItem $out -Directory -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force   # regeneration propre
$rows = New-Object System.Collections.ArrayList
$data = New-Object System.Collections.ArrayList
$libs = Get-ChildItem $Source -Directory -Filter *.LIB | ForEach-Object { [pscustomobject]@{ BaseName = ($_.Name -replace '\.LIB$',''); FullName = $_.FullName } }

foreach ($lib in $libs) {
  foreach ($sf in Get-ChildItem $lib.FullName -Directory -Filter *.FILE) {
    $fname = $sf.Name -replace '\.FILE$',''
    foreach ($m in Get-ChildItem $sf.FullName -File -Filter *.MBR) {
      $mname = $m.BaseName
      $bytes = [IO.File]::ReadAllBytes($m.FullName)
      if ($bytes.Length -eq 0) { continue }
      $w = $null
      if ($typeMap.ContainsKey($fname)) { $w = Get-Width $bytes }
      if (-not $w) { [void]$data.Add([pscustomobject]@{Lib=$lib.BaseName;File=$fname;Member=$mname;Size=$bytes.Length}); continue }
      $lines = for ($i = 0; $i -lt $bytes.Length; $i += $w) { $enc.GetString($bytes, $i, $w).TrimEnd() }
      while ($lines.Count -gt 0 -and $lines[-1] -eq "") { $lines = $lines[0..($lines.Count-2)] }
      $type = $typeMap[$fname]; $top = $type.Split('\')[0]
      $lang = switch ($top) { "RPG" {"rpg"} "CL" {"cl"} "SQL" {"sql"} default {"text"} }
      $dir = Join-Path $out "$type\$($lib.BaseName)"
      New-Item -ItemType Directory -Force $dir | Out-Null
      $md = @("---","bibliotheque: $($lib.BaseName)","fichier_source: $fname","membre: $mname","type: $type","longueur_enregistrement: $w","lignes: $($lines.Count)","modifie: $($m.LastWriteTime.ToString('yyyy-MM-dd'))","---","","# $($lib.BaseName)/$fname/$mname","","``````$lang") + $lines + @("``````")
      $md | Set-Content (Join-Path $dir "$mname.md") -Encoding utf8
      [void]$rows.Add([pscustomobject]@{Type=$type;Lib=$lib.BaseName;File=$fname;Member=$mname;Lines=$lines.Count;Width=$w;Path="sources/$($type.Replace('\','/'))/$($lib.BaseName)/$mname.md"})
    }
  }
}

# --- index par type
$groups = $rows | Group-Object Type | Sort-Object Name
$idx = New-Object System.Text.StringBuilder
[void]$idx.AppendLine("# Index des sources"); [void]$idx.AppendLine("")
[void]$idx.AppendLine("Genere le $(Get-Date -Format 'yyyy-MM-dd HH:mm') - $($rows.Count) sources, $($data.Count) membres de donnees (non convertis).`n")
foreach ($g in $groups) {
  [void]$idx.AppendLine("## $($g.Name) ($($g.Count))`n"); [void]$idx.AppendLine("| Bibliotheque | Membre | Lignes | Document |"); [void]$idx.AppendLine("|---|---|---|---|")
  foreach ($r in ($g.Group | Sort-Object Lib,Member)) { [void]$idx.AppendLine("| $($r.Lib) | $($r.Member) | $($r.Lines) | [$($r.Member)](../$($r.Path)) |") }
  [void]$idx.AppendLine("")
}
New-Item -ItemType Directory -Force (Join-Path $Wiki "docs") | Out-Null
$idx.ToString() | Set-Content (Join-Path $Wiki "docs\INDEX-SOURCES.md") -Encoding utf8

# --- architecture : une page par bibliotheque
$arch = Join-Path $Wiki "architecture"; New-Item -ItemType Directory -Force $arch | Out-Null
foreach ($lib in $libs) {
  $n = $lib.BaseName; $mine = $rows | Where-Object Lib -eq $n; $dat = $data | Where-Object Lib -eq $n
  $sb = New-Object System.Text.StringBuilder
  [void]$sb.AppendLine("# Bibliotheque $n`n")
  [void]$sb.AppendLine("- Sources converties : $(@($mine).Count)`n- Membres de donnees / non-source : $(@($dat).Count)`n")
  [void]$sb.AppendLine("## Repartition par type`n"); [void]$sb.AppendLine("| Type | Nombre |"); [void]$sb.AppendLine("|---|---|")
  $mine | Group-Object Type | ForEach-Object { [void]$sb.AppendLine("| $($_.Name) | $($_.Count) |") }
  [void]$sb.AppendLine("`n## Fichiers de donnees / objets (membres non-source)`n")
  if ($dat) { $dat | Group-Object File | ForEach-Object { [void]$sb.AppendLine("- **$($_.Name)** : $((($_.Group | Select -Expand Member) -join ', '))") } } else { [void]$sb.AppendLine("_aucun_") }
  $sb.ToString() | Set-Content (Join-Path $arch "$n.md") -Encoding utf8
}
$rows | Export-Csv (Join-Path $Wiki "docs\sources.csv") -NoTypeInformation -Encoding utf8
"OK : $($rows.Count) sources converties, $($data.Count) membres non-source, $(@($libs).Count) bibliotheques."
