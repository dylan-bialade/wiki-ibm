---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: SOLDAT4
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 107
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/SOLDAT4

```text
      * PROGRAMME : PSOLDAT
      * AUTEUR    : Sylvain BIB02 - ORGFORM
      * DATE      : [22/10/2025]
      * VERSION   : 1.0
      * DESCRIPTION :
      *   PROGRAMME DE GESTION DES SOLDATS. (CRUD)
      *   PERMET LA CRÉATION, LA MODIFICATION ET LA SUPPRESSION
      *   D'ENREGISTREMENTS DANS LE FICHIER SOLDAT (PF DDS).
      *
      * FONCTIONS :
      *   - F3  : QUITTER LE PROGRAMME
      *   - F6  : CRÉER UN NOUVEAU SOLDAT
      *   - F12 : RETOUR ÉCRAN PRÉCÉDENT
      *   - F13 : SUPPRIMER LE SOLDAT
      *   - F23 : MODIFIER LES INFORMATIONS DUN SOLDAT
      *
      * BASE DE DONNÉES :
      *   FICHIER PHYSIQUE : SOLDAT (CLÉ = IDSLD)
      *   FORMATS ÉCRAN    : FMT1 (MAIN), FMT2 (MODIF/SUPP),
      *                      FMT3 (CRÉATION)
      *
      * NOTES TECHNIQUES :
      *   - AUTO-INCRÉMENTATION SIMULÉE MANUELLEMENT :
      *       LECTURE DU DERNIER ENREGISTREMENT VIA READP
      *       ET AJOUT DE +1 à L'ID LE PLUS ÉLEVÉ.
      *   - MESSAGES STOCKÉS DANS UN TABLEAU MSG
      *
      * HISTORIQUE :
      *   - V1.0 (22/10/2025) : CRÉATION INITIALE DU PROGRAMME.
      *
      *****************************************************************
      * DECLARATION DE FICHIER
     FESOLDAT   CF   E             WORKSTN
     FSOLDAT    UF A E           K DISK
      * DECLARATION DE TABLEAU
     D MSG             S             52    DIM(4) CTDATA PERRCD(1)
      * TRAITEMENT DU PROGRAMME
      * Tantque j'ai pas appuyez sur F3
F3   C     *INKC         DOWEQ     '0'
     C* Affiche le format d'écran FMT1
     C                   EXFMT     FMT1
     C                   CLEAR                   MES
     C* Si j'ai pas appuyez sur F3 et F6 alors j'éxecute
F3   C     *INKC         IFEQ      '0'
F6   C     *INKF         ANDEQ     '0'
     C* Rechercher le soldat en fonction de son id
     C     IDSLD         CHAIN     SOLDAT                             90
     C* Si je trouve un id soldat
     C     *IN90         IFEQ      '0'
     C* Tant que j'ai pas appuez sur F3 et F12
F3   C     *INKC         DOWEQ     '0'
F12  C     *INKL         ANDEQ     '0'
     C* Afficher le format d'ecran FMT2
     C                   EXFMT     FMT2
F13  C     *INKM         IFEQ      '1'
     C                   DELETE    SOLDATR
     C                   MOVE      MSG(1)        MES
     C                   LEAVE
     C                   ENDIF
F23  C     *INKX         IFEQ      '1'
     C                   UPDATE    SOLDATR
     C                   MOVE      MSG(2)        MES
     C                   LEAVE
     C                   ENDIF
     C                   ENDDO
     C                   ELSE
     C                   MOVE      MSG(3)        MES
     C                   ENDIF
     C                   ENDIF
     C* J'appuie sur la touche F6 Créer
F06  C     *INKF         IFEQ      '1'
     C     1             DOWEQ     1
     C     *INKC         IFEQ      '1'
     C     *INKL         OREQ      '1'
     C                   LEAVE
     C                   ENDIF
     C* Auto incrémentation en RPG III
     C     *HIVAL        SETLL     SOLDAT
     C                   READP     SOLDAT                                 90
     C* Si le fichier SOLDAT est vide (aucun soldat existant)
     C     *IN90         IFEQ      '1'
     C                   Z-ADD     1             IDSLD
     C                   ELSE
     C     IDSLD         ADD       1             IDSLD
     C                   ENDIF
     C* Affiche le format FMT3 - Ecran de Création
     C                   EXFMT     FMT3
     C     IDSLD         IFNE      *ZERO
     C     NMSLD         ANDNE     *BLANK
     C     PRSLD         ANDNE     *BLANK
     C     ARSLD1        ANDNE     *BLANK
     C     CLASLD        ANDNE     *BLANK
     C* J'ecris seulement si les zones sont remplies
     C                   WRITE     SOLDATR
     C                   MOVE      MSG(4)        MES
     C                   LEAVE
     C                   ENDIF
     C                   ITER
     C                   ENDDO
     C                   ENDIF
     C                   ENDDO
     C                   SETON                                        LR
**
Le Soldat à été supprimé
Le Soldat à été modifié
Numéro de Soldat inexistant
Le Soldat à été créé
```
