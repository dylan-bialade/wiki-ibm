# Analyse : ce que les énoncés demandent et ce que le dépôt contient

Comparaison des [énoncés](README.md) avec les fiches (`docs/cheatsheets/`) et les sources converties. « Fiches » = le terme apparaît dans une fiche ; « Code » = nombre d'occurrences dans les sources. Comptage automatique, **à confirmer** avant d'écrire une fiche (heuristique).

## 1. Exercices sans solution dans le dépôt

| Énoncé | Ce qui manque |
|---|---|
| [examen-kebab](examen-kebab.md) | tout : environnement (profil, `JOBD`, `JOBQ`, `OUTQ`, `MSGQ`, sous-système), DDS `PRODUIT` / `COMMANDE` / LF avec sélection, CL `*OUTFILE` + écran, SQL jointure externe, RPG III de consultation |
| [tp-the-big-one](tp-the-big-one.md) | héritage RPG III (`NUMMAI`, `CALDEV`, `GESMAI`) et sa version RPG IV, CL `DEVIS` |
| [tp-le-chai](tp-le-chai.md) | programme `CHAI` (SQL embarqué, transaction « tout ou rien ») |
| [tp-logistock](tp-logistock.md) | programme RPG du sous-fichier avec fenêtre et confirmation F23 (seuls les écrans DDS sont là) |

## 2. Notions requises par les énoncés

| Notion | Énoncé(s) | Fiches | Code | Action |
|---|---|---|---|---|
| `SND-MSG` (message dans la joblog) | wesh-alors | non | 26 | à ajouter (fiche 03) |
| `%XLATE`, `%SCAN`, `%REPLACE` | wesh-alors | `%XLATE` non ; `%REPLACE` oui mais jamais utilisé dans le code | 14 / 19 / 0 | exemples de `%REPLACE` manquants |
| `KLIST`, `CASEQ`, `SELEC`/`WHEQ`, `READP`, `MVR` (RPG III) | livres, examen-kebab, cours | non | 32 / 41 / 20-39 / 17 / 3 | fiche 03 : instructions RPG III |
| `TAG`, `GOTO`, `CABxx` | the-big-one | non | 85 / 460 / 0 | à documenter ; **aucun exemple de `CABxx`** dans le code |
| `UNLOCK`, `DTAARA` (`IN`/`OUT`) | the-big-one | `DTAARA` oui, `UNLOCK` non | 10 / 80 | compléter |
| SQL embarqué (`DECLARE … CURSOR`, `COMMIT`, `ROLLBACK`, `GET DIAGNOSTICS`) | le-chai | non | 104 / 133 / 9 / 12 | **nouvelle fiche** (priorité) |
| `COALESCE`, `GROUP BY`, `DISTINCT`, `CURRENT DATE - n MONTHS` | examen-kebab | non | 29 / 4 / 5 / 7 | fiche 04 : requêtes d'analyse |
| `LEFT JOIN` | examen-kebab | oui (équivalence LF) | 8 | exemple chiffré manquant |
| `OUTFILE` (`DSPOBJD`, etc.) | examen-kebab | `DSPOBJD` oui, `OUTFILE` non | 65 | fiche 02 : sorties dans un fichier |
| `CRTSBSD`, `ADDRTGE`, `ADDJOBQE`, `CRTJOBD`, `CRTMSGQ` | examen-kebab | non | 2 / 2 / 2 / 4 / **0** | fiche 02 : environnement de travail ; pas d'exemple `CRTMSGQ` |
| `CPYSRCF`, `RUNSQLSTM` | the-big-one, le-chai | non | 13 / 9 | fiche 02 |
| `WINDOW`, `DSPATR`, `CHECK`, `DATFMT`, `TIMFMT` (DDS écran) | logistock, impôt | non | 47 / 1 019 / 191 / 120 / 83 | **nouvelle fiche DDS d'écran** |
| `FNDSTRPDM` | the-big-one | non | **0** | à documenter |

## 3. Limites et incohérences relevées
- **Calculateur d'impôt** : les trois exemples chiffrés de l'énoncé (3 617,34 / 1 305,70 / 198,55 €) ne se retrouvent pas avec le barème fourni (calcul direct : 3 617,75 / 1 305,92 / 198,88 €) et la maquette affiche encore 198,66 € : voir [tp-calculateur-impot](tp-calculateur-impot.md).
- **Supports non lus** : cours RPG full free et sous-fichier (images), fin du cours DB2 (voir [cours](cours.md)). Les énoncés d'exercices de ces cours ne sont donc pas résumés.
- **Contenu à ne pas diffuser** : les énoncés originaux (droits d'auteur) et les noms de personnes, d'organisme, d'adresses et de machines restent hors dépôt.
