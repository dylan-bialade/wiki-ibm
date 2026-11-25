# TEST1 : 5 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QRPGLESRC | RPG/RPG-ILE | 1 | 0 % |  | [TEST1.md](../../sources/RPG/RPG-ILE/BIB02/TEST1.md) |
| BIB25 | QSQLSRC | SQL | 1 | 0 % |  | [TEST1.md](../../sources/SQL/BIB25/TEST1.md) |
| BIB27 | QCOBOLSRC | COBOL | 23 | 100 % |  | [TEST1.md](../../sources/COBOL/BIB27/TEST1.md) |
| BIB27 | QDDSSRC | DDS | 6 | 0 % | DDS (R/K/PFILE) | [TEST1.md](../../sources/DDS/BIB27/TEST1.md) |
| BIB27 | QRPGLESRC | RPG/RPG-ILE | 14 | 0 % | full free, ecran (WORKSTN) | [TEST1.md](../../sources/RPG/RPG-ILE/BIB27/TEST1.md) |

## Differences

- **BIB27** en propre : DDS (R/K/PFILE)
- **BIB27** en propre : full free, ecran (WORKSTN)
- Langages / types differents : COBOL, DDS, RPG/RPG-ILE, SQL

## Codes

### BIB02 (RPG/RPG-ILE, 1 lignes)

```text
select * from sd;
```

### BIB25 (SQL, 1 lignes)

```text
                R FORMAT
```

### BIB27 (COBOL, 23 lignes)

```text
       IDENTIFICATION DIVISION.
       PROGRAM-ID. WELCOME.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-ISERIES.
       OBJECT-COMPUTER. IBM-ISERIES.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-USER-NAME PIC X(30).
       01 WS-DISPLAY-MESSAGE PIC X(50).

       PROCEDURE DIVISION.
           DISPLAY 'Please enter your name: ' WITH NO ADVANCING.
           ACCEPT WS-USER-NAME.

           STRING 'Welcome, ' WS-USER-NAME '!'
               DELIMITED BY SIZE
               INTO WS-DISPLAY-MESSAGE.

           DISPLAY WS-DISPLAY-MESSAGE.
           STOP RUN.
```

### BIB27 (DDS, 6 lignes)

```text
     A*%%TS  SD  20240809  102315  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20240809  102315  LEO2        REL-V7R4M0  5770-WDS
     A                                  8 16'ecran test'
```

### BIB27 (RPG/RPG-ILE, 14 lignes)

```text
**free


dcl-f BONBON disk usage(*input: *output:*UPDATE);


dcl-f test1 workstn;


exfmt fmt1;



*inlr = *on;
```
