# Build-Wiki.ps1 - Transforme les exports ACS (*.LIB) en documents Markdown classes.
# Lecture seule sur la source : rien n'est execute, rien n'est modifie dans "cour et autre".
param(
  [string]$Source = "C:\Users\ARM-NOTOS\Documents\cour et autre",
  [string]$Wiki   = "C:\Users\ARM-NOTOS\Documents\IBM\wiki-ibmi"
)
$ErrorActionPreference = "Stop"
$enc = [Text.Encoding]::GetEncoding(1147)   # EBCDIC francais
$widths = 100,112,92,80,120,132,96,160,102,108,114,124,152       # longueurs d'enregistrement candidates (ordre de preference)

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
# --- Anonymisation : les noms reels de bibliotheques ne sont JAMAIS publies. Table de correspondance privee, hors depot (stable d'une execution a l'autre).
$aliasFile = Join-Path (Split-Path $Wiki -Parent) "lib-alias.private.json"
$alias = @{}
if (Test-Path $aliasFile) { (Get-Content $aliasFile -Raw -Encoding UTF8 | ConvertFrom-Json).PSObject.Properties | ForEach-Object { $alias[$_.Name] = [string]$_.Value } }
$real = @(Get-ChildItem $Source -Directory -Filter *.LIB | ForEach-Object { $_.Name -replace '\.LIB$','' } | Sort-Object)
$nextNo = 1 + [int]@($alias.Values | ForEach-Object { if ($_ -match '^BIB(\d+)$') { [int]$Matches[1] } else { 0 } } | Measure-Object -Maximum).Maximum
foreach ($n in $real) { if (-not $alias.ContainsKey($n)) { $alias[$n] = ('BIB' + ([int]$nextNo).ToString('00')); $nextNo++ } }
$ordered = [ordered]@{}; foreach ($k in ($alias.Keys | Sort-Object)) { $ordered[$k] = $alias[$k] }
[IO.File]::WriteAllText($aliasFile, ($ordered | ConvertTo-Json), (New-Object Text.UTF8Encoding($false)))
$libs = Get-ChildItem $Source -Directory -Filter *.LIB | ForEach-Object { $r = ($_.Name -replace '\.LIB$',''); [pscustomobject]@{ BaseName = $alias[$r]; Real = $r; FullName = $_.FullName } }
$realRx = '(?i)(?<![A-Z0-9_#@$])(' + (($real | Sort-Object Length -Descending | ForEach-Object { [regex]::Escape($_) }) -join '|') + ')(?![A-Z0-9_#@$])'
$script:aliasMap = $alias
$realRxC = New-Object Text.RegularExpressions.Regex($realRx, 'Compiled')
$maskEval = [Text.RegularExpressions.MatchEvaluator]{ param($m) $script:aliasMap[$m.Value.ToUpper()] }
function Mask([string]$s) { if ($s.Length -lt 4) { return $s }; $realRxC.Replace($s, $maskEval) }

# --- Type d'un fichier source : par son nom (QRPGLESRC, QRPGLESRC2, QSQLRPGLE, QCBLLESRC...) ou, pour les fichiers "fourre-tout" (QSRC...), par le contenu
function Get-NameType([string]$f) {
  switch -regex ($f) {
    '^(QRPGLESRC\d*|QFREERPGLE|QSQLRPGLE|QRPGLE\w*)$' { return 'RPG\RPG-ILE' }
    '^QRPGSRC\d*$'                                       { return 'RPG\RPG-III-400' }
    '^(QCLPSRC|QCLSRC)\d*$'                              { return 'CL\CL-procedural' }
    '^(QCLLESRC|QCLESRC)\d*$'                            { return 'CL\CL-ILE' }
    '^(QDDSSRC\d*|QDDSRC|QDDSLESRC|QLFSRC|QPFSRC|QDSPSRC|QDSPFSRC|QPRTSRC|QSFSRC)$' { return 'DDS' }
    '^QMNUSRC$'                                          { return 'Menus' }
    '^QCPYSRC$'                                          { return 'RPG\Copy' }
    '^(QSRVSRC|QBNDSRC)$'                                { return 'Autres\Service-programs' }
    '^QWEBSRC$'                                          { return 'Autres\Web' }
    '^(QSQLSRC|QSQDSRC)$'                                { return 'SQL' }
    '^QCBLLESRC$'                                        { return 'COBOL' }
    '^QCMDSRC$'                                          { return 'Autres\Commandes' }
    '^QPNLSRC$'                                          { return 'Autres\Panneaux-UIM' }
    '^QHLPSRC$'                                          { return 'Autres\Aide' }
  }
  return $null
}
$mixedRx = '^(QSRC|QSOURCES?|QVSRC|QILESRC|QILE|QEXOSRC|QTESTSRC|QTPSRC|QAPI|QCHATGPT|QVINCI|QVSCODE|QTMABUG|QMOD|QERROR|QSRCRACE|HINTSRC\d*|RPGLESRCNO|\w*SRC\w*)$'
function Get-ContentType($lines) {
  $t = ($lines -join "`n"); $n = [Math]::Max(1, @($lines).Count)
  if ($t -match '(?im)^\s*\*\*free|\bdcl-(s|ds|f|pr|pi|proc)\b|\bctl-opt\b') { return 'RPG\RPG-ILE' }
  if ($t -match '(?i)IDENTIFICATION\s+DIVISION|PROGRAM-ID') { return 'COBOL' }
  if ($t -match '(?im)^\s*(PGM\b|DCLF\b|MONMSG\b)') { return 'CL\CL-procedural' }
  $dds = @($lines | Where-Object { $_.Length -gt 6 -and $_[5] -eq 'A' }).Count
  $rpg = @($lines | Where-Object { $_.Length -gt 6 -and $_[5] -match '[HFDCIOEL]' -and $_[6] -ne '*' }).Count
  if ($dds / $n -gt 0.5) { return 'DDS' }
  if ($rpg / $n -gt 0.5) { if ($t -match '(?i)\bEVAL\b|%[A-Z]+|\bDCL-') { return 'RPG\RPG-ILE' } else { return 'RPG\RPG-III-400' } }
  if ($t -match '(?is)\bCREATE\s+(TABLE|VIEW|INDEX|PROCEDURE)|\bSELECT\b.+\bFROM\b') { return 'SQL' }
  return $null
}
$written = New-Object 'System.Collections.Generic.HashSet[string]'

