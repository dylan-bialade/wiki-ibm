# Wiki-Common.ps1 - Fonctions partagees : reference job-i, termes IBM i d'un texte, lecture des sources converties.
# A charger avec : . .\Wiki-Common.ps1   (charge aussi Contrib-Common.ps1). ASCII uniquement.
. (Join-Path $PSScriptRoot 'Contrib-Common.ps1')
$script:Fence = [string]([char]96) * 3

function Get-JobiRef {
  # Liste des commandes CL et des termes RPG de job-i.fr (cache 24 h partage avec Verify-Code.ps1). $null si indisponible.
  $cache = Join-Path ([IO.Path]::GetTempPath()) 'jobi-ref-cache.json'
  if (Test-Path $cache) { try { return (Get-Content $cache -Raw | ConvertFrom-Json) } catch {} }
  try {
    $base = 'https://job-i.fr'
    function Page($p) { (Invoke-WebRequest "$base$p" -UseBasicParsing -TimeoutSec 60).Content }
    $cmds = [regex]::Matches((Page '/commandes-ibm-i'), 'data-code="([A-Z0-9_]+)"') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique
    $rpg = @(); foreach ($p in '/instructions-rpg','/fonctions-rpg','/coder-rpg-iii') { $rpg += [regex]::Matches((Page $p), '>(%?[A-Z][A-Z0-9_-]{1,10})<') | ForEach-Object { $_.Groups[1].Value } }
    $ref = [pscustomobject]@{ cmds = @($cmds); rpg = @($rpg | Sort-Object -Unique) }
    $ref | ConvertTo-Json | Set-Content $cache -Encoding utf8
    return $ref
  } catch { return $null }
}

function Get-SheetsText([string]$Root) {
  $t = ''
  foreach ($f in (Get-ChildItem (Join-Path $Root 'docs\cheatsheets') -Filter '0*.md' -ErrorAction SilentlyContinue)) { $t += "`n" + [IO.File]::ReadAllText($f.FullName) }
  return $t.ToUpper()
}

function Test-InSheets([string]$Sheets, [string]$Term) {
  return [regex]::IsMatch($Sheets, '(?<![A-Z0-9_%])' + [regex]::Escape($Term.ToUpper()) + '(?![A-Z0-9_])')
}

