---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: SFBONBONF
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 224
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/SFBONBONF

```rpg
**free
CTL-OPT DFTACTGRP(*NO) ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO);

//*****************************************************************
// Programme : SFRBONBONF
// BIB02 SYLVAIN - EXEMPLE DE SOUS-FICHIER A L'ANCIENNE (CHAIN)
// Date      - 04/11/2025
// Copyright - ORGFORM
//*****************************************************************

//**********************************************************************//
// Déclaration des fichiers                                             //
//**********************************************************************//
DCL-F ebonbonsf WORKSTN SFILE(SFL1:RANG);
DCL-F bonbonl1 keyed USAGE(*UPDATE : *DELETE : *OUTPUT : *INPUT);


//**********************************************************************//
// Déclaration des constantes                                           //
//**********************************************************************//
DCL-C SflPag    CONST(12);   // Nombre de ligne à afficher par page ...
DCL-C Supprimer CONST('4');
DCL-C Modifier  CONST('2');

//**********************************************************************//
// Déclaration des variables                                            //
//**********************************************************************//
DCL-S LAST_RANG ZONED(4:0) INZ(*ZERO);    // Dernier rrn écrit avant pagination
DCL-S i         ZONED(4:0) INZ(*ZERO);

//**********************************************************************//
// Traitement pricipal                                                  //
//**********************************************************************//

// A- Initialisation du sous-fichier
EXSR Initialisation_sous_fichier;

// B- Lecture de la base de données
SETLL *LOVAL bonbonl1; //On positionne la lecture en début de fichier

// C - Fabrication du sous-fichier
EXSR Fabrication_sous_fichier;
// last_rang = 12
snumbb = *zero;

DOU *IN03;  // Sortie si touches F3
  WRITE Fkey1;
  EXFMT Sf1ctl;

  // Et là, on se pose la question : Qu'à fait l'utilisateur ?
  SELECT;
  WHEN *IN06;  // Appuie sur la Touche F6
    EXSR clr_indmsg;
    EXSR Cree;
    EXSR Initialisation_sous_fichier;
    SETLL *LOVAL bonbonl1;  // positionne la lecture en début de fichier
    EXSR Fabrication_sous_fichier;
  WHEN *IN39;  // a-t-il paginé ? // ROLLUP(39)
    EXSR clr_indmsg;
    EXSR Fabrication_sous_fichier;
  WHEN snumbb <> *zero;  // a-t-il touché à la zone "Afficher à partir de" ?
    // On positionne la lecture sur le "Afficher à partir de" saisi à l'écran
    // et on reprend le remplissage
    SETLL snumbb bonbonl1;
    EXSR Initialisation_sous_fichier;
    EXSR Fabrication_sous_fichier;
    CLEAR snumbb;
  OTHER;
    CHAIN e1numbb bonbonl1;    // voir si le fichier est vide
    IF %found();
      EXSR TRT_READC;
    ENDIF;
  ENDSL;
ENDDO;

*Inlr = *On;
return;

//************************************************************************
// Initialisation de sous fichier
//************************************************************************
BEGSR Initialisation_sous_fichier;
  RANG = *ZERO;   // Initialisat° du compteur d'enregistrement.
  LAST_RANG = *ZERO;
  *In31 = *ON;    // Activat° de l'indic de vidage de SFL  (Associé au mot clé SFLCR)
  WRITE Sf1ctl;   // Vidage du sous-fichier
  *In31 = *OFF;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLCLR)
  *In32 = *OFF;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLDSP)
  *In90 = *OFF;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLEND)
  i = 1;
ENDSR;


//************************************************************************
// Fabrication de sous fichier
//************************************************************************
BEGSR Fabrication_sous_fichier;
  RANG = LAST_RANG;        // Le "relative record number" reçoit la valeur du dernier
  // numéro relatif sauvegardé

  FOR i=1 to Sflpag;
    READ bonbonl1;
    IF %eof;          // Fin de fichier ? On enclanche le jolie message
      *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
      LEAVE;
    ELSE;
      // Incrémentation du compteur de ligne
      RANG += 1;  // Incrémentation du compteur de ligne
      // les zones du PF ayant le même nom que celle du SFL, le "move" de celles-ci
      E1NUMBB = NUMBB;
      E1NOM  = NOM;
      E1MARQUE  = MARQUE;
      E1COULEUR = COULEU;
      E1PRIX = PRIX;
      WRITE Sfl1;
    ENDIF;
  ENDFOR;

  IF RANG = *Zero;      // Si aucun enregistrement détecté dans le sous-fichier
    *IN32 = *on;            //   Activer l'indicateur masquant le sous-fichier
  ENDIF;
  LAST_RANG = RANG;        // Sauvegarder le dernier enregistrement chargé
// pour faciliter le chargement de la page suivante
ENDSR;


// ******************************************************************
// Traitement du READC
// ******************************************************************
BEGSR TRT_READC;
  EXSR clr_indmsg;
  READC Sfl1;           // Lecture de toutes les lignes modifiées du SFL
  DOW NOT %eof;         // Tant que toutes les lignes modifiés n'ont pas été traitées
    SELECT;
    WHEN OPT = Supprimer;    // Option 4 supprimer
      EXSR supprime;
    WHEN OPT = Modifier;  // Option 2 modifie
      EXSR modifie;
    ENDSL;
    READC Sfl1;           // Lecture de toutes les lignes du SFL
  ENDDO;
  EXSR Initialisation_sous_fichier;
  SETLL *LOVAL bonbonl1; //On positionne la lecture en début de fichier
  EXSR Fabrication_sous_fichier;
ENDSR;


// ******************************************************************
// Création
// ******************************************************************
BEGSR Cree;
  EXFMT FMT6;
  IF *IN23;
    NUMBB= E6NUMBB;
    NOM  = E6NOM;
    MARQUE  = E6MARQUE;
    COULEU = E6COULEUR;
    PRIX = E6PRIX;
    WRITE fbonbon;
    *in51 = *on;
  ENDIF;
ENDSR;

// ******************************************************************
// Supprimer
// ******************************************************************
BEGSR supprime;
  E4NUMBB= E1NUMBB;
  E4NOM  = E1NOM;
  E4MARQUE  = E1MARQUE;
  E4COULEUR = E1COULEUR;
  E4PRIX = E1PRIX;
  EXFMT FMT4 ;
  CLEAR OPT;        // Remise à blanc de l'option saisie
  CHAIN E4NUMBB bonbonl1;
  IF %found(bonbonl1);
    IF *in23; // Si F23 on active le delete
      delete fbonbon;
      *in52 = *on;
    ENDIF;
  ENDIF;
  UPDATE Sfl1;
ENDSR;


// ******************************************************************
// Modifier
// ******************************************************************
BEGSR modifie;
  E2NUMBB= E1NUMBB;
  E2NOM  = E1NOM;
  E2MARQUE  = E1MARQUE;
  E2COULEUR = E1COULEUr;
  E2PRIX = E1PRIX;
  DOU *IN03;
    EXFMT FMT2 ;
    SELECT;
    WHEN *IN03;
      ITER;
    WHEN *IN12;
      LEAVE;
    WHEN *IN23;
      CHAIN E2NUMBB bonbonl1;
      if %found(bonbonl1);
        NUMBB = E2NUMBB;
        NOM  = E2NOM;
        MARQUE  = E2MARQUE;
        COULEU = E2COULEUR;
        PRIX = E2PRIX;
        UPDATE fbonbon;
        CLEAR OPT;
        UPDATE Sfl1;      // dans le sous-fichier
        *in50 = *on;
        LEAVE;
      ENDIF;
    ENDSL;
  ENDDO;
ENDSR;

BEGSR clr_indmsg;
  *in50 = *off; // On met l'indicateur de message à off
  *in51 = *off; // On met l'indicateur de message à off
  *in52 = *off; // On met l'indicateur de message à off
ENDSR;
```
