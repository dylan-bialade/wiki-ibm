---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: RPGTPSR
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 125
modifie: 2026-11-16
---

# BIB20/QRPGSRC/RPGTPSR

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      * PROGRAMME : PSOLDAT
      * AUTEUR    : Sylvain BIB02 - Notos
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
      *   FICHIER PHYSIQUE : SOLDATSR (CLÉ = IDSLD)
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
     FESOLDAT CF  E                    WORKSTN
     FSOLDATSRUF  E           K        DISK                      A
      * DECLARATION DE TABLEAU
     E                    MSG     1   4 52
      * TRAITEMENT DU PROGRAMME
      * Tantque j'ai pas appuyez sur F3
F3   C           *INKC     DOWEQ'0'
     C* Affiche le format d'écran FMT1
     C                     EXFMTFMT1
     C                     CLEARMES
     C* Si j'ai pas appuyez sur F3 et F6 alors j'éxecute
F3   C           *INKC     IFEQ '0'
F6   C           *INKF     ANDEQ'0'
     C* Rechercher le soldat en fonction de son id
     C           IDSLD     CHAINSOLDATSR             90
     C* Si je trouve un id soldat
     C           *IN90     IFEQ '0'
     C                     EXSR SRAFF
     C                     ELSE
     C                     MOVE MSG,3     MES
     C                     ENDIF
     C                     ENDIF
     C* J'appuie sur la touche F6 Créer
F06  C           *INKF     IFEQ '1'
     C                     EXSR SRCRE
     C                     ENDIF
     C                     ENDDO
     C                     SETON                     LR
      *SOUS-ROUTINE DE CREATION
     C           SRCRE     BEGSR
     C           1         DOWEQ1
     C           *INKC     IFEQ '1'
     C           *INKL     OREQ '1'
     C                     LEAVE
     C                     ENDIF
     C* AUTO INCRÉMENTATION EN RPG III
     C           *HIVAL    SETLLSOLDATSR
     C                     READPSOLDATSR                 90
     C* SI LE FICHIER SOLDAT EST VIDE (AUCUN SOLDAT EXISTANT)
     C           *IN90     IFEQ '1'
     C                     Z-ADD1         IDSLD
     C                     ELSE
     C           IDSLD     ADD  1         IDSLD
     C                     ENDIF
     C* AFFICHE LE FORMAT FMT3 - ECRAN DE CRÉATION
     C                     EXFMTFMT3
     C           IDSLD     IFNE *ZERO
     C           NMSLD     ANDNE*BLANK
     C           PRSLD     ANDNE*BLANK
     C           ARSLD1    ANDNE*BLANK
     C           CLASLD    ANDNE*BLANK
     C* J'ecris seulement si les zones sont remplies
     C                     WRITESOLDATR
     C                     MOVE MSG,4     MES
     C                     LEAVE
     C                     ENDIF
     C                     ITER
     C                     ENDDO
     C                     ENDSR
      *SOUS-ROUTINE D'AFFICHAGE
     C           SRAFF     BEGSR
     C* TANT QUE J'AI PAS APPUEZ SUR F3 ET F12
F3   C           *INKC     DOWEQ'0'
F12  C           *INKL     ANDEQ'0'
     C* AFFICHER LE FORMAT D'ECRAN FMT2
     C                     EXFMTFMT2
     C                     EXSR SRDEL
     C                     EXSR SRUPD
F13  C           *INKM     IFEQ '1'
F23  C           *INKX     OREQ '1'
     C                     LEAVE
     C                     ENDIF
     C                     ENDDO
     C                     ENDSR
      *SOUS-ROUTINE DE SUPPRESSION
     C           SRDEL     BEGSR
F13  C           *INKM     IFEQ '1'
     C                     DELETSOLDATR
     C                     MOVE MSG,1     MES
     C                     ENDIF
     C                     ENDSR
      *SOUS-ROUTINE DE MODIFICATION
     C           SRUPD     BEGSR
F23  C           *INKX     IFEQ '1'
     C                     UPDATSOLDATR
     C                     MOVE MSG,2     MES
     C                     ENDIF
     C                     ENDSR
**
Le Soldat à été supprimé
Le Soldat à été modifié
Numéro de Soldat inexistant
Le Soldat à été créé
```
