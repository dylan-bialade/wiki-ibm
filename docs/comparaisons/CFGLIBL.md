# CFGLIBL : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB06 | QCLPSRC | CL/CL-procedural | 8 | 100 % | gestion d erreur | [CFGLIBL.md](../../sources/CL/CL-procedural/BIB06/CFGLIBL.md) |
| BIB10 | QCLPSRC | CL/CL-procedural | 8 | 100 % | gestion d erreur | [CFGLIBL.md](../../sources/CL/CL-procedural/BIB10/CFGLIBL.md) |

## Differences

- Techniques communes : gestion d erreur

## Codes

### BIB06 (CL/CL-procedural, 8 lignes)

```text
             PGM
             ADDLIBLE   LIB(BIB10) /* add libl 'BIB10' to libl */
             MONMSG     MSGID(CPF2103) /* catch lib already in libl */
             ADDLIBLE   LIB(BIB15) /* add libl 'BIB15' to libl */
             MONMSG     MSGID(CPF2103) /* catch lib already in libl */
             ADDLIBLE   LIB(BIB13) /* add libl 'BIB13' to libl */
             MONMSG     MSGID(CPF2103) /* catch lib already in libl */
             ENDPGM
```

### BIB10 (CL/CL-procedural, 8 lignes)

```text
             PGM
             ADDLIBLE   LIB(BIB15) /* add libl 'BIB15' to libl */
             MONMSG     MSGID(CPF2103) /* catch lib already in libl */
             ADDLIBLE   LIB(BIB13) /* add libl 'BIB13' to libl */
             MONMSG     MSGID(CPF2103) /* catch lib already in libl */
             ADDLIBLE   LIB(BIB10) /* add libl 'BIB10' to libl */
             MONMSG     MSGID(CPF2103) /* catch lib already in libl */
             ENDPGM
```
