# Build-Contexte.ps1 - Assemble UN fichier de contexte (llms-full.txt) a donner a n'importe quel assistant (claude.ai, Claude Code, autre LLM).
# Contenu : regles du projet, fiches 01-06, enonces resumes, manques, exemples du cycle, portabilite.
# Lecture seule sur le depot sauf llms-full.txt. Fonctionne sous Windows PowerShell 5.1 et PowerShell 7. ASCII uniquement.
param([string]$Root)
if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }
$list = @('README.md','CLAUDE.md','docs/cheatsheets/README.md')
foreach ($f in (Get-ChildItem (Join-Path $Root 'docs/cheatsheets') -Filter '0*.md' | Sort-Object Name)) { $list += 'docs/cheatsheets/' + $f.Name }
$list += 'docs/enonces/README.md'
foreach ($f in (Get-ChildItem (Join-Path $Root 'docs/enonces') -Filter '*.md' | Where-Object { $_.Name -ne 'README.md' } | Sort-Object Name)) { $list += 'docs/enonces/' + $f.Name }
$list += @('docs/MANQUES.md','docs/CYCLE-GAP-EXEMPLES.md','docs/PORTABILITE.md','contributions/README.md','docs/apports/README.md')
$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('# Wiki IBM i : contexte complet pour un assistant')
[void]$sb.AppendLine('')
[void]$sb.AppendLine("Genere le $(Get-Date -Format 'yyyy-MM-dd HH:mm') a partir du depot https://github.com/dylan-bialade/wiki-ibm (public). Source de verite : le depot ; ce fichier n'en est qu'un extrait lisible d'un seul tenant.")
[void]$sb.AppendLine('Usage : donne ce fichier a l''assistant (instructions de projet, piece jointe, ou URL brute https://raw.githubusercontent.com/dylan-bialade/wiki-ibm/main/llms-full.txt). Les sources de code converties (sources/) et les index detailles ne sont PAS inclus : voir llms.txt et docs/INDEX-SOURCES.md dans le depot.')
$n = 0
foreach ($rel in $list) {
  $p = Join-Path $Root $rel
  if (-not (Test-Path $p)) { continue }
  $t = [IO.File]::ReadAllText($p).TrimEnd()
  [void]$sb.AppendLine(''); [void]$sb.AppendLine(''); [void]$sb.AppendLine("=== FICHIER : $rel ===")
  [void]$sb.AppendLine($t)
  $n++
}
$out = Join-Path $Root 'llms-full.txt'
[IO.File]::WriteAllText($out, ($sb.ToString().TrimEnd() + "`n"), (New-Object Text.UTF8Encoding($false)))
Write-Output ("OK : llms-full.txt ({0} fichiers, {1} Ko)" -f $n, [math]::Round((Get-Item $out).Length / 1KB))
