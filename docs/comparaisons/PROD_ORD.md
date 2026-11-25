# PROD_ORD : 3 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB17 | QDDSSRC | DDS | 5 | 100 % | DDS (R/K/PFILE) | [PROD_ORD.md](../../sources/DDS/BIB17/PROD_ORD.md) |
| BIB25 | QDDSSRC | DDS | 3 | 0 % | DDS (R/K/PFILE) | [PROD_ORD.md](../../sources/DDS/BIB25/PROD_ORD.md) |
| BIB27 | QDDSSRC | DDS | 5 | 0 % | DDS (R/K/PFILE) | [PROD_ORD.md](../../sources/DDS/BIB27/PROD_ORD.md) |

## Differences

- Techniques communes : DDS (R/K/PFILE)

## Codes

### BIB17 (DDS, 5 lignes)

```text
                R PRDFMT                    PFILE(BIB17/PRODUITS)
     A            PRDCAT
     A            PRDPRICE
     A          K PRDCAT
     A          K PRDPRICE                  DESCEND
```

### BIB25 (DDS, 3 lignes)

```text
     A          R PRODUITSR                 PFILE(PRODUITS)
                K PRDCAT                    DESCEND
                K PRDPRICE                  DESCEND
```

### BIB27 (DDS, 5 lignes)

```text
     A          R PRODUITSR                 PFILE(PRODUITS)
                  PRDCAT
                  PRDPRICE
                K PRDCAT
                K PRDPRICE                  DESCEND
```
