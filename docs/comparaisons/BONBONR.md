# BONBONR : 3 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB01 | QRPGSRC | RPG/RPG-III-400 | 12 | 100 % | SETLL / READ | [BONBONR.md](../../sources/RPG/RPG-III-400/BIB01/BONBONR.md) |
| BIB05 | QRPGLESRC | RPG/RPG-ILE | 73 | 2 % | sous-fichier, ecran (WORKSTN), SETLL / READ, boucle DOW/DOU/FOR, indicateurs *INxx | [BONBONR.md](../../sources/RPG/RPG-ILE/BIB05/BONBONR.md) |
| BIB05 | QRPGSRC2 | RPG/RPG-III-400 | 73 | 2 % | ecran (WORKSTN), SETLL / READ, boucle DOW/DOU/FOR, indicateurs *INxx | [BONBONR.md](../../sources/RPG/RPG-III-400/BIB05/BONBONR.md) |

## Differences

- Techniques communes : SETLL / READ
- **BIB05** en propre : sous-fichier, ecran (WORKSTN), boucle DOW/DOU/FOR, indicateurs *INxx
- **BIB05** en propre : ecran (WORKSTN), boucle DOW/DOU/FOR, indicateurs *INxx
- Langages / types differents : RPG/RPG-III-400, RPG/RPG-ILE

## Codes

### BIB01 (RPG/RPG-III-400, 12 lignes)

```text
     FBONBON  IF  F      59            DISK
     IBONBON  AA
     I                                        1  40 NOMMAR
     I                                        1  20 NOM
     I                                       21  40 MARQUE
     I                                    P  51  532PRIX
     C           1         SETLLBONBON
     C                     READ BONBON                   90
     C           NOM       DSPLY
     C           NOMMAR    DSPLY
     C           PRIX      DSPLY
     C                     SETON                     LR
```

### BIB05 (RPG/RPG-ILE, 73 lignes)

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIB05
     FBONBONSF  CF   E             WORKSTN
     F                                     SFILE(SFL1:RRN)
     FBONBONKN  IF   E           K DISK
     IBONBONL
     I              COULEUR                     COUL
     C     CRUD          PLIST
     C                   PARM                    OPT               1
     C                   PARM                    NUMBER            6 0
     C     DEBUT         TAG
     C     *IN03         DOWEQ     *OFF
     C                   SETON                                        LR
     C                   Z-ADD     0             RRN               4 0
     C                   SETON                                        3233
     C                   WRITE     CTL1
     C                   SETOFF                                       32
     C     VAL6          IFEQ      *BLANK
     C     *LOVAL        SETLL     BONBONKN
     C                   ELSE
     C     VAL6          SETLL     BONBONKN
     C                   ENDIF
     C                   READ      BONBONKN                               90
     C     *IN90         DOWEQ     '0'
     C                   SETOFF                                       32
     C                   ADD       1             RRN
     C                   MOVEL     NOM           VAL1
     C                   MOVEL     MARQUE        VAL2
     C                   MOVEL     COUL          VAL3
     C                   MOVEL     PRIX          VAL4
     C     VAL4          CAT       ' €':1        VAL4
     C                   MOVEL     NUMBER        VAL5
     C                   WRITE     SFL1
     C                   READ      BONBONKN                               90
     C                   ENDDO
     C                   SETON                                            31
     C     RRN           IFGT      0
     C                   SETON                                            30
     C                   SETON                                            31
     C                   WRITE     CTL1
     C                   ENDIF
     C                   WRITE     FOOTER
     C                   EXFMT     CTL1
      *====================================================*
     C     *IN06         IFEQ      *ON
     C                   MOVEL     '4'           OPT
     C                   Z-ADD     0             NUMBER
     C                   SETON                                            81
     C                   GOTO      PROG2
     C                   ENDIF
      *=====================================================*
     C                   READC     SFL1                                   76
     C     *IN76         DOWEQ     *OFF
     C     OPT           IFEQ      '2'
     C     OPT           OREQ      '3'
     C                   SETON                                            81
     C                   ENDIF
      *======================================================*
     C                   MOVEL     OPT           OPT
     C                   MOVEL     VAL5          NUMBER
      *======================================================*
     C     PROG2         TAG
     C     *IN81         IFEQ      *ON
     C                   CALL      'BONCRUD'     CRUD
     C                   ENDIF
     C                   READC     SFL1                                   76
     C                   MOVEL     *BLANK        OPT
     C                   ENDDO
      *======================================================*
     C   05              GOTO      DEBUT
     C                   ENDDO
```

### BIB05 (RPG/RPG-III-400, 73 lignes)

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIB05
     FBONBONSFCF  E                    WORKSTN
     F                                        RRN   KSFILE SFL1
     FBONBONKNIF  E           K        DISK
     IBONBONL
     I              COULEUR                         COUL
     C           CRUD      PLIST
     C                     PARM           OPT     1
     C                     PARM           NUMBER  60
     C           DEBUT     TAG
     C           *IN03     DOWEQ*OFF
     C                     SETON                     LR
     C                     Z-ADD0         RRN     40
     C                     SETON                     3233
     C                     WRITECTL1
     C                     SETOF                     32
     C           VAL6      IFEQ *BLANK
     C           *LOVAL    SETLLBONBONKN
     C                     ELSE
     C           VAL6      SETLLBONBONKN
     C                     ENDIF
     C                     READ BONBONKN                 90
     C           *IN90     DOWEQ'0'
     C                     SETOF                     32
     C                     ADD  1         RRN
     C                     MOVELNOM       VAL1
     C                     MOVELMARQUE    VAL2
     C                     MOVELCOUL      VAL3
     C                     MOVELPRIX      VAL4
     C           VAL4      CAT  ' €':1    VAL4
     C                     MOVELNUMBER    VAL5
     C                     WRITESFL1
     C                     READ BONBONKN                 90
     C                     ENDDO
     C                     SETON                         31
     C           RRN       IFGT 0
     C                     SETON                         30
     C                     SETON                         31
     C                     WRITECTL1
     C                     ENDIF
     C                     WRITEFOOTER
     C                     EXFMTCTL1
      *====================================================*
     C           *IN06     IFEQ *ON
     C                     MOVEL'4'       OPT
     C                     Z-ADD0         NUMBER
     C                     SETON                         81
     C                     GOTO PROG2
     C                     ENDIF
      *=====================================================*
     C                     READCSFL1                     76
     C           *IN76     DOWEQ*OFF
     C           OPT       IFEQ '2'
     C           OPT       OREQ '3'
     C                     SETON                         81
     C                     ENDIF
      *======================================================*
     C                     MOVELOPT       OPT
     C                     MOVELVAL5      NUMBER
      *======================================================*
     C           PROG2     TAG
     C           *IN81     IFEQ *ON
     C                     CALL 'BONCRUD' CRUD
     C                     ENDIF
     C                     READCSFL1                     76
     C                     MOVEL*BLANK    OPT
     C                     ENDDO
      *======================================================*
     C   05                GOTO DEBUT
     C                     ENDDO
```
