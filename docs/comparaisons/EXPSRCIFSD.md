# EXPSRCIFSD : 4 versions differentes dans 5 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB01 | QDDSSRC | DDS | 43 | 0 % | DDS (R/K/PFILE) | [EXPSRCIFSD.md](../../sources/DDS/BIB01/EXPSRCIFSD.md) |
| BIB05 | QCLPSRC | CL/CL-procedural | 36 | 100 % |  | [EXPSRCIFSD.md](../../sources/CL/CL-procedural/BIB05/EXPSRCIFSD.md) |
| BIB06 | QCLPSRC | CL/CL-procedural | 69 | 0 % | DDS (R/K/PFILE) | [EXPSRCIFSD.md](../../sources/CL/CL-procedural/BIB06/EXPSRCIFSD.md) |
| BIB10 | QDSPSRC | DDS | 69 | 0 % | DDS (R/K/PFILE) | [EXPSRCIFSD.md](../../sources/DDS/BIB10/EXPSRCIFSD.md) |
| BIB17 | QCLPSRC | CL/CL-procedural | 46 | 0 % | DDS (R/K/PFILE) | [EXPSRCIFSD.md](../../sources/CL/CL-procedural/BIB17/EXPSRCIFSD.md) |

## Differences

- **BIB01** en propre : DDS (R/K/PFILE)
- **BIB06** en propre : DDS (R/K/PFILE)
- **BIB10** en propre : DDS (R/K/PFILE)
- **BIB17** en propre : DDS (R/K/PFILE)
- Langages / types differents : CL/CL-procedural, DDS

## Codes

### BIB01 (DDS, 43 lignes)

```text
     A*%%TS  SD  20260925  113436  FADRIEN     REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A          R FMT1
     A*%%TS  SD  20260925  113436  FADRIEN     REL-V7R5M0  5770-WDS
     A                                      OVERLAY
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 28'Exporter des sources IBM I'
     A                                      COLOR(BLU)
     A                                  6 18'Bibliothèque . :'
     A                                      COLOR(BLU)
     A                                  7 18'Fichier. . . . :'
     A                                      COLOR(BLU)
     A            PBIB          10A  B  6 36COMP(NE ' ')
     A  90                                  ERRMSG('Bibliothèque invalide' 90)
     A            PFIC          10A  B  7 36COMP(NE ' ')
     A  91                                  ERRMSG('Fichier incorrect' 91)
     A                                 22 36'F3=Quitter'
     A                                      COLOR(BLU)
     A          R FMT2
     A*%%TS  SD  20260925  083754  FADRIEN     REL-V7R5M0  5770-WDS
     A                                      OVERLAY
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 71DATE
     A                                      EDTCDE(Y)
     A                                  2 71TIME
     A                                  1 28'Exporter des sources IBM I'
     A                                      COLOR(BLU)
     A                                 10  2'Les sources ont été exporté dans l-
     A                                      e dossier :'
     A                                      COLOR(BLU)
     A            CHMIFS        40A  O 11  3
     A                                 13  2'et il y a'
     A                                      COLOR(BLU)
     A            COUNT          6Y 0O 13 12EDTCDE(4)
     A                                 13 19'membres sources'
     A                                      COLOR(BLU)
```

### BIB05 (CL/CL-procedural, 36 lignes)

```text
     A*%%TS  SD  20260925  152531  DYLAN2      REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A          R FMT1
     A*%%TS  SD  20260925  152531  DYLAN2      REL-V7R5M0  5770-WDS                  A                                      CF03(03)
     A                                  1  3'SYS'                                    A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  1  8SYSNAME
     A                                  2  3'USR'                                    A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  2  8USER
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2 72TIME                                     A                                  1 66'DATE'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  2 66'TIME'                                   A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  1 28'Exporter des sources IBM I'
     A                                      DSPATR(UL)                               A                                 10 17'Bibliothèque . :'
     A                                      COLOR(BLU)                               A                                 11 17'Fichier. . . . :'
     A                                      COLOR(BLU)                               A            PBIB          10A  B 10 35
     A  90                                  ERRMSG('Erreur: Bibliothèque inexis-     A                                      tante')
     A            PFIC          10A  B 11 35                                         A  91                                  ERRMSG('Erreur: fichier inexistant')
     A                                 23 37'F3=Exit'                                A                                      COLOR(BLU)
     A                                      DSPATR(RI)                               A  92                             23  5'type de fichier incorecte'
     A                                      COLOR(WHT)                               A          R FMT2
     A*%%TS  SD  20260925  122300  DYLAN2      REL-V7R5M0  5770-WDS                  A                                  1  3'SYS'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  1  8SYSNAME                                  A                                  1 66'DATE'
     A                                      COLOR(BLU)                               A                                      DSPATR(UL)
     A                                  1 72DATE                                     A                                      EDTCDE(Y)
     A                                  2  3'USR'                                    A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  2  8USER
     A                                  2 66'TIME'                                   A                                      COLOR(BLU)
     A                                      DSPATR(UL)                               A                                  2 72TIME
     A                                  1 25'Exporter des sources IBM I'             A                                      COLOR(BLU)
     A                                 10  3'Les sources ont été exporté dans l-     A                                      e dossier :'
     A                                      COLOR(BLU)                               A            CHMIFS        40A  O 11  4
     A                                 12  3'et il y a'                              A                                      COLOR(BLU)
     A            COUNT          6S 0O 12 13                                         A                                 12 20'membres sources'
     A                                      COLOR(BLU)                               A            FILE_PATH     50A  B 15  5
     A            MBR_PATH      50A  B 16  5                                         A            MBR_ACS       50A  B 17  5
```

