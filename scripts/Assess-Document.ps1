# Assess-Document.ps1 - Evalue automatiquement chaque document ajoute (docs/apports/, contributions/) et juge s'il est
# PERTINENT pour le wiki : securite/format, lien avec IBM i (termes reconnus par job-i), nouveaute (doublon ?),
# apport (comble un manque des fiches), qualite. Verdict : PERTINENT / A REVOIR / NON PERTINENT / DEJA PRESENT / REJETE.
# Usage : Assess-Document.ps1                 -> tout ce qui est dans docs/apports et contributions, ecrit docs/EVALUATION-APPORTS.md
#         Assess-Document.ps1 -Path fichier   -> evalue un fichier ou un dossier (affichage seul)
#         -Summary                            -> ajoute le rapport au resume GitHub Actions
# Code de sortie 1 si au moins un document est REJETE (secret, binaire, format interdit). ASCII uniquement.
param([string]$Root, [string]$Path, [switch]$Summary)
if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }
. (Join-Path $PSScriptRoot 'Wiki-Common.ps1')
$ref = Get-JobiRef
$sheets = Get-SheetsText $Root
$items = Read-SourceItems $Root
$sheetLines = New-Set
foreach ($l in ($sheets -split "`n")) { $n = ($l.Trim() -replace '\s+',' '); if ($n.Length -ge 25) { [void]$sheetLines.Add($n) } }

