---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: BONBONR
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 73
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/BONBONR

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

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
