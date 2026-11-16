---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: GESTECRAN
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 64
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/GESTECRAN

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *NOMPGM:GESTIONAIRE LIVRE
      *NOMPROP:BIB05
      *FILLEDEPEND:LIVRES(DTA) LIVRESL(LF) LIVRESDS(ECRAN)
     * SI TU VOIS SA TU A COPIER BIB05
      *============================================================
     FLIVRESDSCF  E                    WORKSTN
     FLIVRESL UF  E           K        DISK                      A
     C           DEBUT     TAG
     C                     SETOF                     12    OFF RETOUR
     C                     EXFMTFMT1
     C           ISBN      SETLLLIVREF
     C                     READ LIVREF                   90
      * BOUCLE EXIT
     C           *IN03     DOWEQ*OFF                       EXIT
      *SI 12 RETOUR ECRAN AVANT
     C           *IN12     IFEQ *ON                        RETURN
     C                     GOTO DEBUT
     C                     ENDIF
     C           *IN90     IFEQ *OFF
     C           OPT       COMP 'M'                      91INDI DE MODIF
     C           OPT       COMP 'D'                      92INDI DE DELETE
      *DEBUT MODIF
     C           *IN91     IFEQ *ON
     C                     MOVE 'MODIF'   MSG
     C           ISBN      CHAINLIVREF               90
     C                     MOVELTITRE     TITRE
     C                     MOVELAUTEUR    AUTEUR
     C                     MOVELDISPO     DISPO
     C                     EXFMTFMT2
     C                     UPDATLIVREF
     C                     ENDIF
      *DEBUT SUPP
     C           *IN92     IFEQ *ON
     C                     MOVE 'DELETE'  MSG
     C                     EXFMTFMT2
     C           *IN23     IFEQ *ON
     C           ISBN      CHAINLIVREF               90
     C                     EXFMTFMT2
     C                     DELETLIVREF
     C                     ENDIF
     C                     ENDIF
      *DEBUT CRÉATION
     C           *IN06     IFEQ *ON
     C                     MOVE 'CREATE'  MSG
     C           *HIVAL    CHAINLIVREF               90
     C                     ADD  1         ISBN
     C                     MOVEL*BLANK    TITRE
     C                     MOVEL*BLANK    AUTEUR
     C                     MOVEL*BLANK    DISPO
     C                     MOVELTITRE     TITRE
     C                     MOVELAUTEUR    AUTEUR
     C                     MOVELDISPO     DISPO
     C                     EXFMTFMT2
     C                     WRITELIVREF
     C                     ENDIF
      *DEBUT SI ERR
     C                     ELSE
     C                     MOVEL'PAS LA'  TITRE
     C                     EXFMTFMT2
     C                     GOTO DEBUT
     C                     ENDIF
     C                     EXFMTFMT2
     C                     ENDDO
     C                     SETON                     LR
```
