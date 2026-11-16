---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: GESTSLDT
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 201
modifie: 2026-11-16
---

# BIB10/QRPGSRC/GESTSLDT

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *=================================================*
      *              GESTIONAIRE LIVRE                *
      * Affichage/modification/suppression de livres  *
      *=================================================*
      *Fichiers:                                        *
      * - Ecran:SOLDATD                                 *
      *     - FMT1                                      *
      *     - FMT2                                      *
      * - LP: SOLDAT                                    *
      *     - SOLDATR                                   *
      *     - key: IDSLD dec 100                        *
      *=================================================*
      *Indicateurs:                                     *
      * - 03 > F3                                       *
      * - 02 > F2
      * - 06 > F6                                       *
      * - 07 > F7
      * - 12 > F12                                      *
      * - 23 > F23
      * - 30 > MODE AFFICHAGE
      * - 40 > VERROUILAGE DE ZONES DE SAISIE           *
      * - 91 > AFFICHAGE ERREURS
      *=================================================*
      *
      *Declaration de fichiers
     FSOLDAT  UF  E           K        DISK                      A
     FSOLDATD CF  E                    WORKSTN
      *Declration de tableau
      * msg messages d'erreurs sur FMT1
      * act message d'action sur FMT2
     E                    ERR     1   3 65
     E                    MOD     1   3 50
     E                    HNT     1   3 50
     E                    ACT     1   2 70
     E                    CLA     1   6 30
     C                     SETON                         LR
      * Boucle de lecture de l'ecran
     C           *IN03     DOWEQ*OFF
     C                     EXFMTFMT1
     C                     Z-ADD*ZEROS    X       10
     C                     SETOF                     91
      * Appui de F6 envoi vers sbr SBRCRT
     C           *IN06     IFEQ *ON
     C                     EXSR SBRCRT
     C                     SETOF                     06
     C                     ITER
     C                     ENDIF
      * acces au SOLDAT PAS L'ID donné
     C           IDSLD     CHAINSOLDATR              41
     C*
      * chargement des var de l'ecran
     C   41                Z-ADD1         X
     C   41                EXSR ERROR
     C   41                ITER
     C*
      * AFFICHAGE DU SOLDAT
     C           *IN41     IFEQ *OFF
     C                     MOVELMOD,1     E2MOD
     C                     MOVEL*BLANK    E2HINT
     C                     MOVELACT,1     E2ACT
     C                     SETON                         40
     C           1         DOWEQ1
     C                     EXFMTFMT2
     C   03                LEAVE
     C   12                LEAVE
     C           *IN02     CASEQ*ON       SBRMOD
     C           *IN07     CASEQ*ON       SBRDLT
     C                     ENDCS
     C   12                LEAVE
     C                     ENDDO
     C                     SETOF                       3012
     C                     MOVE *BLANK    E2MOD
     C                     MOVE *BLANK    E2HINT
     C                     MOVE *BLANK    E2ACT
     C*
     C                     ENDIF
     C                     ENDDO
     C*
      *=================================================*
      *                Sous routines                  *
      * ERROR  => gestion d'erreurs                     *
      * CLEAR  => mise a blanc des variable d'ecran     *
      * SBRMOD => Modification du soldat                *
      * SBRDEL => Suppression du soldat                 *
      * SBRCRT => Création d'un soldat                  *
      *=================================================*
     C*
     C           ERROR     BEGSR
     C                     SETON                     91
     C                     MOVELERR,X     EERR
     C                     ENDSR
     C           CLEAR     BEGSR
     C                     MOVE *BLANK    E2MOD
     C                     MOVE *BLANK    E2HINT
     C                     MOVE *BLANK    E2ACT
     C                     ENDSR
     C*
      *
     C           SBRMOD    BEGSR
     C                     EXSR CLEAR
     C                     MOVELMOD,2     E2MOD
     C                     MOVELHNT,2     E2HINT
     C                     MOVELACT,2     E2ACT
     C                     SETOF                       0240
     C                     SETON                         30
     C           1         DOWEQ1
     C                     EXFMTFMT2
     C                     MOVE *BLANK    EERR
     C   03                LEAVE
     C      12             LEAVE
     C           *IN23     IFEQ *ON
     C                     EXSR VERIF
     C      91             Z-ADD3         X
     C      91             EXSR ERROR
     C      91             ITER
     C     N91             UPDATSOLDATR
     C                     SETON                       12
     C      23             LEAVE
     C                     ENDIF
     C                     ENDDO
     C                     SETOF                         6630
     C                     SETOF                       2391
     C                     ENDSR
     C*
      *
     C           SBRDLT    BEGSR
     C           1         DOWEQ1
     C                     EXFMTFMT2
     C   03                LEAVE
     C      12             LEAVE
     C   07                DELETSOLDATR
     C   07                LEAVE
     C                     ENDDO
     C                     ENDSR
     C*
      *
     C           SBRCRT    BEGSR
     C           *HIVAL    SETLLSOLDATR
     C                     READPSOLDATR                  99
     C                     ADD  1         IDSLD
     C                     MOVE *BLANK    NMSLD
     C                     MOVE *BLANK    PRSLD
     C                     MOVE *BLANK    ARSLD1
     C                     MOVE *BLANK    CLASLD
     C                     EXSR CLEAR
     C                     MOVELMOD,3     E2MOD
     C                     MOVELHNT,1     E2HINT
     C                     MOVELACT,2     E2ACT
     C                     SETOF                         40
     C                     SETON                         30
     C           1         DOWEQ1
     C                     EXFMTFMT2
     C                     MOVE *BLANK    EERR
     C   03                LEAVE
     C      12             LEAVE
     C           *IN23     IFEQ *ON
     C                     EXSR VERIF
     C      91             Z-ADD3         X
     C      91             EXSR ERROR
     C      91             ITER
     C     N91             WRITESOLDATR
     C           IDSLD     CHAINSOLDATR              66
     C  N66                SETON                     12
     C      23             LEAVE
     C                     ENDIF
     C                     ENDDO
     C                     SETOF                     239166
     C                     ENDSR
     C*
     C*
     C           VERIF     BEGSR
     C           CLASLD    IFNE CLA,1
     C           CLASLD    ANDNECLA,2
     C           CLASLD    ANDNECLA,3
     C           CLASLD    ANDNECLA,4
     C           CLASLD    ANDNECLA,5
     C           CLASLD    ANDNECLA,6
     C                     SETON                     91
     C                     ENDIF
     C                     ENDSR
**
Le soldat n'existe pas!           *
L'arme n'existe pas!              *
La classe n'est pas valide !
**
Affichage d'un soldat
Modification d'un soldat
Création d'un soldat
**
Ajouter les données du soldat, puis appuyez sur F23
Modifier les données du soldat, puis appuyez sur F23
**
F2=Modifier  F7=Supprimer  F3=Exit  F12=Retour
F3=Exit  F12=Retour  F23=Validation
**
Soldat
Adepte
Porte étendard
Franc tireur
Sentinelle
Ingénieur
```
