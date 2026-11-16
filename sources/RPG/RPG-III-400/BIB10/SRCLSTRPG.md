---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: SRCLSTRPG
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 71
modifie: 2026-11-16
---

# BIB10/QRPGSRC/SRCLSTRPG

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *=================================================*
      *               BONBON RPG                      *
      *                                               *
      *=================================================*
      * FICHIER                                         *
      * DSPF:                                           *
      * - LSTSRCD                                       *
      *   - SFL1                                        *
      *   - CTL1                                        *
      *   - FOOT1                                       *
      * LF
      * - MBRLSTL                                       *
      * CLÉ DBXFIL
      *=================================================*
     F* DECLARATION DE FICHIER
     FLSTSRCD CF  E                    WORKSTN
     F                                        RANK  KSFILE SFL1
     FMBRLSTL IF  E           K        DISK
     * INSTRUCTION FIN DE FICHIER
     C                     SETON                         LR
     * TRAITEMENT PRINCIPAL
      *
     C           *IN03     DOWEQ*OFF
      *
     C                     EXSR CHARGE
     C                     EXFMTCTL1
     C   03                LEAVE
     * TRAITEMENT DU F5 POUR RÉAFICHER L'ECRAN
     C   05                MOVE *BLANK    CAFF
     C   05                ITER
     C   22                CALL 'QUSCMDLN'
     C                     ENDDO
     * FIN DU TRAITEMENT PRINCIPAL
      *
      *=================================================*
      *          SOUS ROUTINES                        *
      *                                                 *
      *=================================================*
      *
     * INITIALISATION DU SFL
     C           INIT      BEGSR
     C                     SETON                         82
     C                     WRITECTL1
     C                     SETOF                         82
     C                     Z-ADD*ZEROS    RANK    40
     C                     ENDSR
      *
     * CHARGEMENT DES DONNÉES DANS LE SFL1
     C           CHARGE    BEGSR
     C                     EXSR INIT
     * PRISE EN CHARGE DE L'AFFICHAGE A PARTIR DE ...
     C           CAFF      COMP *BLANK               5555
     C   55      CAFF      SETLLFMTDBX
     C  N55      *LOVAL    SETLLFMTDBX
     * LECTURE DU FICHIER DATA ET ECRITURE DANS LE SFL1
     C                     READ FMTDBX                   90
     C           *IN90     DOWEQ*OFF
     C                     ADD  1         RANK
     C                     WRITESFL1
     C                     READ FMTDBX                   90
     C                     ENDDO
     C           RANK      IFNE 0
     C                     SETON                     808183
     C                     ELSE
     C                     SETON                     8183
     C                     ENDIF
     C                     WRITEFOOT1
     C                     WRITECTL1
     C                     SETOF                     808183
     C                     ENDSR
     C*
```
