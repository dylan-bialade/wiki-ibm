# Contrib-Common.ps1 - Lecture et validation des contributions (dossier contributions/). A charger avec : . .\Contrib-Common.ps1
# Compatible Windows PowerShell 5.1 et PowerShell 7. Fichier volontairement en ASCII.
$script:AllowedExt = @('.rpgle','.rpg','.sqlrpgle','.rpgleinc','.clp','.clle','.cl','.dds','.pf','.lf','.dspf','.prtf','.sql','.txt','.md','.cpy','.mnu')
$script:Langs      = @('RPG-III','RPG-ILE','RPG-free','CL','DDS','SQL','Autre')
$script:SecretHard = 'github_pat_[A-Za-z0-9_]{20,}|ghp_[A-Za-z0-9]{30,}|AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY'
$script:SecretSoft = '(?i)\b(password|passwd|mot_?de_?passe|token|secret|api[_-]?key)\b\s*[=:]\s*[''"]?\w{4,}'

function New-Set { New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::OrdinalIgnoreCase) }

function Get-Refs([string]$Text, [string]$Ext) {
  # Noms d'objets references par un source (fichiers, copies, programmes appeles). Heuristique : les resultats sont des avertissements.
  $refs = New-Set
  if ($Ext -in '.sql','.md','.txt') { return $refs }
  $isFree = $Text -match '(?im)^\*\*free'
  foreach ($line in ($Text -split "`n")) {
    $l = $line.TrimEnd("`r")
    $t = $l.TrimStart()
    if ($t.StartsWith('//') -or $t.StartsWith('/*')) { continue }
    if (-not $isFree -and $l.Length -gt 6 -and $l[6] -eq '*') { continue }
    foreach ($rx in @(
      '(?i)\bdcl-f\s+([A-Z0-9#@$_]+)',
      '(?i)/copy\s+(?:[A-Z0-9#@$_]+[,/])?([A-Z0-9#@$_]+)',
      '(?i)\bDCLF\s+FILE\((?:[A-Z0-9#@$_]+/)?([A-Z0-9#@$_]+)\)',
      '(?i)\bCALL\s+PGM\((?:[A-Z0-9#@$_]+/)?([A-Z0-9#@$_]+)\)',
      "(?i)\bCALL\s+'([A-Z0-9#@$_]+)'")) {
      foreach ($m in [regex]::Matches($l, $rx)) { [void]$refs.Add($m.Groups[1].Value) }
    }
    if (-not $isFree) {
      $m = [regex]::Match($l, '^.{5}F([A-Za-z0-9#@$_]{1,10})\s+[IOUC][PSFRDT ]')
      if ($m.Success) { [void]$refs.Add($m.Groups[1].Value) }
    }
  }
  return $refs
}

function Get-SqlDefined([string]$Text) {
  $d = New-Set
  foreach ($m in [regex]::Matches($Text, '(?i)CREATE\s+(?:OR\s+REPLACE\s+)?(?:TABLE|VIEW|INDEX|ALIAS)\s+(?:[A-Z0-9#@$_]+[./])?([A-Z0-9#@$_]+)')) { [void]$d.Add($m.Groups[1].Value) }
  return $d
}

