# SAVELIB : 2 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QCLPSRC | CL/CL-procedural | 3 | 100 % |  | [SAVELIB.md](../../sources/CL/CL-procedural/BIB05/SAVELIB.md) |
| BIB06 | QCLPSRC | CL/CL-procedural | 3 | 0 % |  | [SAVELIB.md](../../sources/CL/CL-procedural/BIB06/SAVELIB.md) |
| BIB10 | QCLPSRC | CL/CL-procedural | 3 | 0 % |  | [SAVELIB.md](../../sources/CL/CL-procedural/BIB10/SAVELIB.md) |

## Differences

## Codes

### BIB05 (CL/CL-procedural, 3 lignes)

```text
             CMD        PROMPT('Sauvegarde bibliothèque')
             PARM       KWD(LIBRARY) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Bibliothèque')
```

### BIB06 (CL/CL-procedural, 3 lignes)

```text
             CMD        PROMPT('Save lib sur ifs')
             PARM       KWD(LIB) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Nom de la librairie a save')
```

### BIB10 (CL/CL-procedural, 3 lignes)

```text
             CMD        PROMPT('Save lib sur ifs')
             PARM       KWD(LIB) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Nom de la librairie a save')
```
