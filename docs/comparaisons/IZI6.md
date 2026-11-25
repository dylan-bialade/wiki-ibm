# IZI6 : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB20 | QDDSSRC | DDS | 5 | 100 % |  | [IZI6.md](../../sources/DDS/BIB20/IZI6.md) |
| BIB25 | QF_PFLF | DDS | 6 | 22 % | DDS (R/K/PFILE) | [IZI6.md](../../sources/DDS/BIB25/IZI6.md) |

## Differences

- **BIB25** en propre : DDS (R/K/PFILE)

## Codes

### BIB20 (DDS, 5 lignes)

```text
                R IZI6F
     A            ID             6P 0
     A            NOM           25A
     A            PRENOM        25A
     A            CODEPOSTAL     5P 0
```

### BIB25 (DDS, 6 lignes)

```text
     A          R FIZI6
     A            ID             6S 0
     A            NOM           25A
     A            PRENOM        25A
     A            CODEPOSTAL     5S 0
     A          K ID
```
