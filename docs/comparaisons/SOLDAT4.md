# SOLDAT4 : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QRPGLESRC2 | RPG/RPG-ILE | 107 | 38 % | ecran (WORKSTN), CHAIN, SETLL / READ, boucle DOW/DOU/FOR, indicateurs *INxx | [SOLDAT4.md](../../sources/RPG/RPG-ILE/BIB05/SOLDAT4.md) |
| BIB20 | QRPGLESRC | RPG/RPG-ILE | 97 | 100 % | ecran (WORKSTN), CHAIN, SETLL / READ, boucle DOW/DOU/FOR, indicateurs *INxx | [SOLDAT4.md](../../sources/RPG/RPG-ILE/BIB20/SOLDAT4.md) |

## Differences

- Techniques communes : ecran (WORKSTN), CHAIN, SETLL / READ, boucle DOW/DOU/FOR, indicateurs *INxx

## Codes

### BIB05 (RPG/RPG-ILE, 107 lignes)

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

### BIB20 (RPG/RPG-ILE, 97 lignes)

```text
      * PROGRAMME : PSOLDAT
      * AUTEUR    : Geoffrey GAMBÉE - Notos
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
      *   - F23 : MODIFIER LES INFORMATIONS D\ZUN SOLDAT
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
F3   C                   IF         *INKC =*OFF AND *INKF = *OFF
     C* Rechercher le soldat en fonction de son id
     C     IDSLD         CHAIN     SOLDAT                             90
     C* Si je trouve un id soldat
     C                   IF        *IN90 = *OFF
     C* Tant que j'ai pas appuez sur F3 et F12
F3   C                   DOW       *INKC =*OFF AND *INKL = *OFF
     C* Afficher le format d'ecran FMT2
     C                   EXFMT     FMT2
F13  C                   IF        *INKM = *ON
     C                   DELETE    SOLDATR
     C                   EVAL      MES = 'Le soldat a été supprimé'
     C                   LEAVE
     C                   ENDIF
F23  C                   IF        *INKX = *ON
     C                   UPDATE    SOLDATR
     C                   EVAL      MES = 'Le soldat a été modifié'
     C                   LEAVE
     C                   ENDIF
     C                   ENDDO
     C                   ELSE
     C                   EVAL      MES = 'Numéro de soldat inexistant'
     C                   ENDIF
     C                   ENDIF
     C* J'appuie sur la touche F6 Créer
F06  C                   IF        *INKF = *ON
     C                   DOW       1 = 1
     C                   IF        *INKC = *ON OR *INKL = *ON
     C                   LEAVE
     C                   ENDIF
     C* Auto incrémentation en RPG III
     C     *HIVAL        SETLL     SOLDAT
     C                   READP     SOLDAT                                 90
     C* Si le fichier SOLDAT est vide (aucun soldat existant)
     C                   IF        *IN90 = *ON
     C                   EVAL      IDSLD = 1
     C                   ELSE
     C                   EVAL      IDSLD += 1
     C                   ENDIF
     C* Affiche le format FMT3 - Ecran de Création
     C                   EXFMT     FMT3
     C                   IF        IDSLD <> *ZERO AND NMSLD <> *BLANK  AND
     C                             PRSLD <> *BLANK AND ARSLD1 <> *BLANK AND
     C                             CLASLD <> *BLANK
     C* J'ecris seulement si les zones sont remplies
     C                   WRITE     SOLDATR
     C                   EVAL      MES = 'Le soldat a été crée'
     C                   LEAVE
     C                   ENDIF
     C                   ITER
     C                   ENDDO
     C                   ENDIF
     C                   ENDDO
     C                   EVAL      *INLR = *ON
```
