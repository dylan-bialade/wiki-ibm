---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: BONBONC
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 102
modifie: 2026-11-16
---

# BIB10/QRPGSRC/BONBONC

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
      * - BONBOND                                       *
      *   - SFL1                                        *
      *   - CTL1                                        *
      *   -FOOT1                                        *
      * LF
      * - BONBONL                                       *
      * CLÉ NOM
      *=================================================*
     F* DECLARATION DE FICHIER
     FBONBOND CF  E                    WORKSTN
     F                                        RANK  KSFILE SFL1
     FBONBONL IF  E           K        DISK
     * INSTRUCTION FIN DE FICHIER
     IFBONBON
     I              COULEUR                         COUL
     ISFL1
     I              COULEUR                         COUL
     C                     SETON                         LR
     * TRAITEMENT PRINCIPAL
     C           PL1       PLIST
     C                     PARM           IND     1
     C                     PARM           NUM     60
     C                     PARM           OPT     1
     C                     MOVEL*OFF      IND
      *
     C           *IN03     DOWEQ*OFF
      *
     C                     EXSR CHARGE
     C                     EXFMTCTL1
     C   03                LEAVE
     * TRAITEMENT DU F5 POUR RÉAFICHER L'ECRAN
     C   05                MOVE *BLANK    E1AFF
     C   05                ITER
     C   06                MOVEL'6'       OPT
     C   06                Z-ADD*ZEROS    NUM
     C   06                CALL 'BONCRUD' PL1
     C   06                ITER
     C   21                CALL 'BONPRT'
     C   21                ITER
     C                     READCSFL1                     96
     C           *IN96     DOWEQ*OFF
     C           E1OPT     IFNE '2'
     C           E1OPT     ANDNE'4'
     C           E1OPT     ANDNE'5'
     C*                    SETON                         44
     C                     LEAVE
     C                     ENDIF
     C                     MOVE NUMBER    NUM
     C                     MOVE E1OPT     OPT
     C                     CALL 'BONCRUD' PL1
     C           IND       COMP '1'                      03
     C                     READCSFL1                     96
     C                     ENDDO
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
     C                     MOVE *BLANK    E1OPT
     C                     ENDSR
      *
     * CHARGEMENT DES DONNÉES DANS LE SFL1
     C           CHARGE    BEGSR
     C                     EXSR INIT
     * PRISE EN CHARGE DE L'AFFICHAGE A PARTIR DE ...
     C           E1AFF     IFNE *BLANK
     C           E1AFF     SETLLFBONBON
     C                     ELSE
     C           *LOVAL    SETLLFBONBON
     C                     ENDIF
     * LECTURE DU FICHIER DATA ET ECRITURE DANS LE SFL1
     C                     READ FBONBON                  90
     C           *IN90     DOWEQ*OFF
     C                     ADD  1         RANK
     C                     WRITESFL1
     C                     READ FBONBON                  90
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
