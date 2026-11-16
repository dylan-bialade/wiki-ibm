# AUTEURS_PF : 3 versions differentes dans 4 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB06 | QDDSSRC | DDS | 9 | 100 % | DDS (R/K/PFILE) | [AUTEURS_PF.md](../../sources/DDS/BIB06/AUTEURS_PF.md) |
| BIB10 | QDDSSRC | DDS | 9 | 100 % | DDS (R/K/PFILE) | [AUTEURS_PF.md](../../sources/DDS/BIB10/AUTEURS_PF.md) |
| BIB17 | QDDSSRC | DDS | 5 | 0 % |  | [AUTEURS_PF.md](../../sources/DDS/BIB17/AUTEURS_PF.md) |
| BIB20 | QTPSRC | DDS | 9 | 31 % | DDS (R/K/PFILE) | [AUTEURS_PF.md](../../sources/DDS/BIB20/AUTEURS_PF.md) |

## Differences

- **BIB06** en propre : DDS (R/K/PFILE)
- **BIB10** en propre : DDS (R/K/PFILE)
- **BIB20** en propre : DDS (R/K/PFILE)

## Codes

### BIB06 (DDS, 9 lignes)

```text
                                            UNIQUE
     A          R AUTEURFMT
     A            ID_AUTEUR      7  0
     A            NOM           40A
     A            PRENOM        40A
     A            AGE            3  0
     A            EMAIL         50A
     A            SALAIRE        8  2
     A          K ID_AUTEUR
```

### BIB10 (DDS, 9 lignes)

```text
                                            UNIQUE
     A          R AUTEURFMT
     A            ID_AUTEUR      7  0
     A            NOM           40A
     A            PRENOM        40A
     A            AGE            3  0
     A            EMAIL         50A
     A            SALAIRE        8  2
     A          K ID_AUTEUR
```

### BIB17 (DDS, 5 lignes)

```text
                R AUTEURSFMT                                                         A            ID_AUTEUR
 7P 0                                                A            NOM           40A
                     A            PRENOM        40A                                                  A
  AGE            3P 0                                                A            EMAIL         50A
                                     A            SALAIRE        8P 2
```

### BIB20 (DDS, 9 lignes)

```text

     A          R AUTEURSF
     A            ID_AUTEUR      7P 0
     A            NOM           40A
     A            PRENOM        40A
     A            AGE            3P 0
     A            EMAIL         50A
     A            SALAIRE        8P 2
     A          K ID_AUTEUR
```
