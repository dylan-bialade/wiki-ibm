---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: CLIRPG
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 99
modifie: 2026-11-16
---

# BIB10/QRPGSRC/CLIRPG

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
      * - CLIDSP                                        *
      *   - SFL1                                        *
      *   - CTL1                                        *
      *   -FOOT1                                        *
      * LF
      * - FICCLI                                        *
      * CLÉ CLIDCL
      *=================================================*
     F* DECLARATION DE FICHIER
     FCLIDSP  CF  E                    WORKSTN
     F                                        RANK  KSFILE SFL1
     FFICCLI  IF  E           K        DISK
     * INSTRUCTION FIN DE FICHIER
     C                     SETON                         LR
      * PLIST POUR LE CRUD
     C           PL1       PLIST
     C                     PARM           IND     1
     C                     PARM           E1OPT
     C                     PARM           CLIDCL
     C                     MOVE *OFF      IND
     * TRAITEMENT PRINCIPAL
     C           *IN03     DOWEQ*OFF
      *
     C                     EXSR CHARGE
     C                     EXFMTCTL1
     C           FDPT      COMP *BLANK               5555
     C   03                LEAVE
     * TRAITEMENT DU F5 POUR RÉAFICHER L'ECRAN
     C   05                ITER
     C   06                MOVEL'1'       E1OPT
     C   06                EXSR CRUD
     C   21                CALL 'CLIPRTL'
     C*
     C                     READCSFL1                     91
     C           *IN91     DOWEQ*OFF
     C                     EXSR CRUD
     C                     MOVE *BLANK    E1OPT
     C                     UPDATSFL1
     C                     READCSFL1                     91
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
     C                     ENDSR
     C*
     C           FORM      BEGSR
     C                     TESTN          CLTECL     64
     C   64                MOVE CLTECL    TEL
     C  N64                MOVE *BLANK    TEL
     C                     MOVELCLCPCL    DPT
     C                     MOVELCLMACL    MAIL
     C                     ENDSR
      *
     *CHARGEMENT DES DONNÉES DANS LE SFL1
     C           CHARGE    BEGSR
     C                     EXSR INIT
     * PRISE EN CHARGE DE L'AFFICHAGE A PARTIR DE ...
     C           *LOVAL    SETLLCLIENTSF
     * LECTURE DU FICHIER DATA ET ECRITURE DANS LE SFL1
     C                     READ CLIENTSF                 90
     C           *IN90     DOWEQ*OFF
     C                     EXSR FORM
     C   55      FDPT      COMP DPT                      56
     C   55 56             ADD  1         RANK
     C   55 56             WRITESFL1
     C  N55                ADD  1         RANK
     C  N55                WRITESFL1
     C                     READ CLIENTSF                 90
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
      * SOUS ROUTINE DU CRUD
     C           CRUD      BEGSR
     C                     CALL 'CLICRUD' PL1
     C                     ENDSR
```