### BIB06 (CL/CL-procedural, 69 lignes)

```text
     A*%%TS  SD  20260925  151304  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260925  151304  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 28'Exporter des sources IBM I'
     A                                      DSPATR(UL)
     A                                 10 17'Bibliothèque . :'
     A                                      COLOR(BLU)
     A                                 11 17'Fichier. . . . :'
     A                                      COLOR(BLU)
     A            PBIB          10A  B 10 35
     A  90                                  ERRMSG('Erreur: Bibliothèque inexis-
     A                                      tante')
     A            PFIC          10A  B 11 35
     A  91                                  ERRMSG('Erreur: fichier inexistant')
     A  92                                  ERRMSG('Erreur: le fichier n est pa-
     A                                      s un fichier source !!')
     A                                 23 37'F3=Exit'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
     A          R FMT2
     A*%%TS  SD  20260925  115918  XUAN        REL-V7R5M0  5770-WDS
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 72TIME
     A                                  1 25'Exporter des sources IBM I'
     A                                      COLOR(BLU)
     A                                 10  3'Les sources ont été exporté dans l-
     A                                      e dossier :'
     A                                      COLOR(BLU)
     A            CHMIFS        40A  O 11  4
     A                                 12  3'et il y a'
     A                                      COLOR(BLU)
     A            COUNT          6S 0O 12 13
     A                                 12 20'membres sources'
     A                                      COLOR(BLU)
```

### BIB10 (DDS, 69 lignes)

```text
     A*%%TS  SD  20260925  151304  XUAN        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260925  151304  XUAN        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 28'Exporter des sources IBM I'
     A                                      DSPATR(UL)
     A                                 10 17'Bibliothèque . :'
     A                                      COLOR(BLU)
     A                                 11 17'Fichier. . . . :'
     A                                      COLOR(BLU)
     A            PBIB          10A  B 10 35
     A  90                                  ERRMSG('Erreur: Bibliothèque inexis-
     A                                      tante')
     A            PFIC          10A  B 11 35
     A  91                                  ERRMSG('Erreur: fichier inexistant')
     A  92                                  ERRMSG('Erreur: le fichier n est pa-
     A                                      s un fichier source !!')
     A                                 23 37'F3=Exit'
     A                                      COLOR(BLU)
     A                                      DSPATR(RI)
     A          R FMT2
     A*%%TS  SD  20260925  115918  XUAN        REL-V7R5M0  5770-WDS
     A                                  1  3'SYS'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1  8SYSNAME
     A                                  1 66'DATE'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2  3'USR'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2  8USER
     A                                  2 66'TIME'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  2 72TIME
     A                                  1 25'Exporter des sources IBM I'
     A                                      COLOR(BLU)
     A                                 10  3'Les sources ont été exporté dans l-
     A                                      e dossier :'
     A                                      COLOR(BLU)
     A            CHMIFS        40A  O 11  4
     A                                 12  3'et il y a'
     A                                      COLOR(BLU)
     A            COUNT          6S 0O 12 13
     A                                 12 20'membres sources'
     A                                      COLOR(BLU)
```

### BIB17 (CL/CL-procedural, 46 lignes)

```text
     A*%%TS  SD  20260925  100919  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260925  100919  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  2  1USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 28'Exporter des sources IBM I'
     A                                      COLOR(BLU)
     A                                 23  8'F3:Quitter'
     A                                      COLOR(BLU)
     A                                  6 14'Bibliothèque.:'
     A                                      COLOR(BLU)
     A                                  7 14'Fichier......:'
     A                                      COLOR(BLU)
     A            PBIB          10A  B  6 31
     A  90                                  ERRMSG('Erreur : bibliothèque inexi-
     A                                      stante')
     A            PFIC          10A  B  7 31
     A  91                                  ERRMSG('Erreur : fichier inexistant-
     A                                      ')
     A          R FMT2
     A*%%TS  SD  20260925  094445  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                  1  2SYSNAME
     A                                  2  1USER
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                  1 28'Exporter des sources IBMI'
     A                                      COLOR(BLU)
     A                                  7  3'Les sources ont été exporté dans l-
     A                                      e dossier:'
     A                                      COLOR(BLU)
     A                                 11  3'et il y a'
     A                                      COLOR(BLU)
     A            COUNT          6  0O 11 14
     A            CHMIFS        40   O  8  4
     A                                 11 22'membres sources'
     A                                      COLOR(BLU)
     A                                 23 22'F3:quitter'
     A                                      COLOR(BLU)
```
