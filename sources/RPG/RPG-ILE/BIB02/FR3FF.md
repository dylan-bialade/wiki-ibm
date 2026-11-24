---
bibliotheque: BIB02
fichier_source: QVSRC
membre: FR3FF
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 240
modifie: 2026-11-16
---

# BIB02/QVSRC/FR3FF

```rpg
**free
CTL-OPT DFTACTGRP(*NO) ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO);


//*****************************************************************
// Programme : FR3FF
// BIB02 SYLVAIN - EXEMPLE DE SOUS-FICHIER A L'ANCIENNE (CHAIN)
// Date      - 23/02/2025
// Copyright - ORGFORM
//*****************************************************************

//**********************************************************************//
// Déclaration des fichiers                                             //
//**********************************************************************//
DCL-F SFRDSP WORKSTN SFILE(SFL1:RANG); // Mon écran
DCL-F entrepotlf disk USAGE(*UPDATE : *DELETE : *OUTPUT : *INPUT) keyed
prefix(ent_); // Le fichier LF

//**********************************************************************//
// Déclaration des constantes                                           //
//**********************************************************************//
DCL-C SflPag    CONST(12);   // Nombre de ligne à afficher par page ...
DCL-C Afficher  CONST('5');
DCL-C Supprimer CONST('4');
DCL-C Modifier  CONST('2');

//**********************************************************************//
// Déclaration des variables                                            //
//**********************************************************************//
DCL-S LAST_RANG ZONED(4:0) INZ(*ZERO);    // Dernier rrn écrit avant pagination
DCL-S i         ZONED(4:0) INZ(*ZERO);
DCL-S datejour  DATE(*ISO) INZ(*JOB);

//**********************************************************************//
// Traitement pricipal                                                  //
//**********************************************************************//

// A- Initialisation du sous-fichier
Initialisation_sous_fichier();

// B- Lecture de la base de données
SETLL *LOVAL entrepotlf; //On positionne la lecture en début de fichier

// C - Fabrication du sous-fichier
 Fabrication_sous_fichier();
// last_rang = 12
SCODPRO = *BLANKS;

DOU *IN03;  // Sortie si touches F3
  WRITE Fkey1;
  EXFMT Sf1ctl;

  // Et là, on se pose la question : Qu'à fait l'utilisateur ?
  SELECT;
  WHEN *IN06;  // Appuie sur la Touche F6
     clr_indmsg(); // Je remets à *off mets indicateurs
     Cree(); // J'appelle la procédure Cree
     Initialisation_sous_fichier();
    SETLL *LOVAL entrepotlf;  // positionne la lecture en début de fichier
     Fabrication_sous_fichier();
  WHEN *IN39;  // a-t-il paginé ? // ROLLUP(39)
     clr_indmsg(); // Je remets à *off mets indicateurs
     Fabrication_sous_fichier();
  WHEN SCODPRO <> *BLANKS;  // a-t-il touché à la zone "Afficher à partir de" ?
    // On positionne la lecture sur le "Afficher à partir de" saisi à l'écran
    // et on reprend le remplissage
    SETLL (SCODPRO) ENTREPOTLF;
    Initialisation_sous_fichier();
    Fabrication_sous_fichier();
    CLEAR scodpro;
  OTHER;
    CHAIN e1codpro entrepotlf;    // voir si le fichier est vide
    IF %found();
       TRT_READC();
    ENDIF;
  ENDSL;
ENDDO;

*Inlr = *On;

//************************************************************************
// Initialisation de sous fichier
//************************************************************************
 DCL-PROC Initialisation_sous_fichier;
  RANG = *ZERO;   // Initialisat° du compteur d'enregistrement.
  LAST_RANG = *ZERO;
  *In31 = *ON;    // Activat° de l'indic de vidage de SFL  (Associé au mot clé SFLCR)
  WRITE Sf1ctl;   // Vidage du sous-fichier
  *In31 = *OFF;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLCLR)
  *In32 = *OFF;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLDSP)
  *In90 = *OFF;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLEND)
  i = 1;
END-PROC;


//************************************************************************
// Fabrication de sous fichier
//************************************************************************
DCL-PROC Fabrication_sous_fichier;
  RANG = LAST_RANG;        // Le "relative record number" reçoit la valeur du dernier
  // numéro relatif sauvegardé

  FOR i=1 to Sflpag;
    READ ENTREPOTLF;
    IF %eof;          // Fin de fichier ? On enclanche le jolie message
      *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
      LEAVE;
    ELSE;
      // Incrémentation du compteur de ligne
      RANG += 1;  // Incrémentation du compteur de ligne
      // les zones du PF ayant le même nom que celle du SFL, le "move" de celles-ci
      E1CODPRO = ENT_CODPRO;
      E1NMPRO  = ENT_NMPRO;
      E1QTPRO  = ENT_QTPRO;
      E1DTDINV = ENT_DTDINV;
      WRITE Sfl1;
    ENDIF;
  ENDFOR;

  IF RANG = *Zero;      // Si aucun enregistrement détecté dans le sous-fichier
    *IN32 = *on;            //   Activer l'indicateur masquant le sous-fichier
  ENDIF;
  LAST_RANG = RANG;        // Sauvegarder le dernier enregistrement chargé
// pour faciliter le chargement de la page suivante
END-PROC;


// ******************************************************************
// Traitement du READC
// ******************************************************************
DCL-PROC TRT_READC;
   clr_indmsg();
  READC Sfl1;           // Lecture de toutes les lignes modifiées du SFL
  DOW NOT %eof;         // Tant que toutes les lignes modifiés n'ont pas été traitées
    SELECT;
    WHEN OPT = Afficher;  // Option 5 affiche
       affiche();
    WHEN OPT = Supprimer;    // Option 4 supprimer
       supprime();
    WHEN OPT = Modifier;  // Option 2 modifie
       modifie();
    ENDSL;
    READC Sfl1;           // Lecture de toutes les lignes du SFL
  ENDDO;
  Initialisation_sous_fichier();
  SETLL *LOVAL entrepotlf; //On positionne la lecture en début de fichier
  Fabrication_sous_fichier();
END-PROC;


// ******************************************************************
// Création
// ******************************************************************
DCL-PROC Cree;
  E6DTDINV = datejour;
  EXFMT FMT6;
  IF *IN23;
    ENT_CODPRO = E6CODPRO;
    ENT_NMPRO  = E6NMPRO;
    ENT_QTPRO  = E6QTPRO;
    ENT_DTDINV = E6DTDINV;
    WRITE ENTREPOTF;
    *in51 = *on;
  ENDIF;
END-PROC;


// ******************************************************************
// Afficher
// ******************************************************************
DCL-PROC affiche;
  E5CODPRO = E1CODPRO;
  E5NMPRO  = E1NMPRO;
  E5QTPRO  = E1QTPRO ;
  E5DTDINV = E1DTDINV;
  EXFMT FMT5;
  CLEAR OPT;       // Remise à blanc de l'option saisie
  UPDATE Sfl1;     // dans le sous-fichier
END-PROC;


// ******************************************************************
// Supprimer
// ******************************************************************
DCL-PROC supprime;

  E4CODPRO = E1CODPRO;
  E4NMPRO  = E1NMPRO;
  E4QTPRO  = E1QTPRO ;
  E4DTDINV = E1DTDINV;
  EXFMT FMT4 ;
  CLEAR OPT;        // Remise à blanc de l'option saisie
  CHAIN E4CODPRO ENTREPOTLF;
  IF %found(ENTREPOTLF);
    IF *in23; // Si F23 on active le delete
      delete ENTREPOTF;
      *in52 = *on;
    ENDIF;
  ENDIF;
  UPDATE Sfl1;
END-PROC;


// ******************************************************************
// Modifier
// ******************************************************************
DCL-PROC modifie;
  E2CODPRO = E1CODPRO;
  E2NMPRO  = E1NMPRO;
  E2QTPRO  = E1QTPRO ;
  E2DTDINV = E1DTDINV;
  DOU *IN03;
    EXFMT FMT2 ;
    SELECT;
    WHEN *IN03;
      ITER;
    WHEN *IN12;
      LEAVE;
    WHEN *IN23;
      CHAIN E2CODPRO ENTREPOTLF;
      if %found(ENTREPOTLF);
        ENT_CODPRO = E2CODPRO;
        ENT_NMPRO  = E2NMPRO;
        ENT_QTPRO  = E2QTPRO;
        ENT_DTDINV = E2DTDINV;
        UPDATE ENTREPOTF;
        CLEAR OPT;
        UPDATE Sfl1;      // dans le sous-fichier
        *in50 = *on;
        LEAVE;
      ENDIF;
    ENDSL;
  ENDDO;
END-PROC;

DCL-PROC clr_indmsg;
  *in50 = *off; // On met l'indicateur de message à off
  *in51 = *off; // On met l'indicateur de message à off
  *in52 = *off; // On met l'indicateur de message à off
END-PROC;
```
