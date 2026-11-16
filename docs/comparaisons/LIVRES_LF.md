# LIVRES_LF : 3 versions differentes dans 4 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB06 | QDDSSRC | DDS | 4 | 100 % | DDS (R/K/PFILE) | [LIVRES_LF.md](../../sources/DDS/BIB06/LIVRES_LF.md) |
| BIB10 | QDDSSRC | DDS | 4 | 100 % | DDS (R/K/PFILE) | [LIVRES_LF.md](../../sources/DDS/BIB10/LIVRES_LF.md) |
| BIB17 | QDDSSRC | DDS | 5 | 14 % | DDS (R/K/PFILE) | [LIVRES_LF.md](../../sources/DDS/BIB17/LIVRES_LF.md) |
| BIB20 | QTPSRC | DDS | 3 | 0 % | DDS (R/K/PFILE) | [LIVRES_LF.md](../../sources/DDS/BIB20/LIVRES_LF.md) |

## Differences

- Techniques communes : DDS (R/K/PFILE)

## Codes

### BIB06 (DDS, 4 lignes)

```text

                R LIVRESFMT                 PFILE(LIVRES_PF)
     A          K GENRE                     DESCEND
     A          K DATE_PUB                  DESCEND
```

### BIB10 (DDS, 4 lignes)

```text

                R LIVRESFMT                 PFILE(LIVRES_PF)
     A          K GENRE                     DESCEND
     A          K DATE_PUB                  DESCEND
```

### BIB17 (DDS, 5 lignes)

```text
                R LIVRESFMT                 PFILE(LIVRES_PF)
     A            GENRE
     A            DATE_PUB
     A          K GENRE
     A          K DATE_PUB
```

### BIB20 (DDS, 3 lignes)

```text
     A          R LIVRESF                   PFILE(LIVRES_PF)
     A          K GENRE
     A          K DATE_PUB
```