function Get-CodeTerms([string]$Text, $Ref, [string]$Kind = 'auto') {
  # Termes IBM i reconnus dans un texte. Retourne des tables terme -> occurrences par categorie.
  $r = [ordered]@{ cl = @{}; rpg = @{}; msg = @{}; svc = @{}; dds = @{} }
  $cmdSet = New-Set; $rpgSet = New-Set
  if ($Ref) { foreach ($c in $Ref.cmds) { [void]$cmdSet.Add($c) }; foreach ($c in $Ref.rpg) { [void]$rpgSet.Add($c) } }
  $ddsRx = '(?<![A-Z0-9_])(SFL[A-Z]*|DSPSIZ|DSPATR|COLOR|CF\d\d|CA\d\d|ERRMSG|OVERLAY|WINDOW|INDARA|CHGINPDFT|EDTCDE|EDTWRD|REFFLD|DFTVAL|PFILE|JFILE|JFLD|DYNSLT|ALTSEQ|COMP|VALUES|RANGE|CHECK|TEXT|COLHDG)(?![A-Z0-9_])'
  foreach ($line in ($Text -split "`n")) {
    $l = $line.TrimEnd("`r"); $u = $l.ToUpper(); $t = $l.TrimStart()
    if ($t.StartsWith('//') -or $t.StartsWith('/*') -or $t.StartsWith('```')) { continue }
    if ($l.Length -gt 6 -and $l[6] -eq '*' -and $Kind -ne 'text') { continue }
    foreach ($m in [regex]::Matches($u, '(?<![A-Z0-9_])(CPF|CPD|MCH|CPC|RNF|RNQ|SQL|IWS|EDT)[0-9A-F]{4}(?![A-Z0-9_])')) { $r.msg[$m.Value] = 1 + [int]$r.msg[$m.Value] }
    foreach ($m in [regex]::Matches($u, '(?<![A-Z0-9_])(QSYS2|SYSTOOLS|SYSIBMADM)\.[A-Z_0-9]+')) { $r.svc[$m.Value] = 1 + [int]$r.svc[$m.Value] }
    foreach ($m in [regex]::Matches($u, $ddsRx)) { $r.dds[$m.Groups[1].Value] = 1 + [int]$r.dds[$m.Groups[1].Value] }
    if ($Kind -in 'cl','auto','text') {
      $m = [regex]::Match($u, '^\s*(?:[A-Z0-9_]+:\s*)?([A-Z][A-Z0-9]{2,9})\b')
      if ($m.Success -and $cmdSet.Contains($m.Groups[1].Value)) { $k = $m.Groups[1].Value; $r.cl[$k] = 1 + [int]$r.cl[$k] }
      if ($Kind -eq 'text') { foreach ($mm in [regex]::Matches($u, '(?<![A-Z0-9_])([A-Z][A-Z0-9]{4,9})(?![A-Z0-9_])')) { if ($cmdSet.Contains($mm.Value) -and $mm.Value -match '^(CRT|DLT|CHG|DSP|WRK|ADD|RMV|CPY|RTV|SND|STR|END|OVR|SAV|RST|CLR|RUN)') { $r.cl[$mm.Value] = 1 + [int]$r.cl[$mm.Value] } } }
    }
    if ($Kind -in 'rpg','auto','text') {
      foreach ($mm in [regex]::Matches($u, '(?<![A-Z0-9_])(%?[A-Z][A-Z0-9_-]{1,10})(?![A-Z0-9_])')) { $k = $mm.Groups[1].Value; if ($rpgSet.Contains($k) -and ($k.StartsWith('%') -or $k.Length -ge 4)) { $r.rpg[$k] = 1 + [int]$r.rpg[$k] } }
    }
  }
  return $r
}

function Read-SourceItems([string]$Root) {
  # Sources converties (sources/**/*.md) : en-tete + code + version normalisee
  $items = New-Object System.Collections.ArrayList
  foreach ($f in (Get-ChildItem (Join-Path $Root 'sources') -Recurse -Filter *.md)) {
    $L = [IO.File]::ReadAllLines($f.FullName)
    $fi = @(); for ($i = 0; $i -lt $L.Count; $i++) { if ($L[$i].StartsWith($script:Fence)) { $fi += $i } }
    if ($fi.Count -lt 2) { continue }
    $code = @($L[($fi[$fi.Count-2]+1)..($fi[$fi.Count-1]-1)])
    $h = @{}; foreach ($l in $L[1..12]) { if ($l -match '^(\w+): (.*)$') { $h[$Matches[1]] = $Matches[2] } }
    $norm = New-Set
    foreach ($c in $code) { $n = ($c.Trim().ToUpper() -replace '\s+',' '); if ($n -ne '' -and -not $n.StartsWith('//') -and -not $n.StartsWith('*')) { [void]$norm.Add($n) } }
    [void]$items.Add([pscustomobject]@{ Lib=$h['bibliotheque']; Membre=$h['membre']; Type=$h['type']; Fichier=$h['fichier_source']; Lines=$code.Count; Code=$code; Norm=$norm; Path=($f.FullName.Substring($Root.Length + 1).Replace('\','/')) })
  }
  return ,$items
}

function Get-Similarity($A, $B) {
  if ($A.Count -eq 0 -or $B.Count -eq 0) { return 0.0 }
  $i = 0; foreach ($x in $A) { if ($B.Contains($x)) { $i++ } }
  return [double]$i / ($A.Count + $B.Count - $i)
}
