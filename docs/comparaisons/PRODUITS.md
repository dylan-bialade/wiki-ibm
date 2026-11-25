# PRODUITS : 3 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QRPGLESRC | RPG/RPG-ILE | 1 | 0 % |  | [PRODUITS.md](../../sources/RPG/RPG-ILE/BIB02/PRODUITS.md) |
| BIB17 | QDDSSRC | DDS | 6 | 100 % |  | [PRODUITS.md](../../sources/DDS/BIB17/PRODUITS.md) |
| BIB25 | QSQLSRC | SQL | 7 | 0 % | CREATE TABLE/VIEW | [PRODUITS.md](../../sources/SQL/BIB25/PRODUITS.md) |

## Differences

- **BIB25** en propre : CREATE TABLE/VIEW
- Langages / types differents : DDS, RPG/RPG-ILE, SQL

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

### BIB25 (SQL, 7 lignes)

```text
CREATE TABLE Produits (
    idProduit NUMERIC(6, 0) GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMEN
    nomProduit VARCHAR(10),
    description VARCHAR(255),
    prix DECIMAL(10, 2),
    stock NUMERIC(6, 0)
);
```
