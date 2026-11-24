---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: PSOLDAT2
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 126
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/PSOLDAT2

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
F3   C                   DOW       *INKC = *OFF
     C* Affiche le format d'écran FMT1
     C                   EXFMT     FMT1
     C                   CLEAR                   MES
     C* Si j'ai pas appuyez sur F3 et F6 alors j'éxecute
F3   C                   IF        *INKC = *OFF AND *INKF = *OFF
     C                   EXSR      AFF
     C                   ENDIF
     C* J'appuie sur la touche F6 Créer
F06  C                   IF        *INKF = *ON
     C                   DOW       1 = 1
     C                   IF        *INKC = *ON OR *INKL = *ON
     C                   LEAVE
     C                   ENDIF
     C                   EXSR      AUTOI
     C* Affiche le format FMT3 - Ecran de Création
     C                   EXFMT     FMT3
     C                   IF        IDSLD <> *ZERO AND
     C                             NMSLD <> *BLANK AND
     C                             PRSLD <> *BLANK AND
     C                             ARSLD1 <> *BLANK AND
     C                             CLASLD <> *BLANK
     C                   EXSR      CREA
     C                   LEAVE
     C                   ENDIF
     C                   ITER
     C                   ENDDO
     C                   ENDIF
     C                   ENDDO
     C                   SETON                                        LR
     C*****************************************************
     C* SOUS ROUTINE
     C*****************************************************
     C*Sous routine - Affichage
     C     AFF           BEGSR
     C* RECHERCHER LE SOLDAT EN FONCTION DE SON ID
     C     IDSLD         CHAIN     SOLDAT
     C* Si je trouve un id soldat
     C                   IF        %FOUND()
     C* Tant que j'ai pas appuez sur F3 et F12
F3   C                   DOW       *INKC = *OFF AND *INKL = *OFF
     C* Afficher le format d'ecran FMT2
     C                   EXFMT     FMT2
F13  C                   IF        *INKM = *ON
     C                   EXSR      SUPP
     C                   LEAVE
     C                   ENDIF
F23  C                   IF        *INKX = *ON
     C                   EXSR      MODIF
     C                   LEAVE
     C                   ENDIF
     C                   ENDDO
     C                   ELSE
     C                   EVAL      MES = MSG(3)
     C                   ENDIF
     C                   ENDSR
     C* Sous routine - Suppression
     C     SUPP          BEGSR
     C                   DELETE    SOLDATR
     C                   EVAL      MES = MSG(1)
     C                   ENDSR
     C* Sous routine - Modification
     C     MODIF         BEGSR
     C                   UPDATE    SOLDATR
     C                   EVAL      MES = MSG(2)
     C                   ENDSR
     C* Sous routine - Création
     C* J'ecris seulement si les zones sont remplies
     C     CREA          BEGSR
     C                   WRITE     SOLDATR
     C                   EVAL      MES = MSG(4)
     C                   ENDSR
     C* Sous routine - Auto incrémentation
     C     AUTOI         BEGSR
     C     *HIVAL        SETLL     SOLDAT
     C                   READP     SOLDAT
     C* Si le fichier SOLDAT est vide (aucun soldat existant)
     C                   IF        %FOUND()
     C                   EVAL      IDSLD = 1
     C                   ELSE
     C                   EVAL      IDSLD = IDSLD + 1
     C                   ENDIF
     C                   ENDSR
**
Le Soldat à été supprimé
Le Soldat à été modifié
Numéro de Soldat inexistant
Le Soldat à été créé
```
