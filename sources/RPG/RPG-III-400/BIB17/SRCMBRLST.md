---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: SRCMBRLST
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 65
modifie: 2026-11-16
---

# BIB17/QRPGSRC/SRCMBRLST

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FLSTSRC  IF  E                    DISK
     FSRCMBDSPCF  E                    WORKSTN
     F                                        RANG  KSFILE SFL1
      *
      *
     I           SDS
     I                                        1  10 PGM
      *
     * PROGRAMME BOUCLE PRINCIPALE
     C                     EXSR INZSF1
     C                     EXSR LODSF1
      *
     C           *IN12     DOWEQ*OFF
     C           *IN03     ANDEQ*OFF
     C                     WRITEFOOT
     C                     EXFMTCTL1
     C                     SELEC
     C           *IN12     WHEQ '1'
     C           *IN03     OREQ '1'
     C           *IN21     WHEQ '1'
     C                     CALL 'QUSCMDLN'
      *
     C                     OTHER
     C                     EXSR INZSF1
     C                     EXSR LODSF1
      *
     C                     ENDSL
     C                     ENDDO
      *
     C                     SETON                     LR
      *
     * SOUS ROUTINE INIT PGM
     C           *INZSR    BEGSR
     C*                    MOVE PGM       NMPGM
     C                     Z-ADD*ZERO     RANG    40
     C                     ENDSR
      *
     *  SOUS ROUTNE INIT SF1
     C           INZSF1    BEGSR
     C                     SETOF                     313233
     C                     SETON                     30
     C                     WRITECTL1
     C                     SETOF                     30
     C                     Z-ADD*ZERO     RANG
     C                     ENDSR
      *
     * SS ROUTINE CHARGEMENT SF1
     C           LODSF1    BEGSR
     C           1         SETLLFMTDBX
     C                     READ FMTDBX                   99
      *
     C           *IN99     DOWEQ'0'
     C           RANG      ANDLT9999
      *
     C                     ADD  1         RANG
     C                     WRITESFL1
     C                     READ FMTDBX                   99
     C                     ENDDO
      *
     C           RANG      COMP *ZERO                32
     C                     SETON                     3133
      *
     C                     ENDSR
      *
      *
```
