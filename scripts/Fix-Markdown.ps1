# Fix-Markdown.ps1 - Corrige la mise en page Markdown : ligne vide avant/apres chaque tableau (hors blocs de code),
# supprime les espaces de fin de ligne et normalise les fins de ligne. Ne touche pas au contenu des blocs de code.
param([string]$Wiki = "C:\Users\ARM-NOTOS\Documents\IBM\wiki-ibmi")
$files = @(Get-ChildItem $Wiki -Recurse -Filter *.md | Where-Object { $_.FullName -notmatch '\\(sources|\.git)\\' })
$fixed = 0
foreach ($f in $files) {
  $src = (Get-Content $f.FullName -Raw -Encoding UTF8) -replace "`r`n", "`n"
  $in = $false; $prevTable = $false; $prevBlank = $true; $out = New-Object System.Collections.ArrayList
  foreach ($line in ($src -split "`n")) {
    if ($line -match '^\s*```') { $in = -not $in; [void]$out.Add($line); $prevTable = $false; $prevBlank = $false; continue }
    if ($in) { [void]$out.Add($line); continue }
    $l = $line.TrimEnd()
    $isTable = $l -match '^\s*\|.*\|\s*$'
    $isBlank = ($l -eq "")
    if ($isTable -and -not $prevTable -and -not $prevBlank) { [void]$out.Add("") }          # blanc avant tableau
    if (-not $isTable -and $prevTable -and -not $isBlank) { [void]$out.Add("") }             # blanc apres tableau
    [void]$out.Add($l); $prevTable = $isTable; $prevBlank = $isBlank
  }
  $new = (($out -join "`n") -replace "`n{3,}", "`n`n").TrimEnd() + "`n"
  $hasBom = ([IO.File]::ReadAllBytes($f.FullName) | Select-Object -First 3) -join ',' -eq '239,187,191'
  if ($new -ne $src -or $hasBom) { [IO.File]::WriteAllText($f.FullName, $new, (New-Object Text.UTF8Encoding($false))); $fixed++; Write-Output "corrige : $($f.FullName.Substring($Wiki.Length+1))" }
}
Write-Output "$fixed fichier(s) corrige(s) sur $($files.Count)."
