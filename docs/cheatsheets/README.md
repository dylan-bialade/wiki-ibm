# Cheat sheets IBM i (d'après job-i.fr)

Dernière mise à jour : 2026-11-21
- 2026-11-21 : fiche 01 (PTF : types, groupes SF999xx, contrôles, pièges CPF0006/CPF3575) et fiche 06 (cycle : versions du format libre) mises à jour d'après job-i ; fiche 06 BEGSR : aucun changement de fond.
- 2026-11-19 : fiche 06 mise à jour (job-i : concordance `MR` et erreur RPG1031, `*INZSR`, cycle toujours valable en 7.5 / 7.6) ; fiche 03 : apports `%LOWER` / `%UPPER` et tableaux `CTDATA` / `ALT` (vérifiés sur ibm.com, limites non vérifiées signalées).
- Fiche 02 : messages 13 213 (107 fiches « Comment s'en sortir »). Fiche 03 : ajout de la page `/rpg-iii` (79 codes opération en 10 familles), chiffres site (54 instructions, 95 fonctions). Fiche 05 : offres 176. Fiches 01, 04, 06 : aucun changement détecté (commandes 1 830, services SQL 390, valeurs système 158, recettes 36 inchangés).

| Fiche | Contenu |
|---|---|
| [01 - Comprendre IBM i](01-comprendre-ibm-i.md) | objets, ILE, travaux, profils, sécurité, PTF, performances |
| [02 - Référence système](02-reference-systeme.md) | commandes CL, messages, valeurs système |
| [03 - RPG par version](03-rpg-par-version.md) | RPG III, RPG IV colonné, full free, PR/PI, sous-fichiers, DTAARA, API |
| [04 - Db2 for i et SQL](04-db2-for-i-et-sql.md) | PF, LF, services SQL, recettes, Node.js |
| [05 - Emploi et formation](05-emploi-et-formation.md) | offres, formation, structure du site |
| [06 - Cycle RPG et sous-routines](06-cycle-rpg-et-sous-routines.md) | cycle GAP (7 étapes, indicateurs), BEGSR/EXSR, exemples du dépôt |
| [07 - SQL embarqué en RPG](07-sql-embarque-en-rpg.md) | CRTSQLRPGI, RUNSQL, RUNSQLSTM, curseurs et SQLCODE d'après le code |
| [08 - Impression et printer IBM i](08-impression-et-printer-ibm-i.md) | fichiers imprimante, spools, OUTQ, CRTPRTF, OVRPRTF, CPYSPLF, exemples |

## Règles de mise à jour
- Chaque fiche a un bloc `<!-- AUTO:START --> … <!-- AUTO:END -->` : il est **régénéré** par la tâche mensuelle à partir de job-i.fr.
- La section **« Mes exemples »** (sous le bloc) n'est **jamais écrasée** : c'est là que vont vos exemples.
- Vos apports : déposez notes, fichiers, extraits dans [`../apports/`](../apports/README.md) ; la tâche les intègre dans « Mes exemples » de la fiche concernée.
- Contenu de job-i.fr : synthèses personnelles avec lien vers la page source, pas de copie intégrale.
