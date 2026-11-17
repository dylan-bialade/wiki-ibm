# Build-Comparaison.ps1 - Rend visibles les "facons de faire" differentes entre bibliotheques :
#  - docs/COMPARAISON-BIBLIOTHEQUES.md + docs/comparaisons/<MEMBRE>.md : meme membre dans plusieurs bibliotheques (identique ou different, similarite, techniques)
#  - docs/CYCLE-GAP-EXEMPLES.md : sources RPG qui utilisent le cycle (fichier primaire IP, niveaux L1-L9, 1P, OF, LR)
# Lecture seule sur sources/ ; ne modifie rien d'autre que les fichiers generes ci-dessus. ASCII uniquement.
param([string]$Root)
if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }
. (Join-Path $PSScriptRoot 'Contrib-Common.ps1')
$utf8 = New-Object Text.UTF8Encoding($false)
$fence = [string]([char]96) * 3

# ---- lecture des sources converties
$items = New-Object System.Collections.ArrayList
foreach ($f in (Sort-By @(Get-ChildItem (Join-Path $Root 'sources') -Recurse -Filter *.md) { $_.FullName.Replace('\','/') })) {
  $L = [IO.File]::ReadAllLines($f.FullName)
  $fi = @(); for ($i = 0; $i -lt $L.Count; $i++) { if ($L[$i].StartsWith($fence)) { $fi += $i } }
  if ($fi.Count -lt 2) { continue }
  $code = @($L[($fi[$fi.Count-2]+1)..($fi[$fi.Count-1]-1)])
  $h = @{}; foreach ($l in $L[1..12]) { if ($l -match '^(\w+): (.*)$') { $h[$Matches[1]] = $Matches[2] } }
  $norm = @($code | ForEach-Object { (([regex]::Replace($_, '[\u0080-\u009F]', '')).Trim().ToUpperInvariant() -replace '\s+',' ') } | Where-Object { $_ -ne '' -and -not $_.StartsWith('//') -and -not $_.StartsWith('*') })
  $sha = [Security.Cryptography.SHA1]::Create()
  $hash = [BitConverter]::ToString($sha.ComputeHash([Text.Encoding]::UTF8.GetBytes(($norm -join "`n")))).Replace('-','')
  $rel = $f.FullName.Substring($Root.Length + 1).Replace('\','/')
  [void]$items.Add([pscustomobject]@{ Lib=$h['bibliotheque']; Membre=$h['membre']; Fichier=$h['fichier_source']; Type=$h['type']; Lines=$code.Count; Code=$code; Norm=$norm; Set=(New-Set); Hash=$hash; Path=$rel; Tech=(Get-Techniques ($code -join "`n")) })
  foreach ($n in $norm) { [void]$items[$items.Count-1].Set.Add($n) }
}

# ---- 1) meme membre dans plusieurs bibliotheques
$cdir = Join-Path $Root 'docs/comparaisons'
New-Item -ItemType Directory -Force $cdir | Out-Null
Get-ChildItem $cdir -Filter *.md -ErrorAction SilentlyContinue | Remove-Item -Force
$idx = New-Object System.Collections.ArrayList
$groups = Sort-By @($items | Group-Object { $_.Membre.ToUpper() } | Where-Object { @($_.Group | ForEach-Object { $_.Lib } | Select-Object -Unique).Count -gt 1 }) { $_.Name }
$nIdent = 0; $nDiff = 0
foreach ($g in $groups) {
  $vers = @($g.Group | Group-Object Hash)
  $libs = @(Sort-By @($g.Group | ForEach-Object { $_.Lib } | Select-Object -Unique) { $_ })
  $ls = @($g.Group | ForEach-Object { $_.Lines })
  if ($vers.Count -le 1) { $nIdent++; [void]$idx.Add("| $($g.Name) | $($libs -join ', ') | 1 (copies identiques) | $($ls[0]) | - | - |"); continue }
  $nDiff++
  $ref = $g.Group[0]
  $p = New-Object System.Collections.ArrayList
  [void]$p.Add("# $($g.Name) : $($vers.Count) versions differentes dans $($libs.Count) bibliotheques"); [void]$p.Add('')
  [void]$p.Add('Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).'); [void]$p.Add('')
  [void]$p.Add('| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |'); [void]$p.Add('|---|---|---|---|---|---|---|')
  foreach ($v in (Sort-By @($g.Group) { $_.Lib + '|' + $_.Path })) {
    $inter = 0; foreach ($x in $v.Set) { if ($ref.Set.Contains($x)) { $inter++ } }
    $union = $v.Set.Count + $ref.Set.Count - $inter; $sim = if ($union -gt 0) { [int](100 * $inter / $union) } else { 100 }
    [void]$p.Add("| $($v.Lib) | $($v.Fichier) | $($v.Type) | $($v.Lines) | $sim % | $($v.Tech -join ', ') | [$($v.Path.Split('/')[-1])](../../$($v.Path)) |")
  }
  [void]$p.Add('')
  $all = @($g.Group | ForEach-Object { $_.Tech } | Select-Object -Unique)
  $common = @($all | Where-Object { $t = $_; @($g.Group | Where-Object { $_.Tech -contains $t }).Count -eq $g.Count })
  [void]$p.Add('## Differences'); [void]$p.Add('')
  if ($common.Count) { [void]$p.Add("- Techniques communes : $($common -join ', ')") }
  foreach ($v in (Sort-By @($g.Group) { $_.Lib + '|' + $_.Path })) { $own = @($v.Tech | Where-Object { $common -notcontains $_ }); if ($own.Count) { [void]$p.Add("- **$($v.Lib)** en propre : $($own -join ', ')") } }
  $types = @($g.Group | ForEach-Object { $_.Type } | Select-Object -Unique); if ($types.Count -gt 1) { [void]$p.Add("- Langages / types differents : $($types -join ', ')") }
  [void]$p.Add('')
  [void]$p.Add('## Codes'); [void]$p.Add('')
  foreach ($v in (Sort-By @($g.Group) { $_.Lib + '|' + $_.Path })) {
    [void]$p.Add("### $($v.Lib) ($($v.Type), $($v.Lines) lignes)"); [void]$p.Add('')
    if ($v.Lines -le 150) { [void]$p.Add($fence + 'text'); foreach ($c in $v.Code) { [void]$p.Add($c) }; [void]$p.Add($fence) } else { [void]$p.Add("_Long : voir [$($v.Path.Split('/')[-1])](../../$($v.Path))._") }
    [void]$p.Add('')
  }
  [IO.File]::WriteAllText((Join-Path $cdir (($g.Name -replace '[^A-Za-z0-9_-]','_') + '.md')), (($p -join "`n").TrimEnd() + "`n"), $utf8)
  $mn = ($g.Group | Measure-Object Lines -Minimum -Maximum)
  $own2 = @($all | Where-Object { $common -notcontains $_ })
  [void]$idx.Add("| [$($g.Name)](comparaisons/$($g.Name -replace '[^A-Za-z0-9_-]','_').md) | $($libs -join ', ') | $($vers.Count) | $($mn.Minimum)-$($mn.Maximum) | $($own2 -join ', ') | $(@($g.Group | ForEach-Object { $_.Type } | Select-Object -Unique) -join ', ') |")
}
$m = New-Object System.Collections.ArrayList
[void]$m.Add('# Comparaison des bibliotheques : memes exercices, facons de faire differentes'); [void]$m.Add('')
[void]$m.Add("Genere le $(Get-Date -Format 'yyyy-MM-dd HH:mm'). Les bibliotheques du dossier de cours se recouvrent (copies d'exercices) mais le code n'est pas toujours le meme. $($groups.Count) membres existent dans plusieurs bibliotheques : $nDiff avec des versions **differentes** (page de comparaison), $nIdent copies **identiques**. Les noms de bibliotheques sont anonymises (BIBnn).")
[void]$m.Add(''); [void]$m.Add('Les contributions de collaborateurs sont comparees dans [VARIANTES](VARIANTES.md). Exemples du cycle RPG : [CYCLE-GAP-EXEMPLES](CYCLE-GAP-EXEMPLES.md).'); [void]$m.Add('')
[void]$m.Add('| Membre | Bibliotheques | Versions distinctes | Lignes | Techniques differentes | Types |'); [void]$m.Add('|---|---|---|---|---|---|')
foreach ($r in $idx) { [void]$m.Add($r) }
[IO.File]::WriteAllText((Join-Path $Root 'docs/COMPARAISON-BIBLIOTHEQUES.md'), (($m -join "`n").TrimEnd() + "`n"), $utf8)

# ---- 2) exemples du cycle RPG
$cy = New-Object System.Collections.ArrayList
foreach ($it in ($items | Where-Object { $_.Type -like 'RPG/*' -and $_.Type -notlike '*Copy*' })) {
  $isFree = ($it.Code.Count -gt 0 -and $it.Code[0] -match '^\*\*FREE')
  if ($isFree) { continue }
  $ip = $false; $is = $false; $lv = New-Set; $has1P = $false; $hasOF = $false
  foreach ($l in $it.Code) {
    if ($l.Length -gt 17 -and $l[5] -eq 'F' -and $l[6] -ne '*') {
      if (($l[14] -eq 'I' -and $l[15] -eq 'P') -or ($l[16] -eq 'I' -and $l[17] -eq 'P')) { $ip = $true }
      if (($l[14] -eq 'I' -and $l[15] -eq 'S') -or ($l[16] -eq 'I' -and $l[17] -eq 'S')) { $is = $true }
    }
    if ($l.Length -gt 7 -and $l[5] -match '[CIO]' -and $l[6] -ne '*') {
      foreach ($m2 in [regex]::Matches($l, '(?<![A-Z0-9])(L[1-9])(?![A-Z0-9])')) { [void]$lv.Add($m2.Groups[1].Value) }
      if ($l -match '(?<![A-Z0-9])1P(?![A-Z0-9])') { $has1P = $true }
      if ($l -match '(?<![A-Z0-9])OF(?![A-Z0-9])') { $hasOF = $true }
    }
  }
  if ($ip -or $is) { [void]$cy.Add([pscustomobject]@{ It=$it; IP=$ip; IS=$is; Lv=(Sort-By @($lv) { $_ }); P1=$has1P; OF=$hasOF }) }
}
$c = New-Object System.Collections.ArrayList
[void]$c.Add('# Exemples du cycle RPG (cycle GAP) dans les bibliotheques'); [void]$c.Add('')
[void]$c.Add("Genere le $(Get-Date -Format 'yyyy-MM-dd HH:mm'). Detection : un fichier **primaire** (IP) ou **secondaire** (IS) en specification F dans un source en colonnes. Explication du cycle : [fiche 03](cheatsheets/03-rpg-par-version.md) et [job-i.fr](https://job-i.fr/cycle-gap-rpg). Detection heuristique : a confirmer en ouvrant le source.")
[void]$c.Add('')
if ($cy.Count -eq 0) { [void]$c.Add('_Aucun source avec fichier primaire detecte._') } else {
  [void]$c.Add('| Bibliotheque | Membre | Type | Lignes | Primaire (IP) | Secondaire (IS) | Niveaux (L1-L9) | 1P | OF | Source |'); [void]$c.Add('|---|---|---|---|---|---|---|---|---|---|')
  foreach ($x in (Sort-By @($cy) { $_.It.Lib + '|' + $_.It.Membre + '|' + $_.It.Path })) {
    $yn = { param($b) if ($b) { 'oui' } else { '-' } }
    [void]$c.Add("| $($x.It.Lib) | $($x.It.Membre) | $($x.It.Type) | $($x.It.Lines) | $(& $yn $x.IP) | $(& $yn $x.IS) | $(($x.Lv -join ' ')) | $(& $yn $x.P1) | $(& $yn $x.OF) | [$($x.It.Path.Split('/')[-1])](../$($x.It.Path)) |")
  }
}
[IO.File]::WriteAllText((Join-Path $Root 'docs/CYCLE-GAP-EXEMPLES.md'), (($c -join "`n").TrimEnd() + "`n"), $utf8)
Write-Output "OK : $($items.Count) sources lues ; $($groups.Count) membres communs ($nDiff differents, $nIdent identiques) ; $($cy.Count) source(s) avec cycle (fichier primaire/secondaire)."
