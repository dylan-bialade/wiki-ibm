---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: EXAMPLESF
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 46
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/EXAMPLESF

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
     FEXAMPSSFCF  E                    WORKSTN
     F                                        RRN   KSFILE SFL1
     FLIVRESL IF  E           K        DISK
     C           DEBUT     TAG
     C           *IN03     DOWEQ*OFF
     C                     SETON                     LR
     C                     SETON                     32
     C                     WRITECTL1
     C                     SETOF                     32
     C                     Z-ADD0         RRN     40
     C           *LOVAL    SETLLLIVREF
     C                     READ LIVREF                   90
     C           *IN90     DOWEQ'0'
     C                     SETOF                     32
     C                     ADD  1         RRN
      *AJOUTER LES MOVE
     C                     MOVELTITRE     VAL1
     C                     MOVELAUTEUR    VAL2
     C                     MOVELDISPO     VAL3
     C                     WRITESFL1
     C                     READ LIVREF                   90
     C                     ENDDO
     C                     SETON                         31
     C           RRN       IFGT 0
     C                     SETON                         30
     C                     SETON                         31
      *ADD WRIT SUR CTL
     C                     WRITECTL1
     C                     ENDIF
     C                     WRITEFOOTER
     C                     EXFMTCTL1
     C   05                GOTO DEBUT
     C                     ENDDO
     C*
     C*
     C*                    READCSFL1                     95
     C*          *IN95     DOWEQ*OFF
     C*          OPT       IFEQ '5'
     C*                    ... LOGIQUE POUR AFFICHER LE DÉTAIL ...
     C*                    ENDIF
     C*                    READCSFL1                     95
     C*                    ENDDO
```