# ---- documents a evaluer
$cands = New-Object System.Collections.ArrayList
function Add-Cand([string]$full, [string]$label, [string]$text) { [void]$cands.Add([pscustomobject]@{ Full=$full; Label=$label; Text=$text }) }
function Load-File([string]$full, [string]$label) {
  $ext = [IO.Path]::GetExtension($full).ToLower()
  if ($ext -notin $script:AllowedExt) { [void]$cands.Add([pscustomobject]@{ Full=$full; Label=$label; Text=$null; Reject="format non pris en charge ($ext) : convertir en .md/.txt/source texte" }); return }
  $b = [IO.File]::ReadAllBytes($full)
  if ($b.Length -eq 0) { [void]$cands.Add([pscustomobject]@{ Full=$full; Label=$label; Text=$null; Reject='fichier vide' }); return }
  if ($b.Length -gt 512KB) { [void]$cands.Add([pscustomobject]@{ Full=$full; Label=$label; Text=$null; Reject='fichier trop gros (>512 Ko)' }); return }
  if ($b -contains 0) { [void]$cands.Add([pscustomobject]@{ Full=$full; Label=$label; Text=$null; Reject='fichier binaire' }); return }
  $t = [Text.Encoding]::UTF8.GetString($b).TrimStart([char]0xFEFF)
  if ($t -match $script:SecretHard) { [void]$cands.Add([pscustomobject]@{ Full=$full; Label=$label; Text=$null; Reject='secret detecte (cle ou jeton)' }); return }
  Add-Cand $full $label $t
}
if ($Path) {
  $p = (Resolve-Path $Path).Path
  if (Test-Path $p -PathType Container) { foreach ($f in (Get-ChildItem $p -Recurse -File)) { Load-File $f.FullName $f.Name } } else { Load-File $p (Split-Path $p -Leaf) }
} else {
  $ap = Join-Path $Root 'docs/apports'
  if (Test-Path $ap) { foreach ($f in (Get-ChildItem $ap -Recurse -File | Where-Object { $_.Name -ne 'README.md' })) { Load-File $f.FullName ('docs/apports/' + $f.FullName.Substring($ap.Length + 1).Replace('\','/')) } }
  $cb = Join-Path $Root 'contributions'
  if (Test-Path $cb) { foreach ($d in (Get-ChildItem $cb -Directory | Where-Object { $_.Name -notlike '_*' })) { foreach ($f in (Get-ChildItem $d.FullName -Recurse -File | Where-Object { $_.Name -ne 'contribution.json' })) { Load-File $f.FullName ('contributions/' + $d.Name + '/' + $f.FullName.Substring($d.FullName.Length + 1).Replace('\','/')) } } }
}

# ---- evaluation
$res = New-Object System.Collections.ArrayList
foreach ($c in $cands) {
  $o = [pscustomobject]@{ Doc=$c.Label; Kind='-'; Score=0; Verdict=''; Reasons=(New-Object System.Collections.ArrayList); Dest='-'; Terms=0; Gaps=@() }
  if ($c.Reject) { $o.Verdict = 'REJETE'; [void]$o.Reasons.Add($c.Reject); [void]$res.Add($o); continue }
  $text = $c.Text; $ext = [IO.Path]::GetExtension($c.Full).ToLower()
  $kind = switch ($ext) { { $_ -in '.rpgle','.rpg','.sqlrpgle','.rpgleinc','.cpy' } { 'rpg' } { $_ -in '.clp','.clle','.cl' } { 'cl' } { $_ -in '.dds','.pf','.lf','.dspf','.prtf','.mnu' } { 'dds' } '.sql' { 'sql' } default { 'text' } }
  $o.Kind = $kind
  $isCode = $kind -ne 'text'
  $lines = @($text -split "`n")
  if ($text -match $script:SecretSoft) { [void]$o.Reasons.Add('mot de passe / jeton possible : a verifier') }

  # 1) lien avec IBM i (0-40)
  $tk = if ($kind -eq 'sql') { 'text' } else { $kind }
  $terms = Get-CodeTerms $text $ref $tk
  $all = @(); foreach ($cat in $terms.Keys) { foreach ($k in $terms[$cat].Keys) { $all += [pscustomobject]@{ Cat=$cat; T=$k } } }
  $tech = Get-Techniques $text
  $distinct = $all.Count + $tech.Count
  $o.Terms = $distinct
  $sRel = [Math]::Min(40, $distinct * 4)
  if ($distinct -eq 0) { [void]$o.Reasons.Add('aucun terme IBM i reconnu') } else { [void]$o.Reasons.Add("$($all.Count) terme(s) IBM i reconnu(s), $($tech.Count) technique(s)") }

  # 2) nouveaute (0-30)
  $sNew = 30; $doublon = $false
  if ($isCode) {
    $set = New-Set; foreach ($l in $lines) { $n = (([regex]::Replace($l, '[\u0080-\u009F]', '')).Trim().ToUpperInvariant() -replace '\s+',' '); if ($n -ne '' -and -not $n.StartsWith('//') -and -not $n.StartsWith('*')) { [void]$set.Add($n) } }
    $best = 0.0; $bestIt = $null
    foreach ($it in $items) { $s = Get-Similarity $set $it.Norm; if ($s -gt $best) { $best = $s; $bestIt = $it } }
    if ($best -ge 0.999) { $doublon = $true; [void]$o.Reasons.Add("identique a $($bestIt.Path)") }
    elseif ($best -ge 0.85) { $sNew = 8; [void]$o.Reasons.Add("quasi-doublon ($([int](100*$best)) %) de $($bestIt.Path) : a ranger comme variante") }
    elseif ($best -ge 0.5) { $sNew = 18; [void]$o.Reasons.Add("proche ($([int](100*$best)) %) de $($bestIt.Path) : variante possible") }
    else { [void]$o.Reasons.Add('code nouveau (aucune source proche)') }
  } else {
    $cl = @($lines | ForEach-Object { (([regex]::Replace($_, '[\u0080-\u009F]', '')).Trim().ToUpperInvariant() -replace '\s+',' ') } | Where-Object { $_.Length -ge 25 })
    if ($cl.Count -gt 0) {
      $hit = @($cl | Where-Object { $sheetLines.Contains($_) }).Count; $frac = $hit / $cl.Count
      if ($frac -ge 0.8) { $sNew = 5; [void]$o.Reasons.Add("deja dans les fiches ($([int](100*$frac)) % des lignes)") }
      elseif ($frac -ge 0.4) { $sNew = 15; [void]$o.Reasons.Add("recoupe partiellement les fiches ($([int](100*$frac)) %)") }
    }
  }

  # 3) comble un manque (0-20)
  $gaps = @($all | Where-Object { -not (Test-InSheets $sheets $_.T) } | ForEach-Object { $_.T } | Select-Object -Unique)
  $o.Gaps = $gaps
  $sGap = [Math]::Min(20, $gaps.Count * 4)
  if ($gaps.Count) { [void]$o.Reasons.Add("comble des manques des fiches : $(($gaps | Select-Object -First 6) -join ', ')") }

  # 4) qualite (0-10)
  $sQ = 0
  if ($lines.Count -ge 8) { $sQ += 3 } else { [void]$o.Reasons.Add('tres court (moins de 8 lignes)') }
  if ($lines.Count -le 5000) { $sQ += 2 } else { [void]$o.Reasons.Add('tres long') }
  $head = ($lines | Select-Object -First 8) -join "`n"
  if ($head -match '(?m)^\s*(//|/\*|\*|#|--)' -or $text -match '(?m)^.{6}\*') { $sQ += 3 } else { [void]$o.Reasons.Add('pas de commentaire / titre en tete') }
  if ($isCode -and $text -match '(?i)(consigne|objectif|exercice|but)') { $sQ += 2 } elseif (-not $isCode -and $text -match '(?m)^#{1,3} ') { $sQ += 2 }

  $o.Score = [int]($sRel + $sNew + $sGap + $sQ)
  if ($doublon) { $o.Verdict = 'DEJA PRESENT'; $o.Score = 0 }
  elseif ($distinct -eq 0) { $o.Verdict = 'NON PERTINENT' }
  elseif ($o.Score -ge 60) { $o.Verdict = 'PERTINENT' }
  elseif ($o.Score -ge 35) { $o.Verdict = 'A REVOIR' }
  else { $o.Verdict = 'NON PERTINENT' }
  $o.Dest = switch ($kind) { 'rpg' { 'contributions/ (variante) + "Mes exemples" fiche 03' } 'cl' { '"Mes exemples" fiche 02 / contributions/' } 'dds' { 'fiche 04 (DDS) / contributions/' } 'sql' { 'fiche 04 (SQL) / contributions/' } default { 'fiche concernee (bloc "Mes exemples")' } }
  [void]$res.Add($o)
}

# ---- rapport
$md = New-Object System.Collections.ArrayList
[void]$md.Add('# Evaluation automatique des documents ajoutes'); [void]$md.Add('')
[void]$md.Add("Genere le $(Get-Date -Format 'yyyy-MM-dd HH:mm'). Score /100 = lien IBM i (40) + nouveaute (30) + comble un manque des fiches (20) + qualite (10). Verdict : PERTINENT (>= 60), A REVOIR (35-59, decision humaine), NON PERTINENT (< 35 ou aucun terme IBM i), DEJA PRESENT (copie d'une source), REJETE (secret, binaire, format interdit). C'est une aide a la decision : le proprietaire (ou l'assistant, voir CLAUDE.md section 6) relit avant integration.")
[void]$md.Add('')
if ($res.Count -eq 0) { [void]$md.Add('_Aucun document a evaluer pour le moment (deposer dans docs/apports/ ou contributions/)._') } else {
  [void]$md.Add('| Document | Type | Verdict | Score | Raisons | Destination suggeree |'); [void]$md.Add('|---|---|---|---|---|---|')
  foreach ($o in (Sort-By @($res) { $_.Verdict + '|' + (999 - [int]$_.Score).ToString('D3') + '|' + $_.Doc })) { [void]$md.Add("| $($o.Doc) | $($o.Kind) | **$($o.Verdict)** | $($o.Score) | $((($o.Reasons -join ' ; ') -replace '\|','/')) | $($o.Dest) |") }
}
$report = (($md -join "`n").TrimEnd() + "`n")
if (-not $Path) { [IO.File]::WriteAllText((Join-Path $Root 'docs/EVALUATION-APPORTS.md'), $report, (New-Object Text.UTF8Encoding($false))) }
if ($Summary -and $env:GITHUB_STEP_SUMMARY) { Add-Content -Path $env:GITHUB_STEP_SUMMARY -Value $report }
foreach ($o in $res) { Write-Output ("{0,-14} {1,3}  {2}  ({3})" -f $o.Verdict, $o.Score, $o.Doc, ($o.Reasons -join ' ; ')) }
Write-Output "Documents evalues : $($res.Count)"
if (@($res | Where-Object { $_.Verdict -eq 'REJETE' }).Count -gt 0) { exit 1 } else { exit 0 }
