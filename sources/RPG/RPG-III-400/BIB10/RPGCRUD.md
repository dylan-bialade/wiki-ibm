---
bibliotheque: BIB10
fichier_source: HINTSRC19
membre: RPGCRUD
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 93
modifie: 2026-11-16
---

# BIB10/HINTSRC19/RPGCRUD

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *=========================================================*
      *             CREATE READ UPDATE DELETE                 *
      *---------------------------------------------------------*
      * FICHIER:                                                *
      * -MONFIC                                                 *
      *   FMTFIC (FORMAT)                                       *
      *   K IDFIC (CLÉ)                                         *
      *=========================================================*
      * ECRAN:                                                  *
      * MONECR                                                  *
      * -FMT1                                                   *
      *  NOM DES ZONES DE L'ECRAN IDENTIQUE AU ZONES DU PF      *
      *                                                         *
      *=========================================================*
      *
     * DÉCLARATON DU FICHIER DATA A
     FMONFIC  UF  E           K        DISK                      A
     FMONECR  CF  E                    WORKSTN
      *
     * DECLARATION PLIST (PARM D'APPEL)
     C           *ENTRY    PLIST
     C                     PARM           ACT     1        ACTIONCRUD
     C                     PARM           IDFIC
      *
     C                     SETON                         LR
      *
      *
      *TRAITEMENT DU CRUD: LA VALEUR D'ACT RENVOI A UNE SOUS ROUTINE
     C           ACT       CASEQ'2'       MODIF
     C           ACT       CASEQ'4'       SUPPR
     C           ACT       CASEQ'5'       AFFIC
     C           ACT       CASEQ'6'       CREER
     C                     ENDCS
      *
      * SOUS ROUTINES
      *
      *SR MODIFICATION
     C           MODIF     BEGSR
     C           IDFIC     CHAINFMTFIC               90
     C           *IN90     DOWEQ'1'
     C                     EXFMTFMT1
     C           *IN03     IFEQ '1'
     C           *IN12     OREQ '1'
     C                     LEAVE
     C                     ENDIF
     C                     UPDATFMTFIC
     C                     LEAVE
     C                     ENDDO
     C                     ENDSR
      *
      *SR SUPPRESSION
     C           SUPPR     BEGSR
     C           IDFIC     CHAINFMTFIC               90
     C           *IN90     DOWEQ'1'
     C                     EXFMTFMT1
     C           *IN03     IFEQ '1'
     C           *IN12     OREQ '1'
     C                     LEAVE
     C                     ENDIF
     C                     DELETFMTFIC
     C                     LEAVE
     C                     ENDDO
     C                     ENDSR
      *
      *SR AFFICHAGE
     C           AFFIC     BEGSR
     C           IDFIC     CHAINFMTFIC               90
     C           *IN90     DOWEQ'0'
     C                     EXFMTFMT1
     C           *IN03     IFEQ '1'
     C           *IN12     OREQ '1'
     C                     LEAVE
     C                     ENDIF
     C                     ENDDO
     C                     ENDSR
      *
      *SR CREATION
     C           CREER     BEGSR
     C           *HIVAL    SETGTFMTFIC
     C                     READPFMTFIC                   90
     C           IDFIC     ADD  1         ID      50
     C                     CLEARFMTFIC
     C                     MOVE ID        IDFIC
     C           1         DOWEQ1
     C                     EXFMTFMT1
     C           *IN03     IFEQ '1'
     C           *IN12     OREQ '1'
     C                     LEAVE
     C                     ENDIF
     C                     WRITEFMTFIC
     C                     LEAVE
     C                     ENDDO
     C                     ENDSR
```
