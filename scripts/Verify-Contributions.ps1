# Verify-Contributions.ps1 - Verifie que tout ce qu'une contribution declare existe REELLEMENT dans sa bibliotheque.
# Usage : powershell -File Verify-Contributions.ps1 [-Only pseudo] [-Jobi]
#   -Jobi : verifie en plus commandes CL / instructions RPG avec Verify-Code.ps1 (necessite internet)
# Sortie : docs/VERIFICATION-CONTRIBUTIONS.md ; code de sortie 1 si au moins une ERREUR (avertissements = code 0).
param([string]$Root, [string]$Only, [switch]$Jobi)
if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }
. (Join-Path $PSScriptRoot 'Contrib-Common.ps1')
$list = Read-Contributions -Root $Root -Only $Only

# Objets connus du wiki (membres convertis) : une reference vers eux est consideree comme existante
$known = New-Set
$csv = Join-Path $Root 'docs\sources.csv'
if (Test-Path $csv) { foreach ($r in (Import-Csv $csv)) { [void]$known.Add($r.Member); [void]$known.Add($r.File) } }

$md = New-Object System.Collections.ArrayList
[void]$md.Add('# Verification des contributions'); [void]$md.Add('')
[void]$md.Add("Genere le $(Get-Date -Format 'yyyy-MM-dd HH:mm'). Controle : JSON valide, fichiers declares presents / non vides / texte / sans secret, chemins surs, fichiers orphelins, objets references (fichiers, copies, programmes) fournis ou declares dans `dependances`.")
[void]$md.Add('')
$errTotal = 0; $warnTotal = 0; $exTotal = 0
$rows = New-Object System.Collections.ArrayList
$detail = New-Object System.Collections.ArrayList

foreach ($c in $list) {
  $present = New-Set
  $libDir = Join-Path $c.Dir $c.Bib
  if ($c.Bib -and (Test-Path $libDir)) {
    foreach ($f in (Get-ChildItem $libDir -Recurse -File)) { [void]$present.Add([IO.Path]::GetFileNameWithoutExtension($f.Name)) }
  }
  foreach ($ex in $c.Exercises) {
    $defs = New-Set
    foreach ($f in $ex.Files) { if ($f.Ext -eq '.sql') { foreach ($n in (Get-SqlDefined $f.Text)) { [void]$defs.Add($n) } } }
    foreach ($f in $ex.Files) {
      foreach ($r in (Get-Refs $f.Text $f.Ext)) {
        $dep = @($ex.Dependances | ForEach-Object { ([string]$_) -split '[/.]' | Select-Object -Last 1 })
        if ($present.Contains($r) -or $defs.Contains($r) -or $known.Contains($r) -or ($dep -contains $r.ToUpper()) -or ($dep | Where-Object { $_ -ieq $r })) { continue }
        [void]$ex.Warnings.Add("reference '$r' (dans $($f.Rel)) : ni fournie dans la bibliotheque, ni declaree dans le champ dependances")
      }
      if ($Jobi -and $f.Ext -in '.clp','.clle','.cl','.rpgle','.rpg','.sqlrpgle') {
        try {
          $o = & (Join-Path $PSScriptRoot 'Verify-Code.ps1') -Path $f.Full 2>&1 | Out-String
          $fc = [string]([char]96) * 3
          $hd = '### ' + $c.Name + ' / ' + $ex.Id + ' / ' + $f.Rel
          $nl = [Environment]::NewLine
          [void]$detail.Add($hd + $nl + $nl + $fc + 'text' + $nl + $o.Trim() + $nl + $fc)
        } catch { [void]$ex.Warnings.Add('Verify-Code indisponible pour ' + $f.Rel + ' : ' + $_.Exception.Message) }
      }
    }
  }
  $e = $c.Errors.Count + (($c.Exercises | ForEach-Object { $_.Errors.Count } | Measure-Object -Sum).Sum)
  $w = $c.Warnings.Count + (($c.Exercises | ForEach-Object { $_.Warnings.Count } | Measure-Object -Sum).Sum)
  $errTotal += $e; $warnTotal += $w; $exTotal += $c.Exercises.Count
  $nf = ($c.Exercises | ForEach-Object { $_.Files.Count } | Measure-Object -Sum).Sum
  [void]$rows.Add("| $($c.Name) | $($c.Bib) | $($c.Exercises.Count) | $nf | $e | $w | $(if ($e -eq 0) {'OK'} else {'A CORRIGER'}) |")
  if ($e -gt 0 -or $w -gt 0) {
    [void]$detail.Add("### $($c.Name)`n")
    foreach ($m in $c.Errors) { [void]$detail.Add("- ERREUR : $m") }
    foreach ($ex in $c.Exercises) { foreach ($m in $ex.Errors) { [void]$detail.Add("- ERREUR [$($ex.Id)] : $m") } }
    foreach ($m in $c.Warnings) { [void]$detail.Add("- avertissement : $m") }
    foreach ($ex in $c.Exercises) { foreach ($m in $ex.Warnings) { [void]$detail.Add("- avertissement [$($ex.Id)] : $m") } }
    [void]$detail.Add('')
  }
}
if ($list.Count -eq 0) { [void]$md.Add('_Aucune contribution pour le moment._') }
else {
  [void]$md.Add('| Contributeur | Bibliotheque | Exercices | Fichiers | Erreurs | Avertissements | Statut |'); [void]$md.Add('|---|---|---|---|---|---|---|')
  foreach ($r in $rows) { [void]$md.Add($r) }
  [void]$md.Add('')
  if ($detail.Count) { [void]$md.Add('## Details'); [void]$md.Add(''); foreach ($x in $detail) { [void]$md.Add($x) } }
}
$out = Join-Path $Root 'docs\VERIFICATION-CONTRIBUTIONS.md'
if (-not $Only) { [IO.File]::WriteAllText($out, (($md -join "`n").TrimEnd() + "`n"), (New-Object Text.UTF8Encoding($false))) }
Write-Output "Contributions : $($list.Count) | exercices : $exTotal | erreurs : $errTotal | avertissements : $warnTotal"
foreach ($c in $list) {
  foreach ($m in $c.Errors) { Write-Output "ERREUR $($c.Name) : $m" }
  foreach ($ex in $c.Exercises) { foreach ($m in $ex.Errors) { Write-Output "ERREUR $($c.Name)/$($ex.Id) : $m" }; foreach ($m in $ex.Warnings) { Write-Output "avert. $($c.Name)/$($ex.Id) : $m" } }
}
if ($errTotal -gt 0) { exit 1 } else { exit 0 }

