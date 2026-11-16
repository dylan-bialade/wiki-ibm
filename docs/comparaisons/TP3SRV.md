# TP3SRV : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB03 | QSRVSRC | Autres/Service-programs | 13 | 100 % |  | [TP3SRV.md](../../sources/Autres/Service-programs/BIB03/TP3SRV.md) |
| BIB18 | QSRVSRC | Autres/Service-programs | 12 | 6 % |  | [TP3SRV.md](../../sources/Autres/Service-programs/BIB18/TP3SRV.md) |

## Differences

## Codes

### BIB03 (Autres/Service-programs, 13 lignes)

```text
STRPGMEXP PGMLVL(*CURRENT)
  EXPORT SYMBOL("NOMCLIENT")            /* n° 1 */
  EXPORT SYMBOL("ENCOURSCLIENT")        /* n° 2 */
  EXPORT SYMBOL("CREDITDISPO")          /* n° 3 */
  EXPORT SYMBOL("PEUTCOMMANDER")        /* n° 4 - NOUVEAU, à la fin */
  EXPORT SYMBOL("VILLECLIENT")          /* n° 5 - NOUVEAU, à la fin */
ENDPGMEXP

STRPGMEXP PGMLVL(*PRV)                  /* NOUVEAU : copie de l'ancien bloc (ex. 1) */
  EXPORT SYMBOL("NOMCLIENT")
  EXPORT SYMBOL("ENCOURSCLIENT")
  EXPORT SYMBOL("CREDITDISPO")
ENDPGMEXP
```

### BIB18 (Autres/Service-programs, 12 lignes)

```text
             STRPGMEXP
             EXPORT     SYMBOL(NOMCLIENT)
             EXPORT     SYMBOL(ENCOURSCLIENT)
             EXPORT     SYMBOL(CREDITDISPO)
             EXPORT     SYMBOL(PEUTCOMMANDER)
             EXPORT     SYMBOL(VILLECLIENT)
             ENDPGMEXP
             STRPGMEXP  PGMLVL(*PRV)
             EXPORT     SYMBOL(NOMCLIENT)
             EXPORT     SYMBOL(ENCOURSCLIENT)
             EXPORT     SYMBOL(CREDITDISPO)
             ENDPGMEXP
```
