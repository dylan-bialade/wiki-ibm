# Build-Variantes.ps1 - Regroupe les contributions par exercice (meme id) et genere un comparatif des variantes.
# Sortie : docs/VARIANTES.md (index) + docs/variantes/<id>.md (une page par exercice : consigne, resultat, tableau, differences, codes).
param([string]$Root)
if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }
. (Join-Path $PSScriptRoot 'Contrib-Common.ps1')
$list = Read-Contributions -Root $Root
$vdir = Join-Path $Root 'docs\variantes'
New-Item -ItemType Directory -Force $vdir | Out-Null
$analyse = @{}   # conserve la section "## Analyse" ajoutee a la main sous chaque page
foreach ($old in (Get-ChildItem $vdir -Filter *.md -ErrorAction SilentlyContinue)) {
  $txt = [IO.File]::ReadAllText($old.FullName); $i = $txt.IndexOf("`n## Analyse")
  if ($i -ge 0) { $analyse[$old.BaseName] = $txt.Substring($i).TrimEnd() }
  Remove-Item $old.FullName -Force
}
$utf8 = New-Object Text.UTF8Encoding($false)

$vars = New-Object System.Collections.ArrayList
foreach ($c in $list) {
  if ($c.Errors.Count -gt 0) { continue }   # contribution invalide : ignoree
  foreach ($ex in $c.Exercises) {
    if ($ex.Errors.Count -gt 0) { continue }
    $all = ($ex.Files | ForEach-Object { $_.Text }) -join "`n"
    [void]$vars.Add([pscustomobject]@{ Id=$ex.Id; Auteur=$c.Name; Bib=$c.Bib; Ex=$ex; Tech=(Get-Techniques $all); Lines=(($ex.Files | Measure-Object Lines -Sum).Sum) })
  }
}

function Norm([string]$s) { ($s.ToLower() -replace '\s+', ' ').Trim() }
function Fence([string]$lang) { if ($lang -in 'RPG-ILE','RPG-III') { 'text' } elseif ($lang -eq 'RPG-free') { 'rpg' } elseif ($lang -eq 'CL') { 'cl' } elseif ($lang -eq 'SQL') { 'sql' } else { 'text' } }

