# ENTREPOT : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QDDSRC | DDS | 5 | 10 % |  | [ENTREPOT.md](../../sources/DDS/BIB02/ENTREPOT.md) |
| BIB17 | QDDSSRC | DDS | 6 | 100 % |  | [ENTREPOT.md](../../sources/DDS/BIB17/ENTREPOT.md) |

## Differences


## Codes

### BIB02 (DDS, 5 lignes)

```text
                R ENTREPOTF
                  CODPRO         5          COLHDG('CODE PRODUIT')
                  NMPRO         30          COLHDG('NOM PRODUIT')
                  QTPRO          3S 0       COLHDG('QUANTIOTE')
                  DTDINV          L         COLHDG('DATE DERNIER INV.')
```

### BIB17 (DDS, 6 lignes)

```text
                R ENTREPOTF
                  CODPRO         5A         COLHDG('CODE_PRODUIT')
                  NOMPROD       30A         COLHDG('NOM_PRODUIT')
                  QUANTSTOCK     3S 0       COLHDG('QUANTITE_EN_STOCK')
                  DINVDATE        L         DATFMT(*ISO)
                                            COLHDG('DTE_DERNIER_INVENT')
```
