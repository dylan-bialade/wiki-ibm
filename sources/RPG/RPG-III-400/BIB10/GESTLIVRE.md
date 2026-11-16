---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: GESTLIVRE
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 154
modifie: 2026-11-16
---

# BIB10/QRPGSRC/GESTLIVRE

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
      * - Ecran:GESTLV                                  *
      *     - FMT1                                      *
      *     - FMT2                                      *
      * - LF: LIVRESL                                   *
      *     - livref                                    *
      *     - key: isbn dec 6 0                         *
      *=================================================*
      *Indicateurs:                                     *
      * - 03 > F3                                       *
      * - 06 > F6                                       *
      * - 23 > F23                                      *
      * - 41 > ISBN non trouvé dans livres              *
      * - 42 > Verrouillage de la zone de saisie FMT2   *
      * - 66 > Verrification action write/delete        *
      *=================================================*
      *
      *Declaration de fichiers
     FLIVRESL UF  E           K        DISK                      A
     FGESTLV  CF  E                    WORKSTN
      *Declration de tableau
      * msg messages d'erreurs sur FMT1
      * act message d'action sur FMT2
     E                    MSG     1   5 65
     E                    ACT     1   3 50
     C                     SETON                         LR
      * Boucle de lecture de l'ecran
     C           *IN03     DOWEQ*OFF
     C                     EXFMTFMT1
     C                     SETOF                       4123
      * Appui de F6 envoi vers sbr SBRCRT
     C           *IN06     IFEQ *ON
     C                     EXSR SBRCRT
     C                     SETOF                     06
     C                     ITER
     C                     ENDIF
      * control presence d'option
     C           E1OPT     IFEQ ' '
     C                     MOVELMSG,2     E1MES
     C                     ITER
     C                     ENDIF
      * acces au livre par l'ISBN donné
     C           E1SBN     CHAINLIVREF               41
     C*
      * chargement des var de l'ecran
     C   41                MOVELMSG,1     E1MES
     C  N41                MOVE ISBN      E2SBN
     C  N41                MOVELTITRE     E2TI
     C  N41                MOVELAUTEUR    E2AUT
     C  N41                MOVELDISPO     E2DSP
     C*
      * Selection de l'action
     C  N41      E1OPT     CASEQ'A'       SBRAFF
     C  N41      E1OPT     CASEQ'M'       SBRMOD
     C  N41      E1OPT     CASEQ'D'       SBRDLT
     C                     ENDCS
     C                     ENDDO
     C*
      *=================================================*
      *                Sous routines                  *
      * SBRAFF => Affichage du livre                    *
      * SBRMOD => Modification du livre                 *
      * SBRDEL => Suppression du livre                  *
      * SBRCRT => Création d'un livre                   *
      *=================================================*
     c*
     C           SBRAFF    BEGSR
     C                     MOVELACT,1     E2ACT
     C                     SETON                         42
     C           1         DOWEQ1
     C                     EXFMTFMT2
     C   03                LEAVE
     C      12             LEAVE
     C                     ENDDO
     C                     MOVE *BLANK    E2ACT
     C                     SETOF                         12
     C                     ENDSR
     C*
      *
     C           SBRMOD    BEGSR
     C                     MOVELACT,2     E2ACT
     C                     SETOF                         42
     C           1         DOWEQ1
     C                     EXFMTFMT2
     C   03                LEAVE
     C      12             LEAVE
     C                     MOVEL*BLANK    AUTEUR
     C                     MOVEL*BLANK    TITRE
     C                     MOVEL*BLANK    DISPO
      *
     C                     MOVELE2AUT     AUTEUR
     C                     MOVELE2TI      TITRE
     C                     MOVELE2DSP     DISPO
     C                     UPDATLIVREF                 66
     C  N66                LEAVE
     C                     ENDDO
     C                     MOVE *BLANK    E2ACT
     C  N66                MOVE ISBN      SBN     6
     C  N66      MSG,4     CAT  SBN:1     E1MES
     C                     SETOF                       1266
     C                     ENDSR
     C*
      *
     C           SBRDLT    BEGSR
     C                     MOVELACT,3     E2ACT
     C                     SETON                         42
     C           1         DOWEQ1
     C                     EXFMTFMT2
     C   03                LEAVE
     C      12             LEAVE
     C   23                DELETLIVREF
     C   23                LEAVE
     C                     ENDDO
     C   23                MOVE E2SBN     SBN     6
     C   23      MSG,3     CAT  SBN:1     E1MES
     C   23                MOVE *BLANK    E2ACT
     C                     SETOF                       1223
     C                     ENDSR
     C*
      *
     C           SBRCRT    BEGSR
     C           *HIVAL    SETLLLIVREF
     C                     READPLIVREF                   99
     C                     ADD  1         ISBN
     C                     MOVE ISBN      E2SBN
     C           1         DOWEQ1
     C                     EXFMTFMT2
     C   03                LEAVE
     C      12             LEAVE
     C                     MOVELE2TI      TITRE
     C                     MOVELE2AUT     AUTEUR
     C                     MOVELE2DSP     DISPO
     C                     WRITELIVREF
     C           ISBN      CHAINLIVREF               66
     C  N66                LEAVE
     C                     ENDDO
     C  N66                MOVE ISBN      SBN     6
     C  N66      MSG,4     CAT  SBN:1     E1MES
     C                     SETOF                       1266
     C                     ENDSR
**
ISBN inconu, veuillez en saisir un autre ou le créer
Veuillez indiquer une action autorisée
Livre Supprimé! ISBN:
Livre Ajouté! ISBN:
Livre Modifié! ISBN:
**
Appuyez sur F12 pour quiter
Appuyez sur Entrer pour valider la modification
Appuyez sur F23 pour valider la suppression
```