foreach ($lib in $libs) {
  foreach ($sf in Get-ChildItem $lib.FullName -Directory -Filter *.FILE) {
    $fname = $sf.Name -replace '\.FILE$',''
    foreach ($m in Get-ChildItem $sf.FullName -File -Filter *.MBR) {
      $mname = $m.BaseName
      if ($m.Length -gt 3MB) { [void]$data.Add([pscustomobject]@{Lib=$lib.BaseName;File=$fname;Member=$mname;Size=$m.Length}); continue }
      $bytes = [IO.File]::ReadAllBytes($m.FullName)
      if ($bytes.Length -eq 0) { continue }
      if ($bytes.Length -gt 3MB) { [void]$data.Add([pscustomobject]@{Lib=$lib.BaseName;File=$fname;Member=$mname;Size=$bytes.Length}); continue }   # trop gros pour un source : traite comme donnee
      $w = $null
      $type = Get-NameType $fname
      $isMixed = (-not $type) -and ($fname -match $mixedRx)
      if ($type -or $isMixed) { $w = Get-Width $bytes }
      if (-not $w) { [void]$data.Add([pscustomobject]@{Lib=$lib.BaseName;File=$fname;Member=$mname;Size=$bytes.Length}); continue }
      $lines = for ($i = 0; $i -lt $bytes.Length; $i += $w) { Mask ($enc.GetString($bytes, $i, $w).TrimEnd()) }
      $lines = @($lines); $n = $lines.Count; while ($n -gt 0 -and $lines[$n-1] -eq "") { $n-- }; if ($n -eq 0) { continue }; $lines = @($lines[0..($n-1)])   # un membre entierement blanc est ignore
      if ($isMixed) { $type = Get-ContentType $lines; if (-not $type) { [void]$data.Add([pscustomobject]@{Lib=$lib.BaseName;File=$fname;Member=$mname;Size=$bytes.Length}); continue } }
      $top = $type.Split('\')[0]
      $lang = switch ($top) { "RPG" {"rpg"} "CL" {"cl"} "SQL" {"sql"} default {"text"} }
      # Format colonne (RPG III, RPG IV non **free) : "text" = police fixe sans coloration (la coloration GitHub casse l'alignement des colonnes)
      if ($top -eq "RPG" -and -not ($lines.Count -gt 0 -and $lines[0] -match '^\*\*FREE')) { $lang = "text" }
      $dir = Join-Path $out "$type\$($lib.BaseName)"
      New-Item -ItemType Directory -Force $dir | Out-Null
      $ruler = @()
      if ($type -like "RPG\RPG-III*") {   # repere de colonnes pour le format colonne (aligne sur le bloc de code ci-dessous)
        $t1 = -join (1..80 | % { if ($_ % 10 -eq 0) { [string]([int]($_/10) % 10) } else { ' ' } })
        $t2 = -join (1..80 | % { [string]($_ % 10) })
        $ruler = @("Repere de colonnes :","","``````text",$t1,$t2,"``````","")
      }
      $mfile = $mname
      if (-not $written.Add("$type|$($lib.BaseName)|$mfile")) { $mfile = "$mname~$fname"; [void]$written.Add("$type|$($lib.BaseName)|$mfile") }   # meme nom dans deux fichiers sources de la bibliotheque
      $md = @("---","bibliotheque: $($lib.BaseName)","fichier_source: $fname","membre: $mname","type: $($type.Replace('\','/'))","longueur_enregistrement: $w","lignes: $($lines.Count)","modifie: $($m.LastWriteTime.ToString('yyyy-MM-dd'))","---","","# $($lib.BaseName)/$fname/$mname","") + $ruler + @("``````$lang") + $lines + @("``````")
      [IO.File]::WriteAllLines((Join-Path $dir "$mfile.md"), [string[]]$md, (New-Object Text.UTF8Encoding($false)))   # UTF-8 SANS BOM : sinon GitHub ne reconnait pas l'en-tete YAML
      [void]$rows.Add([pscustomobject]@{Type=$type;Lib=$lib.BaseName;File=$fname;Member=$mname;Lines=$lines.Count;Width=$w;Path="sources/$($type.Replace('\','/'))/$($lib.BaseName)/$mfile.md"})
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
