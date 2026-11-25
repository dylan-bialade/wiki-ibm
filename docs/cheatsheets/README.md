# Cheat sheets IBM i (d'après job-i.fr)

Dernière mise à jour : 2026-11-25
- 2026-11-25 : détection `sitemap-pages` (lastmod 11-23 → 11-24) : seules les pages d'offres d'emploi ont une date récente (2026-11-25) ; fiche 05 mise à jour (124 offres par département, 24 départements d'après la synthèse). Aucune autre page source modifiée depuis le 2026-11-22. Apport IWS intégré à la fiche 03.
- 2026-11-23 (comparaison de texte, limites) : l'ancien texte des pages n'est pas conservé (le suivi ne garde que des empreintes) et aucun instantané d'archive n'existe : un **avant/après exact est impossible**. Contrôles faits à la place : (1) date de modification par page dans `sitemap-pages.xml` : 22 pages sources ont été modifiées le **2026-11-22** (api-systeme, as400-vs-ibm-i, coder-rpg-iii, cycle-gap-rpg, fichier-physique-pf, ile, installer-ptf, mots-edition, navigator-for-i, nodejs, objets, outq, performances, profils-utilisateurs, prototypes-rpg-pr-pi, securite, se-former, sous-fichier-rpg, travaux, zone-de-donnees-dtaara) ; `commandes-ibm-i` (2026-09-29) et `messages-ibm-i` (2026-09-30) n'ont pas de modification récente, `recettes-sql`, `services-sql` et `valeurs-systeme` n'ont pas de date dans ce sitemap ; (2) deux lectures successives du même jour donnent des pages identiques (pas de contenu qui varie à chaque lecture) ; (3) **les termes techniques entre accents graves cités dans les blocs AUTO** (commandes, paramètres, fonctions, services SQL) ont été cherchés dans les pages : tous présents, **aucune affirmation de fiche contredite ou retirée au niveau des termes** ; (4) la couverture des titres de sections n'est pas un indicateur de changement (les fiches résument, elles ne reprennent pas chaque section). **Non contrôlé** : reformulation du sens d'un paragraphe, nouveaux paragraphes non cités dans les fiches.
- 2026-11-23 (relecture après la détection `Check-JobIUpdates` : 25 pages signalées modifiées depuis le 17/11) : tous les nombres des blocs AUTO des fiches 01, 02, 03, 04, 06 et 08 ont été recherchés dans le texte actuel de leurs pages job-i sources (34 pages relues) : **aucun nombre périmé** (hors exemples de code de la fiche 08 et règle de colonnes de la fiche 03, qui ne viennent pas d'une page). Fiche 05 : 133 offres localisées dans 30 départements relevées plus tard le même jour. **Non contrôlé** : les changements de texte sans nombre (reformulations, nouveaux paragraphes) : seul le contrôle des chiffres a été fait.
- 2026-11-23 : fiche 01 : ajout de la nouvelle page job-i `/navigator-for-i` (IBM Navigator for i : ports, STRTCPSVR `*ADMIN`, NAV_300068). Fiche 05 : offres 176 → 144. Chiffres inchangés : commandes 1 830, messages 13 213 (107 fiches), services SQL 390, valeurs système 158, recettes 36, instructions RPG 54, fonctions 95, codes RPG III 79. Pas de nouvelle version RPG/IBM i annoncée par job-i (7.5 ; 7.6 mentionnée sur cycle GAP). Incohérences relevées sur job-i (non reprises) : performances 580/47 ms vs 544/45 ms, PTF HIPER 109→111→112, Node.js 118 vs 107 tests.
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
