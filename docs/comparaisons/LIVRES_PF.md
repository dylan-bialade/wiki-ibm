# LIVRES_PF : 3 versions differentes dans 4 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB06 | QDDSSRC | DDS | 9 | 21 % | DDS (R/K/PFILE) | [LIVRES_PF.md](../../sources/DDS/BIB06/LIVRES_PF.md) |
| BIB10 | QDDSSRC | DDS | 9 | 21 % | DDS (R/K/PFILE) | [LIVRES_PF.md](../../sources/DDS/BIB10/LIVRES_PF.md) |
| BIB17 | QDDSSRC | DDS | 5 | 8 % |  | [LIVRES_PF.md](../../sources/DDS/BIB17/LIVRES_PF.md) |
| BIB20 | QTPSRC | DDS | 9 | 100 % | DDS (R/K/PFILE) | [LIVRES_PF.md](../../sources/DDS/BIB20/LIVRES_PF.md) |

## Differences

- **BIB06** en propre : DDS (R/K/PFILE)
- **BIB10** en propre : DDS (R/K/PFILE)
- **BIB20** en propre : DDS (R/K/PFILE)

## Codes

### BIB06 (DDS, 9 lignes)

```text
                                            UNIQUE
                R LIVRESFMT
     A            ISBN          13P 0
     A            TITRE         50
     A            ID_AUTEUR      7  0
     A            GENRE         20A         VALUES('Philosophie' 'SF' 'Guerre')
     A            DATE_PUB        L
     A            NBR_PAGES      5  0
     A          K ISBN
```

### BIB10 (DDS, 9 lignes)

```text
                                            UNIQUE
                R LIVRESFMT
     A            ISBN          13P 0
     A            TITRE         50
     A            ID_AUTEUR      7  0
     A            GENRE         20A         VALUES('Philosophie' 'SF' 'Guerre')
     A            DATE_PUB        L
     A            NBR_PAGES      5  0
     A          K ISBN
```

### BIB17 (DDS, 5 lignes)

```text
                R LIVREFMT                                                           A            ISBN
13P 0                                                A            TITRE         50A
                     A            ID_AUTEUR      7P 0                                                A
  GENRE         20A         VALUES('PHILOSOPHIE' 'SF' 'GUERRE')      A            DATE_PUB        L
                                     A            NBR_PAGES      5P 0
```

### BIB20 (DDS, 9 lignes)

```text

     A          R LIVRESF
     A            ISBN          13P 0
     A            TITRE         50A
     A            ID_AUTEUR      7P 0
     A            GENRE         20A         VALUES('Philosophie' 'SF' 'Guerre')
     A            DATE_PUB        L         DATFMT(*ISO)
     A            NBR_PAGES      5P 0
     A          K ISBN
```
