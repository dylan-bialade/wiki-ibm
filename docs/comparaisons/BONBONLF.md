# BONBONLF : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QSOURCE | DDS | 2 | 100 % | DDS (R/K/PFILE) | [BONBONLF~QSOURCE.md](../../sources/DDS/BIB02/BONBONLF~QSOURCE.md) |
| BIB02 | QDDSRC | DDS | 2 | 100 % | DDS (R/K/PFILE) | [BONBONLF.md](../../sources/DDS/BIB02/BONBONLF.md) |
| BIB05 | QLFSRC | DDS | 8 | 0 % | DDS (R/K/PFILE) | [BONBONLF.md](../../sources/DDS/BIB05/BONBONLF.md) |

## Differences

- Techniques communes : DDS (R/K/PFILE)

## Codes

### BIB02 (DDS, 2 lignes)

```text
     A          R BONBON                    PFILE(BIB02/BONBON)
     A          K NOM
```

### BIB02 (DDS, 2 lignes)

```text
     A          R BONBON                    PFILE(BIB02/BONBON)
     A          K NOM
```

### BIB05 (DDS, 8 lignes)

```text
     A          R BONBONL                   PFILE(BIB05/BONBON)

     A            NOM
     A            MARQUE
     A            PRIX
     A            COULEUR
     A            NUMBER
     A          K NUMBER
```