function Read-Contributions {
  param([string]$Root, [string]$Only)
  $base = Join-Path $Root 'contributions'
  $res = New-Object System.Collections.ArrayList
  if (-not (Test-Path $base)) { return ,$res }
  foreach ($d in (Get-ChildItem $base -Directory | Where-Object { $_.Name -notlike '_*' })) {
    if ($Only -and $d.Name -ne $Only) { continue }
    $c = [pscustomobject]@{ Dir=$d.FullName; Name=$d.Name; Auteur=$null; Bib=$null; Errors=(New-Object System.Collections.ArrayList); Warnings=(New-Object System.Collections.ArrayList); Exercises=(New-Object System.Collections.ArrayList); Orphans=0 }
    $jf = Join-Path $d.FullName 'contribution.json'
    if (-not (Test-Path $jf)) { [void]$c.Errors.Add('contribution.json manquant'); [void]$res.Add($c); continue }
    $j = $null
    try { $j = (Get-Content $jf -Raw -Encoding UTF8) | ConvertFrom-Json } catch { [void]$c.Errors.Add("contribution.json invalide : $($_.Exception.Message)"); [void]$res.Add($c); continue }
    $c.Auteur = [string]$j.auteur; $c.Bib = [string]$j.bibliotheque
    if ($c.Auteur -ne $d.Name) { [void]$c.Errors.Add("auteur '$($c.Auteur)' different du nom du dossier '$($d.Name)'") }
    if ($d.Name -notmatch '^[a-z0-9][a-z0-9-]{1,38}$') { [void]$c.Errors.Add("nom de dossier '$($d.Name)' invalide (minuscules, chiffres, tirets)") }
    if ($c.Bib -notmatch '^[A-Z][A-Z0-9_#@$]{0,9}$') { [void]$c.Errors.Add("bibliotheque '$($c.Bib)' invalide (MAJUSCULES, 10 car. max)") ; [void]$res.Add($c); continue }
    $libDir = Join-Path $d.FullName $c.Bib
    if (-not (Test-Path $libDir)) { [void]$c.Errors.Add("dossier de bibliotheque '$($c.Bib)' manquant"); [void]$res.Add($c); continue }
    $libFull = [IO.Path]::GetFullPath($libDir).TrimEnd('\','/') + [IO.Path]::DirectorySeparatorChar
    $declared = New-Set
    if (-not $j.exercices) { [void]$c.Errors.Add('aucun exercice declare') }
    foreach ($e in @($j.exercices)) {
      $ex = [pscustomobject]@{ Id=[string]$e.id; Titre=[string]$e.titre; Consigne=[string]$e.consigne; Resultat=[string]$e.resultat_attendu; Langage=[string]$e.langage; Approche=[string]$e.approche; Dependances=@($e.dependances | Where-Object { $_ }); Files=(New-Object System.Collections.ArrayList); Errors=(New-Object System.Collections.ArrayList); Warnings=(New-Object System.Collections.ArrayList) }
      if ($ex.Id -notmatch '^[a-z0-9][a-z0-9-]{2,60}$') { [void]$ex.Errors.Add("id '$($ex.Id)' invalide (minuscules, chiffres, tirets)") }
      foreach ($f in 'Titre','Consigne','Resultat','Approche') { if (-not $ex.$f -or $ex.$f.Trim().Length -lt 5) { [void]$ex.Errors.Add("champ '$f' manquant ou trop court") } }
      if ($ex.Langage -notin $script:Langs) { [void]$ex.Errors.Add("langage '$($ex.Langage)' inconnu (valeurs : $($script:Langs -join ', '))") }
      if (-not $e.fichiers -or @($e.fichiers).Count -eq 0) { [void]$ex.Errors.Add('aucun fichier declare') }
      foreach ($rel in @($e.fichiers)) {
        $rel = [string]$rel
        if ([IO.Path]::IsPathRooted($rel) -or $rel -match '\.\.') { [void]$ex.Errors.Add("chemin interdit : $rel"); continue }
        $full = [IO.Path]::GetFullPath((Join-Path $libDir $rel))
        if (-not $full.StartsWith($libFull, [StringComparison]::OrdinalIgnoreCase)) { [void]$ex.Errors.Add("chemin hors de la bibliotheque : $rel"); continue }
        if (-not (Test-Path -LiteralPath $full -PathType Leaf)) { [void]$ex.Errors.Add("fichier declare mais INEXISTANT : $($c.Bib)/$rel"); continue }
        [void]$declared.Add($full)
        $ext = [IO.Path]::GetExtension($full).ToLower()
        if ($ext -notin $script:AllowedExt) { [void]$ex.Errors.Add("extension non autorisee ($ext) : $rel"); continue }
        $bytes = [IO.File]::ReadAllBytes($full)
        if ($bytes.Length -eq 0) { [void]$ex.Errors.Add("fichier vide : $rel"); continue }
        if ($bytes.Length -gt 512KB) { [void]$ex.Errors.Add("fichier trop gros (>512 Ko) : $rel"); continue }
        if ($bytes -contains 0) { [void]$ex.Errors.Add("fichier binaire (octet nul) : $rel"); continue }
        $text = [Text.Encoding]::UTF8.GetString($bytes).TrimStart([char]0xFEFF)
        if ($text -match $script:SecretHard) { [void]$ex.Errors.Add("secret detecte (cle/jeton) dans $rel"); continue }
        if ($text -match $script:SecretSoft) { [void]$ex.Warnings.Add("mot de passe / jeton possible dans $rel : a verifier") }
        $nl = ($text -split "`n").Count
        [void]$ex.Files.Add([pscustomobject]@{ Rel=$rel; Full=$full; Ext=$ext; Lines=$nl; Text=$text })
      }
      [void]$c.Exercises.Add($ex)
    }
    $dupe = $c.Exercises | Group-Object Id | Where-Object { $_.Count -gt 1 }
    foreach ($g in $dupe) { [void]$c.Errors.Add("id d'exercice en double : $($g.Name)") }
    foreach ($f in (Get-ChildItem $libDir -Recurse -File)) { if (-not $declared.Contains($f.FullName)) { $c.Orphans++; [void]$c.Warnings.Add("fichier present mais non declare dans un exercice : $($f.FullName.Substring($libFull.Length))") } }
    [void]$res.Add($c)
  }
  return ,$res
}

function Get-Techniques([string]$Text) {
  $map = [ordered]@{
    'full free'            = '(?im)^\*\*free'
    'sous-fichier'         = '(?i)\bSFILE\b|\bSFL(CTL|DSP|PAG|SIZ)?\b'
    'ecran (WORKSTN)'      = '(?i)\bWORKSTN\b|\bEXFMT\b'
    'SQL embarque'         = '(?i)exec\s+sql'
    'curseur SQL'          = '(?i)DECLARE\s+\w+\s+(?:\w+\s+)?CURSOR'
    'jointure'             = '(?i)\bJOIN\b|\bJFILE\b'
    'CHAIN'                = '(?i)\bCHAIN\b'
    'SETLL / READ'         = '(?i)\bSETLL\b|\bREADE?\b'
    'boucle DOW/DOU/FOR'   = '(?i)\b(DOW|DOU|FOR|DOWEQ|DOUEQ|DO)\b'
    'procedures (dcl-proc)'= '(?i)\bdcl-proc\b|\bBEGSR\b'
    'prototypes (dcl-pr)'  = '(?i)\bdcl-pr\b|\bdcl-pi\b'
    'structure de donnees' = '(?i)\bdcl-ds\b'
    'indicateurs *INxx'    = '(?i)\*IN\d\d'
    'gestion d erreur'     = '(?i)\bMONITOR\b|\bMONMSG\b|\(E\)'
    'CL : DCLF'            = '(?i)\bDCLF\b'
    'CREATE TABLE/VIEW'    = '(?i)CREATE\s+(OR\s+REPLACE\s+)?(TABLE|VIEW|INDEX)'
    'DDS (R/K/PFILE)'      = '(?im)^.{5}A\s+(R\s|K\s|PFILE|JFILE)'
  }
  $out = New-Object System.Collections.ArrayList
  foreach ($k in $map.Keys) { if ($Text -match $map[$k]) { [void]$out.Add($k) } }
  return ,$out
}