$idx = New-Object System.Collections.ArrayList
foreach ($g in ($vars | Group-Object Id | Sort-Object Name)) {
  $first = $g.Group[0].Ex
  $p = New-Object System.Collections.ArrayList
  [void]$p.Add("# $($first.Titre)"); [void]$p.Add('')
  [void]$p.Add("- Identifiant : ``$($g.Name)`` - $($g.Count) variante(s)")
  [void]$p.Add('- Navigation : [index des variantes](../VARIANTES.md) | [contributions](../../contributions/README.md)'); [void]$p.Add('')
  [void]$p.Add('## Consigne'); [void]$p.Add(''); [void]$p.Add($first.Consigne.Trim()); [void]$p.Add('')
  [void]$p.Add('## Resultat final attendu'); [void]$p.Add('')
  $results = @($g.Group | Group-Object { Norm $_.Ex.Resultat })
  if ($results.Count -eq 1) { [void]$p.Add($first.Resultat.Trim()); [void]$p.Add(''); [void]$p.Add('_Toutes les variantes declarent le meme resultat._') }
  else {
    [void]$p.Add('**Attention : les variantes ne declarent pas le meme resultat (exercice peut-etre different, a verifier).**'); [void]$p.Add('')
    foreach ($v in $g.Group) { [void]$p.Add("- **$($v.Auteur)** : $($v.Ex.Resultat.Trim())") }
  }
  [void]$p.Add('')
  [void]$p.Add('## Comparatif'); [void]$p.Add('')
  [void]$p.Add('| Auteur | Bibliotheque | Langage | Fichiers | Lignes | Techniques | Approche |'); [void]$p.Add('|---|---|---|---|---|---|---|')
  foreach ($v in ($g.Group | Sort-Object Lines)) {
    [void]$p.Add("| $($v.Auteur) | $($v.Bib) | $($v.Ex.Langage) | $($v.Ex.Files.Count) | $($v.Lines) | $($v.Tech -join ', ') | $(($v.Ex.Approche.Trim() -replace '\|','/' -replace '\r?\n',' ')) |")
  }
  [void]$p.Add('')
  if ($g.Count -gt 1) {
    [void]$p.Add('## Differences entre variantes'); [void]$p.Add('')
    $allTech = @($g.Group | ForEach-Object { $_.Tech } | Select-Object -Unique)
    $common = @($allTech | Where-Object { $t = $_; @($g.Group | Where-Object { $_.Tech -contains $t }).Count -eq $g.Count })
    if ($common.Count) { [void]$p.Add("- Points communs : $($common -join ', ')") }
    foreach ($v in $g.Group) {
      $only = @($v.Tech | Where-Object { $common -notcontains $_ })
      if ($only.Count) { [void]$p.Add("- **$($v.Auteur)** (en plus / en propre) : $($only -join ', ')") }
    }
    $langs = @($g.Group | ForEach-Object { $_.Ex.Langage } | Select-Object -Unique)
    if ($langs.Count -gt 1) { [void]$p.Add("- Langages differents : $($langs -join ', ')") }
    $s = $g.Group | Sort-Object Lines
    [void]$p.Add("- Taille : de $($s[0].Lines) lignes ($($s[0].Auteur)) a $($s[-1].Lines) lignes ($($s[-1].Auteur))")
    [void]$p.Add('')
  }
  [void]$p.Add('## Codes'); [void]$p.Add('')
  foreach ($v in $g.Group) {
    [void]$p.Add("### $($v.Auteur) - $($v.Ex.Langage) ($($v.Bib))"); [void]$p.Add('')
    foreach ($f in $v.Ex.Files) {
      $rel = "../../contributions/$($v.Auteur)/$($v.Bib)/$($f.Rel -replace '\\','/')"
      [void]$p.Add("Fichier : [$($f.Rel)]($rel) ($($f.Lines) lignes)"); [void]$p.Add('')
      if ($f.Lines -le 250) { [void]$p.Add('```' + (Fence $v.Ex.Langage)); [void]$p.Add($f.Text.TrimEnd()); [void]$p.Add('```'); [void]$p.Add('') }
      else { [void]$p.Add('_Fichier long : voir le lien ci-dessus._'); [void]$p.Add('') }
    }
  }
  if ($analyse.ContainsKey($g.Name)) { [void]$p.Add(""); [void]$p.Add($analyse[$g.Name].TrimStart()) }
  [IO.File]::WriteAllText((Join-Path $vdir "$($g.Name).md"), (($p -join "`n").TrimEnd() + "`n"), $utf8)
  [void]$idx.Add("| [$($g.Name)](variantes/$($g.Name).md) | $($first.Titre) | $($g.Count) | $((@($g.Group | ForEach-Object { $_.Ex.Langage } | Select-Object -Unique)) -join ', ') | $((@($g.Group | ForEach-Object { $_.Auteur })) -join ', ') |")
}

$m = New-Object System.Collections.ArrayList
[void]$m.Add('# Variantes : memes exercices, solutions differentes'); [void]$m.Add('')
[void]$m.Add("Genere le $(Get-Date -Format 'yyyy-MM-dd HH:mm'). Source : dossier [contributions](../contributions/README.md), verifie par [VERIFICATION-CONTRIBUTIONS](VERIFICATION-CONTRIBUTIONS.md). Un exercice = un identifiant ; chaque contributeur apporte sa propre structure et son code pour le meme resultat final.")
[void]$m.Add('')
if ($idx.Count -eq 0) { [void]$m.Add('_Aucune variante pour le moment._') }
else { [void]$m.Add('| Exercice | Titre | Variantes | Langages | Auteurs |'); [void]$m.Add('|---|---|---|---|---|'); foreach ($r in $idx) { [void]$m.Add($r) } }
[IO.File]::WriteAllText((Join-Path $Root 'docs\VARIANTES.md'), (($m -join "`n").TrimEnd() + "`n"), $utf8)
Write-Output "OK : $($vars.Count) variante(s) sur $($idx.Count) exercice(s)."
