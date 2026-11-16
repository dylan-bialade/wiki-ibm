# PRETSRV : 3 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB03 | QSRVSRC | Autres/Service-programs | 4 | 100 % |  | [PRETSRV.md](../../sources/Autres/Service-programs/BIB03/PRETSRV.md) |
| BIB13 | QSRVSRC | Autres/Service-programs | 18 | 7 % |  | [PRETSRV.md](../../sources/Autres/Service-programs/BIB13/PRETSRV.md) |
| BIB17 | QSRVSRC | Autres/Service-programs | 22 | 8 % |  | [PRETSRV.md](../../sources/Autres/Service-programs/BIB17/PRETSRV.md) |

## Differences

## Codes

### BIB03 (Autres/Service-programs, 4 lignes)

```text
STRPGMEXP PGMLVL(*CURRENT) SIGNATURE('PRETSRV V1')
  EXPORT SYMBOL("MENSUALITE")
  EXPORT SYMBOL("INTERETMOIS")
ENDPGMEXP
```

### BIB13 (Autres/Service-programs, 18 lignes)

```text
             STRPGMEXP
             EXPORT     SYMBOL(NBMOIS)
             EXPORT     SYMBOL(CALCTOTINTERET)
             EXPORT     SYMBOL(CALCMENSUALITE)
             EXPORT     SYMBOL(INTERETSMOIS)
             EXPORT     SYMBOL(AMMOTISMOIS)
             EXPORT     SYMBOL(CAPITALRESTANT)
             EXPORT     SYMBOL(CALCAMMORTI)
             EXPORT     SYMBOL(MENSUALITE)
             endpgmexp
             STRPGMEXP  PGMLVL(*PRV)
             EXPORT     SYMBOL(NBMOIS)
             EXPORT     SYMBOL(CALCTOTINTERET)
             EXPORT     SYMBOL(CALCMENSUALITE)
             EXPORT     SYMBOL(INTERETSMOIS)
             EXPORT     SYMBOL(AMMOTISMOIS)
             EXPORT     SYMBOL(CAPITALRESTANT)
             endpgmexp
```

### BIB17 (Autres/Service-programs, 22 lignes)

```text
             STRPGMEXP  PGMLVL(*CURRENT)
             EXPORT     SYMBOL(CALCTOTAUX)
             EXPORT     SYMBOL(CALCMENSUALITE)
             EXPORT     SYMBOL(CALCECHEANCE)
             EXPORT     SYMBOL(CALCTOTAUXAMORTCONST)
             EXPORT     SYMBOL(CALCECHEANCEAMORTCONST)
             EXPORT     SYMBOL(CALCCAPITALCONSTANT)
             ENDPGMEXP

             STRPGMEXP  PGMLVL(*PRV)
             EXPORT     SYMBOL(CALCTOTAUX)
             EXPORT     SYMBOL(CALCMENSUALITE)
             EXPORT     SYMBOL(CALCECHEANCE)
             EXPORT     SYMBOL(CALCTOTAUXAMORTCONST)
             EXPORT     SYMBOL(CALCECHEANCEAMORTCONST)
             ENDPGMEXP

             STRPGMEXP  PGMLVL(*PRV)
             EXPORT     SYMBOL(CALCTOTAUX)
             EXPORT     SYMBOL(CALCMENSUALITE)
             EXPORT     SYMBOL(CALCECHEANCE)
             ENDPGMEXP
```
