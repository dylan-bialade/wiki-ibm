# Verify-Code.ps1 - Verifie un source CL ou RPG (nouveau code) contre la reference https://job-i.fr/
# Usage : powershell -File Verify-Code.ps1 -Path C:\chemin\MONPGM.clp   (ou .rpgle, .sqlrpgle, .md avec bloc de code, ou -Code "texte")
# Sortie : liste des commandes CL / instructions / fonctions RPG reconnues, et des mots a controler.
param([string]$Path, [string]$Code, [ValidateSet("auto","cl","rpg")][string]$Lang = "auto")
$ErrorActionPreference = "Stop"
$base = "https://job-i.fr"
if ($Path) { $Code = Get-Content $Path -Raw -Encoding UTF8; if ($Lang -eq "auto") { $Lang = if ($Path -match '\.(clp|clle|cl)$') {"cl"} else {"rpg"} } }
if (-not $Code) { throw "Fournir -Path ou -Code" }
if ($Lang -eq "auto") { $Lang = if ($Code -match '(?im)^\s*PGM\b|DCLF|MONMSG') {"cl"} else {"rpg"} }

$cache = Join-Path ([IO.Path]::GetTempPath()) "jobi-ref-cache.json"
if ((Test-Path $cache) -and ((Get-Item $cache).LastWriteTime -gt (Get-Date).AddHours(-24))) { $ref = Get-Content $cache -Raw | ConvertFrom-Json }
else {
  function Page($p) { (Invoke-WebRequest "$base$p" -UseBasicParsing -TimeoutSec 60).Content }
  $cmds = [regex]::Matches((Page "/commandes-ibm-i"), 'data-code="([A-Z0-9_]+)"') | % { $_.Groups[1].Value } | Sort-Object -Unique
  $rpg = @(); foreach ($p in "/instructions-rpg","/fonctions-rpg","/coder-rpg-iii") { $rpg += [regex]::Matches((Page $p), '>(%?[A-Z][A-Z0-9_-]{1,10})<') | % { $_.Groups[1].Value } }
  $ref = [pscustomobject]@{ cmds = @($cmds); rpg = @($rpg | Sort-Object -Unique) }
  $ref | ConvertTo-Json | Set-Content $cache -Encoding utf8
}
$cmdSet = [System.Collections.Generic.HashSet[string]]::new([string[]]@($ref.cmds))
$rpgSet = [System.Collections.Generic.HashSet[string]]::new([string[]]@($ref.rpg))
$cl = "PGM","ENDPGM","DCL","IF","THEN","ELSE","DO","ENDDO","GOTO","MONMSG","CALLSUBR","SUBR","ENDSUBR","RETURN","CHGVAR","DCLF","SELECT","WHEN","OTHERWISE","ENDSELECT"
$ctl = [System.Collections.Generic.HashSet[string]]::new([string[]]$cl)

$found = @{}; $unknown = @{}
if ($Lang -eq "cl") {
  foreach ($l in ($Code -split "`n")) {
    $t = $l.TrimEnd("`r")
    if ($t -match '^\s*/\*' -or $t -match '^```') { continue }
    if ($t -match '^\s*(?:[A-Z0-9_]+:\s*)?([A-Z][A-Z0-9]{2,9})\b') {
      $k = $Matches[1]; if ($ctl.Contains($k)) { continue }
      if ($cmdSet.Contains($k)) { $found[$k] = 1 + [int]$found[$k] } else { $unknown[$k] = 1 + [int]$unknown[$k] }
    }
  }
} else {
  foreach ($l in ($Code -split "`n")) {
    if ($l -match '^\s*(//|\*|```)') { continue }
    foreach ($m in [regex]::Matches($l.ToUpper(), '(?<![A-Z0-9_])(%?[A-Z][A-Z0-9_-]{1,10})(?![A-Z0-9_])')) {
      $k = $m.Groups[1].Value
      if ($k.StartsWith('%') -or $k -match '^(DCL-|END-)') { if ($rpgSet.Contains($k)) { $found[$k] = 1 + [int]$found[$k] } elseif ($k.StartsWith('%')) { $unknown[$k] = 1 + [int]$unknown[$k] } }
      elseif ($rpgSet.Contains($k)) { $found[$k] = 1 + [int]$found[$k] }
    }
  }
}
Write-Output "Langage : $Lang  |  Reference job-i : $($cmdSet.Count) commandes, $($rpgSet.Count) termes RPG"
Write-Output "RECONNUS ($($found.Count)) :"
$found.Keys | Sort-Object | % { $u = if ($Lang -eq "cl") { "$base/commandes-ibm-i/$($_.ToLower())" } else { "$base/aller?q=$([uri]::EscapeDataString($_))" }; Write-Output ("  {0,-12} x{1}  {2}" -f $_, $found[$_], $u) }
Write-Output "A CONTROLER ($($unknown.Count)) : $((($unknown.Keys | Sort-Object) -join ', '))"
if ($unknown.Count -gt 0) { Write-Output "(variable, label, objet utilisateur, ou commande/fonction inexistante : verifier a la main)" }
