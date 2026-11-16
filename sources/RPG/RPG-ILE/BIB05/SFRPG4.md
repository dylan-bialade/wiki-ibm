---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: SFRPG4
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 255
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/SFRPG4

```text
     H OPTION(*SRCSTMT) DFTACTGRP(*NO) ACTGRP(*CALLER)
      //*****************************************************************
      // Programme : SFRPG4
      // Formation RPG4 - Sous fichier semi dynamique en RPG4
      // Copyright - ARMONIE
      //
      // Indicateurs utilisés :
      // -----------------------
      // *IN03 : F3 = Quitter le programme
      // *IN06 : F6 = Créer un nouvel article
      // *IN12 : F12 = Retour sans modification/annulation
      // *IN23 : F23 = Validation (Création, Modification, Suppression)
      // *IN31 : Si *OFF alors SFLDSPCTL  sinon SFLCLR
      // *IN32 : Indiquer que le sous-fichier est vide (SFLDSP désactivé)
      // *IN39 : Rollup pour paginer dans le sous-fichier (page suivante)
      // *IN50 : Message de succès pour la Modification
      // *IN51 : Message de succès pour la Création
      // *IN52 : Message de succès pour la Suppression
      // *IN90 : Indicateur de fin de sous-fichier (SFLEND *MORE retiré)
      //
      // Rôle de N31 et N32 dans le DSPF :
      // ---------------------------------
      // N31 : Empêche l'affichage du sous-fichier (pas de SFLDSP) lorsqu'on efface avec SFLCLR.
      //       -> *IN31 = *ON : Efface le contenu du sous-fichier.
      //
      // N32 : Empêche l'affichage du sous-fichier s'il est vide.
      //       -> *IN32 = *ON : Pas d'affichage car aucun enregistrement à montrer.
      //
      // Dans RPG, on pilote donc SFLCLR avec *IN31 et SFLDSP avec *IN32.
      //*****************************************************************

      //*****************************************************************
      // Déclaration des fichiers
      //*****************************************************************
     FSFRDSP    CF   E             WORKSTN SFILE(SFL1:RANG)
     FENTREPOTLFUF A E           K Disk    Prefix(ENT_)

      // Nb de lignes par page sous-fichier
     D SflPag          C                   CONST(12)
     D Afficher        C                   CONST('5')                           // Afficher
     D Supprimer       C                   CONST('4')                           // Supprimer
     D Modifier        C                   CONST('2')                           // Modifier

      //*****************************************************************
      // Déclaration des variables
      //*****************************************************************
     DLAST_RANG        S              4S 0                                      // Dernier rang
     Di                S              4S 0                                      // Index de boucle
     DDatejour         S               D                                        // Date du jour

      //*****************************************************************
      // Traitement principal
      //*****************************************************************
     C                   EXSR      INITIALISATION
     C* Se positionner en début de fichier
     C     *LOVAL        SETLL     ENTREPOTLF
     C* Appel une sous routine pour remplir le sous-fichier
     C                   EXSR      FABRICATION

     C                   EVAL      SCODPRO = *BLANKS

     C* Boucle principale tant que pas F3
     C     *IN03         DOUEQ     *ON
     C* Afficher le pied de page des touches de fonction (F3 par exemple)
     C                   WRITE     FKEY1
     C* Afficher l'écran principal (SF1CTL)
     C                   EXFMT     SF1CTL

     C* Gestion des touches et options
     C                   SELECT
     C                   WHEN      *IN06 = *ON                                  // F6 = Créer
     C                   EXSR      CLR_INDMSG
     C                   EXSR      CREE
     C                   EXSR      INITIALISATION
     C     *LOVAL        SETLL     ENTREPOTLF
     C                   EXSR      FABRICATION

     C                   WHEN      *IN39 = *ON                                  // RollUp
     C                   EXSR      CLR_INDMSG
     C                   EXSR      FABRICATION

     C* Afficher à partir du   code produit
     C                   WHEN      SCODPRO <> *BLANKS
     C     SCODPRO       SETLL     ENTREPOTLF
     C                   EXSR      INITIALISATION
     C                   EXSR      FABRICATION
     C                   EVAL      SCODPRO = *BLANKS

     C* Traitement des options sur sous-fichier
     C                   OTHER

     C* Je chain pour detecter si il y a bien des données dans mon sous fichier
     C     E1CODPRO      CHAIN     ENTREPOTLF
     C* Si il y a des données alors seulement je fais un readc
     C                   IF        %FOUND
     C                   EXSR      TRT_READC
     C                   ENDIF
     C                   ENDSL
     C                   ENDDO

     C                   EVAL      *INLR = *ON

      //*****************************************************************
      // Sous-routines
      //*****************************************************************
      // Initialisation des indicateurs et du sous-fichier
     C     INITIALISATIONBEGSR
     C                   EVAL      RANG = *ZERO
     C                   EVAL      LAST_RANG = *ZERO
     c* Effacer le sous-fichier (SFLCLR)
     C                   EVAL      *IN31 = *ON
     C                   WRITE     SF1CTL
     c* Je remets mes indicateurs à OFF
     C                   EVAL      *IN31 = *OFF
     C                   EVAL      *IN32 = *OFF
     C                   EVAL      *IN90 = *OFF
     C                   EVAL      I = 1
     C                   ENDSR

     C* // Remplissage du sous-fichier
     C     FABRICATION   BEGSR
     C                   EVAL      RANG = LAST_RANG

     C* On va boucler jusqu'au la fin de page , ici jusqu'a 12
     C                   FOR       i = 1 TO SFLPAG
     C* On lit le fichier , on ne mets surtout pas un setll
     C                   READ      ENTREPOTLF
     C* Si fin de fichier on active l'indicateur "fin" en bas de page
     C                   IF        %EOF
     C                   EVAL      *IN90 = *ON
     C                   LEAVE
     C* Sinon on commence à ecrire le sous fichier ligne par ligne
     C* On va répéter ça 12 fois ou moins si il y a moins de données
     C* Grace au leave juste au dessus, faut suivre un peu
     C                   ELSE
     C                   EVAL      RANG += 1
     C                   EVAL      E1CODPRO = ENT_CODPRO
     C                   EVAL      E1NMPRO  = ENT_NMPRO
     C                   EVAL      E1QTPRO  = ENT_QTPRO
     C                   EVAL      E1DTDINV = ENT_DTDINV
     C                   WRITE     SFL1
     C                   ENDIF
     C                   ENDFOR
     C* Si le rang est à 0, on affiche surtout pas le sous fichier
     C* je mets le SFLDSP à *on car dans mon code de l'ecran c'est N32
     C                   IF        RANG = *ZERO
     C                   EVAL      *IN32 = *ON
     C                   ENDIF

     c* Je garde la derniere valeur du rang dans une variable
     c* Comme ça on prochaine Rollup (page suivant) je vais commencer à 13
     C                   EVAL      LAST_RANG = RANG
     C                   ENDSR

     C*// Lecture du sous-fichier et traitement des options
     C     TRT_READC     BEGSR
     C                   EXSR      CLR_INDMSG
     C                   READC     SFL1
     C                   DOW       NOT %eof
     C                   SELECT
     C                   WHEN      OPT = AFFICHER
     C                   EXSR      AFFICHE
     C                   WHEN      OPT = SUPPRIMER
     C                   EXSR      SUPPRIME
     C                   WHEN      OPT = MODIFIER
     C                   EXSR      MODIFIE
     C                   ENDSL
     C                   READC     SFL1
     C                   ENDDO
     C* ce bout de code sert à se repositionner au debut du sous fichier
     C* Apres avoir par exemple supprimer, modifier ou afficher un article
     C                   EXSR      INITIALISATION
     C     *LOVAL        SETLL     ENTREPOTLF
     C                   EXSR      FABRICATION
     C                   ENDSR

     C*// Création d'un nouveau produit
     C     CREE          BEGSR
     C                   EVAL      E6DTDINV = DATEJOUR
     C                   EXFMT     FMT6
     C                   IF        *IN23
     C                   EVAL      ENT_CODPRO = E6CODPRO
     C                   EVAL      ENT_NMPRO  = E6NMPRO
     C                   EVAL      ENT_QTPRO  = E6QTPRO
     C                   EVAL      ENT_DTDINV = E6DTDINV
     C                   WRITE     ENTREPOTF
     C                   EVAL      *IN51 = *ON
     C                   ENDIF
     C                   ENDSR

     C*// Affichage d'un produit
     C     AFFICHE       BEGSR
     C                   EVAL      E5CODPRO = E1CODPRO
     C                   EVAL      E5NMPRO  = E1NMPRO
     C                   EVAL      E5QTPRO  = E1QTPRO
     C                   EVAL      E5DTDINV = E1DTDINV
     C                   EXFMT     FMT5
     C                   EVAL      OPT = *BLANKS
     C                   UPDATE    SFL1
     C                   ENDSR

     C* // Suppression d'un produit
     C     SUPPRIME      BEGSR
     C                   EVAL      E4CODPRO = E1CODPRO
     C                   EVAL      E4NMPRO  = E1NMPRO
     C                   EVAL      E4QTPRO  = E1QTPRO
     C                   EVAL      E4DTDINV = E1DTDINV
     C                   EXFMT     FMT4
     C                   EVAL      OPT = *BLANKS
     C     E4CODPRO      CHAIN     ENTREPOTLF
     C                   IF        %found(ENTREPOTLF)
     C                   IF        *IN23
     C                   DELETE    ENTREPOTF
     C                   EVAL      *IN52 = *ON
     C                   ENDIF
     C                   ENDIF
     C                   UPDATE    SFL1
     C                   ENDSR

     C* // Modification d'un produit
     C     MODIFIE       BEGSR
     C                   EVAL      E2CODPRO = E1CODPRO
     C                   EVAL      E2NMPRO  = E1NMPRO
     C                   EVAL      E2QTPRO  = E1QTPRO
     C                   EVAL      E2DTDINV = E1DTDINV
     C                   DOU       *IN03
     C                   EXFMT     FMT2
     C                   SELECT
     C                   WHEN      *IN03
     C                   ITER
     C                   WHEN      *IN12
     C                   LEAVE
     C                   WHEN      *IN23
     C     E2CODPRO      CHAIN     ENTREPOTLF
     C                   IF        %FOUND(ENTREPOTLF)
     C                   EVAL      ENT_CODPRO = E2CODPRO
     C                   EVAL      ENT_NMPRO  = E2NMPRO
     C                   EVAL      ENT_QTPRO  = E2QTPRO
     C                   EVAL      ENT_DTDINV = E2DTDINV
     C                   UPDATE    ENTREPOTF
     C                   EVAL      OPT = *BLANKS
     C                   UPDATE    SFL1
     C                   EVAL      *IN50 = *ON
     C                   LEAVE
     C                   ENDIF
     C                   ENDSL
     C                   ENDDO
     C                   ENDSR

     C*// Effacer les indicateurs de message
     C     CLR_INDMSG    BEGSR
     C                   EVAL      *in50 = *off
     C                   EVAL      *in51 = *off
     C                   EVAL      *in52 = *off
     C                   ENDSR
```
