---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: BBNRPG
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 127
modifie: 2026-11-16
---

# BIB17/QRPGSRC/BBNRPG

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FBBNLF   IF  E           K        DISK
     FBBNDSP  CF  E                    WORKSTN
     F                                        RANG  KSFILE SFL1
      *
     IFBONBON
     I              COULEUR                         COLOR
     ISFL1
     I              COULEUR                         COLOR
     IMODBBN
     I              COULEUR                         COLOR
      *
     * PROGRAMME BOUCLE PRINCIPALE
     C                     EXSR INZSF1
     C                     EXSR LODSF1
      *
     C           *IN03     DOWEQ*OFF
     C                     WRITEFOOT
     C                     EXFMTCTL1
     C           *IN06     IFEQ *ON
     C                     EXSR CREATE
     C                     ELSE
     C                     EXSR SFLOPT
     C           *IN70     IFEQ '1'
     C           MAJ       OREQ '1'
     C                     EXSR INZSF1
     C                     EXSR LODSF1
     C                     ENDIF
     C                     ENDIF
     C                     ENDDO
      *
     C                     SETON                     LR
      *
     * SOUS ROUTINE INIT PGM
     C           *INZSR    BEGSR
     C                     Z-ADD*ZERO     RANG    40
     C                     Z-ADD*ZERO     RANG    40
     C                     MOVE '0'       MAJ     1
     C           PLIDBB    PLIST
     C                     PARM           NUMBER
     C                     ENDSR
      *
     *  SOUS ROUTNE INIT SF1
     C           INZSF1    BEGSR
     C                     SETOF                     818283
     C                     SETON                     80
     C                     WRITECTL1
     C                     SETOF                     80
     C                     Z-ADD*ZERO     RANG
     C                     ENDSR
      *
     * SS ROUTINE CHARGEMENT SF1
     C           LODSF1    BEGSR
     C           FLTNOM    IFNE *BLANK
     C*                    MOVEL*BLANK    FILTR  20
     C*                    MOVELFLTNOM    FILTR
     C           FLTNOM    SETLLFBONBON
     C                     READ FBONBON                  90
     C                     ELSE
     C           *LOVAL    SETLLFBONBON
     C                     READ FBONBON                  90
     C                     ENDIF
      *
     C           *IN90     DOWEQ'0'
     C           RANG      ANDLT9999
     C                     ADD  1         RANG
     C                     WRITESFL1
     C*          RANG      COMP 9999                 90
     C                     READ FBONBON                  90
     C                     ENDDO
      *
     C*          RANG      IFGT 0
     C*                    SETON                     82
     C*                    ENDIF
     C           RANG      COMP *ZERO                82
     C                     SETON                     8183
      *
     C                     ENDSR
      *
      *
     * SOUS ROUTINE TRAITEMENT OPTION SF1
     C           SFLOPT    BEGSR
     C           *IN03     IFEQ '0'
     C                     MOVE '0'       MAJ
      *
     C                     READCSFL1                     85
     C           *IN85     DOWEQ'0'
     C           *IN03     ANDEQ'0'
     C           D1OPT     CASEQ'2'       OPTMOD
     C           D1OPT     CASEQ'4'       OPTDLT
     C           D1OPT     CASEQ'5'       OPTAFF
     C                     ENDCS
      *
     C                     CLEARD1OPT
     C                     UPDATSFL1
     C                     READCSFL1                     85
     C                     ENDDO
      *
      *
     C                     ENDIF
     C                     ENDSR
      *
     * SOUS ROUTINE MODIF OPTMOD
     C           OPTMOD    BEGSR
     C                     CALL 'MODBBN'  PLIDBB
     C                     MOVE '1'       MAJ
     C                     ENDSR
      *
     * SOUS ROUTINE DELET OPTDLT
     C           OPTDLT    BEGSR
     C                     CALL 'DLTBBN'  PLIDBB
     C                     MOVE '1'       MAJ
     C                     ENDSR
      *
     * SOUS ROUTINE AFFCI OPTAFF
     C           OPTAFF    BEGSR
     C                     CALL 'AFFBBN'  PLIDBB
     C                     ENDSR
      *
     * SOUS ROUTINE CREATE
     C           CREATE    BEGSR
     C           'CREATE'  DSPLY
     C                     MOVEL*ZERO     NUMBER
     C                     CALL 'MODBBN'  PLIDBB
     C                     SETOF                     06
     C                     MOVE '1'       MAJ
     C                     ENDSR
      *
```
