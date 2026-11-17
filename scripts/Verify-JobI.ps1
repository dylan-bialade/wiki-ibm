# Verify-JobI.ps1 - Recoupe le code du wiki avec les references du site https://job-i.fr/
# Telecharge les listes de reference (commandes CL, instructions et fonctions RPG) puis compare avec le code.
param([string]$Wiki = (Split-Path -Parent $PSScriptRoot))
function Sort-Ord($a){ $arr=[string[]]@($a); [Array]::Sort($arr,[StringComparer]::Ordinal); $arr }
$ErrorActionPreference = "Stop"
$base = "https://job-i.fr"
function Get-Page($p) { for ($try = 1; $try -le 4; $try++) { try { return (Invoke-WebRequest "$base$p" -UseBasicParsing -TimeoutSec 60).Content } catch { if ($try -eq 4) { throw }; Start-Sleep -Seconds (2 * $try) } } }

$cmds = [regex]::Matches((Get-Page "/commandes-ibm-i"), 'data-code="([A-Z0-9_]+)"') | % { $_.Groups[1].Value } | Sort-Object -Unique
$rpg  = @()
foreach ($p in "/instructions-rpg","/fonctions-rpg","/coder-rpg-iii") {
  try { $rpg += [regex]::Matches((Get-Page $p), '>(%?[A-Z][A-Z0-9_-]{1,10})<') | % { $_.Groups[1].Value } } catch { Write-Warning "$p : $($_.Exception.Message)" }
}
$rpg = $rpg | Sort-Object -Unique

$cmdSet = [System.Collections.Generic.HashSet[string]]::new([string[]]@($cmds))
$rpgSet = [System.Collections.Generic.HashSet[string]]::new([string[]]@($rpg))
$ctl = "PGM","ENDPGM","DCL","IF","ELSE","DO","ENDDO","GOTO","MONMSG","CALLSUBR","SUBR","ENDSUBR","RETURN","CHGVAR","SNDPGMMSG","DCLF","SELECT","WHEN","OTHERWISE","ENDSELECT"
$ctlSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$ctl)

$usedCmd = @{}; $usedRpg = @{}
foreach ($f in Get-ChildItem (Join-Path $Wiki "sources/CL") -Recurse -Filter *.md -ErrorAction SilentlyContinue) {
  foreach ($l in (Get-Content $f.FullName -Encoding UTF8)) {
    if ($l -match '^\s*(?:[A-Z0-9_]+:\s*)?([A-Z][A-Z0-9]{2,9})\b' -and $l -notmatch '^\s*/\*') { $usedCmd[$Matches[1]] = 1 + [int]$usedCmd[$Matches[1]] }
  }
}
foreach ($f in Get-ChildItem (Join-Path $Wiki "sources/RPG") -Recurse -Filter *.md -ErrorAction SilentlyContinue) {
  foreach ($l in (Get-Content $f.FullName -Encoding UTF8)) {
    foreach ($t in [regex]::Matches($l.ToUpper(), '(?<![A-Z0-9_])(%?[A-Z][A-Z0-9_-]{2,9})(?![A-Z0-9_])')) { $v = $t.Value; if ($rpgSet.Contains($v)) { $usedRpg[$v] = 1 + [int]$usedRpg[$v] } }
  }
}

$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine("# Verification par rapport a job-i.fr`n")
[void]$sb.AppendLine("Genere le $(Get-Date -Format 'yyyy-MM-dd HH:mm'). Reference : $($cmdSet.Count) commandes CL, $($rpgSet.Count) termes RPG.`n")
[void]$sb.AppendLine("## Commandes CL utilisees`n"); [void]$sb.AppendLine("| Commande | Occurrences | Statut | Fiche job-i |"); [void]$sb.AppendLine("|---|---|---|---|")
$unk = @()
foreach ($k in (Sort-Ord $usedCmd.Keys)) {
  if ($ctlSet.Contains($k)) { continue }
  if ($cmdSet.Contains($k)) { [void]$sb.AppendLine("| $k | $($usedCmd[$k]) | verifiee | [$base/commandes-ibm-i/$($k.ToLower())]($base/commandes-ibm-i/$($k.ToLower())) |") } else { $unk += $k }
}
[void]$sb.AppendLine("`n### A controler manuellement (absentes de la liste job-i : variable, label, objet utilisateur ?)`n")
if ($unk) { [void]$sb.AppendLine(($unk -join ", ")) } else { [void]$sb.AppendLine("_aucune_") }
[void]$sb.AppendLine("`n## Instructions / fonctions RPG reconnues`n"); [void]$sb.AppendLine("| Terme | Occurrences |"); [void]$sb.AppendLine("|---|---|")
foreach ($k in (Sort-Ord $usedRpg.Keys)) { [void]$sb.AppendLine("| $k | $($usedRpg[$k]) |") }
$sb.ToString() | Set-Content (Join-Path $Wiki "docs/VERIFICATION-JOB-I.md") -Encoding utf8
"OK : $(@($usedCmd.Keys).Count) tokens CL analyses, $($unk.Count) a controler ; $(@($usedRpg.Keys).Count) termes RPG reconnus."
