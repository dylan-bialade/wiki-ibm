# PRODUITS : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QRPGLESRC | RPG/RPG-ILE | 1 | 100 % |  | [PRODUITS.md](../../sources/RPG/RPG-ILE/BIB02/PRODUITS.md) |
| BIB17 | QDDSSRC | DDS | 6 | 0 % |  | [PRODUITS.md](../../sources/DDS/BIB17/PRODUITS.md) |

## Differences

- Langages / types differents : RPG/RPG-ILE, DDS

## Codes

### BIB02 (RPG/RPG-ILE, 1 lignes)

```text
select * from BIB02.entrepot;
```

### BIB17 (DDS, 6 lignes)

```text
                R PRDFMT
     A            PRDNUM         7P
     A            PRDNAME       30A
     A            PRDCAT        10          COLHDG('CATEGORIE_PRODUIT')
     A            PRDPRICE       7P 2
     A            PRDQTY         5P 0       COLHDG('QUANTITY')
```
