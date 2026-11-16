---
bibliotheque: BIB05
fichier_source: QRPGLESRC
membre: GESTECRAN
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 64
modifie: 2026-11-16
---

# BIB05/QRPGLESRC/GESTECRAN

```text
      *NOMPGM:GESTIONAIRE LIVRE
      *NOMPROP:BIB05
      *FILLEDEPEND:LIVRES(DTA) LIVRESL(LF) LIVRESDS(ECRAN)
     * SI TU VOIS SA TU A COPIER BIB05
      *============================================================
     FLIVRESDS  CF   E             WORKSTN
     FLIVRESL   UF A E           K DISK
     C     DEBUT         TAG
     C                   SETOFF                                       12        OFF RETOUR
     C                   EXFMT     FMT1
     C     ISBN          SETLL     LIVREF
     C                   READ      LIVREF                                 90
      * BOUCLE EXIT
     C     *IN03         DOWEQ     *OFF                                         EXIT
      *SI 12 RETOUR ECRAN AVANT
     C     *IN12         IFEQ      *ON                                          RETURN
     C                   GOTO      DEBUT
     C                   ENDIF
     C     *IN90         IFEQ      *OFF
     C     OPT           COMP      'M'                                    91    INDI DE MODIF
     C     OPT           COMP      'D'                                    92    INDI DE DELETE
      *DEBUT MODIF
     C     *IN91         IFEQ      *ON
     C                   MOVE      'MODIF'       MSG
     C     ISBN          CHAIN     LIVREF                             90
     C                   MOVEL     TITRE         TITRE
     C                   MOVEL     AUTEUR        AUTEUR
     C                   MOVEL     DISPO         DISPO
     C                   EXFMT     FMT2
     C                   UPDATE    LIVREF
     C                   ENDIF
      *DEBUT SUPP
     C     *IN92         IFEQ      *ON
     C                   MOVE      'DELETE'      MSG
     C                   EXFMT     FMT2
     C     *IN23         IFEQ      *ON
     C     ISBN          CHAIN     LIVREF                             90
     C                   EXFMT     FMT2
     C                   DELETE    LIVREF
     C                   ENDIF
     C                   ENDIF
      *DEBUT CRÉATION
     C     *IN06         IFEQ      *ON
     C                   MOVE      'CREATE'      MSG
     C     *HIVAL        CHAIN     LIVREF                             90
     C                   ADD       1             ISBN
     C                   MOVEL     *BLANK        TITRE
     C                   MOVEL     *BLANK        AUTEUR
     C                   MOVEL     *BLANK        DISPO
     C                   MOVEL     TITRE         TITRE
     C                   MOVEL     AUTEUR        AUTEUR
     C                   MOVEL     DISPO         DISPO
     C                   EXFMT     FMT2
     C                   WRITE     LIVREF
     C                   ENDIF
      *DEBUT SI ERR
     C                   ELSE
     C                   MOVEL     'PAS LA'      TITRE
     C                   EXFMT     FMT2
     C                   GOTO      DEBUT
     C                   ENDIF
     C                   EXFMT     FMT2
     C                   ENDDO
     C                   SETON                                        LR
```
