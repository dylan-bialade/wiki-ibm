# STATCBL001 : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB01 | QCBLLESRC | COBOL | 12 | 100 % |  | [STATCBL001.md](../../sources/COBOL/BIB01/STATCBL001.md) |
| BIB20 | QCBLLESRC | COBOL | 11 | 73 % |  | [STATCBL001.md](../../sources/COBOL/BIB20/STATCBL001.md) |

## Differences

## Codes

### BIB01 (COBOL, 12 lignes)

```text
       IDENTIFICATION DIVISION.
       PROGRAM-ID. STATCBL001.
       ENVIRONMENT DIVISION.

       WORKING-STORAGE SECTION.
        77 PARAM01   PIC X(10).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            MOVE '<-------->'      TO PARAM01.
            CALL 'STATCBL002' USING PARAM01.
            STOP RUN.
```

### BIB20 (COBOL, 11 lignes)

```text
       IDENTIFICATION DIVISION.
       PROGRAM-ID. STATCBL001.
       ENVIRONMENT DIVISION.

       WORKING-STORAGE SECTION.
          01 PARAM01   PIC X(10).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            CALL 'STATCBL002' USING PARAM01.
            STOP RUN.
```
