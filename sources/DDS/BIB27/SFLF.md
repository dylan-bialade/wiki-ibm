---
bibliotheque: BIB27
fichier_source: QDDSSRC
membre: SFLF
type: DDS
longueur_enregistrement: 160
lignes: 52
modifie: 2026-11-25
---

# BIB27/QDDSSRC/SFLF

```text
**FREE                                                                          CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*FULL)
ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)                        STGMDL(*INHERIT) THREAD(*SERIALIZE);
                                                                                //*****************************************************************
// Programme : SFRL                                                             // BIB02 SYLVAIN - EXEMPLE DE SOUS-FICHIER POUR LF
// Date      - 23/02/2022                                                       // IMPORTANT !!- CHANGEZ LE OPTIMIZE(*FULL) EN *NONE POUR DEBUG
// POUR DEBUGGER                                                                // Copyright - ORGFORM
//*****************************************************************
//**********************************************************************//      // Déclaration des fichiers                                             //
//**********************************************************************//      DCL-F SFRDSP WORKSTN SFILE(SFL1:RANG);
DCL-F PROD_ORD USAGE(*UPDATE : *DELETE : *OUTPUT : *INPUT) keyed                prefix(prod_);
                                                                                //**********************************************************************//
// Déclaration des constantes                                           //      //**********************************************************************//
DCL-C SflPag    CONST(12);   // Nombre de ligne à afficher par page ...
                                                                                //**********************************************************************//
// Déclaration des variables                                            //      //**********************************************************************//
DCL-S LAST_RANG ZONED(4:0) INZ(*ZERO);    // Dernier rrn écrit avant pagination DCL-S i         ZONED(4:0) INZ(*ZERO);

                                                                                // A- Initialisation du sous-fichier
EXSR Initialisation_sous_fichier;
// B- Lecture de la base de données                                             SETLL *LOVAL PROD_ORD; //On positionne la lecture en début de fichier
                                                                                // C - Fabrication du sous-fichier
EXSR Fabrication_sous_fichier;
                                                                                DOU *IN03;  // Sortie si touches F3
  WRITE Fkey1;                                                                    EXFMT Sf1ctl;
                                                                                  // Et là, on se pose la question : Qu'à fait l'utilisateur ?
 IF *IN39;  // a-t-il paginé ?                                                      EXSR Fabrication_sous_fichier;
 ENDIF;
ENDDO;
*Inlr = *On;
//************************************************************************      // Initialisation de sous fichier
//************************************************************************      BEGSR Initialisation_sous_fichier;
  RANG = *ZERO;   // Initialisat° du compteur d'enregistrement.                   LAST_RANG = *ZERO;
  *In31 = *ON;    // Activat° de l'indic de vidage de SFL  (Associé au mot clé S  WRITE Sf1ctl;   // Vidage du sous-fichier
  *In31 = *OFF;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé  *In32 = *OFF;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé
  *In90 = *OFF;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé  i = 1;
ENDSR;
                                                                                //************************************************************************
// Fabrication de sous fichier                                                  //************************************************************************
BEGSR Fabrication_sous_fichier;                                                   RANG = LAST_RANG;        // Le "relative record number" reçoit la valeur du de
  // numéro relatif sauvegardé
  FOR i=1 to Sflpag;                                                                READ PROD_ORD;
    IF %eof;          // Fin de fichier ? On enclanche le jolie message               *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
      LEAVE;                                                                        ELSE;
      // Incrémentation du compteur de ligne                                          RANG += 1;  // Incrémentation du compteur de ligne
      // les zones du PF ayant le même nom que celle du SFL, le "move" de celles      E1PRDN  =   PROD_PRDNUM ;
      E1PRDNAME = PROD_PRDNAME  ;                                                     E1PRDCAT  = PROD_PRDCAT ;
      E1PRDPRICE  = PROD_PRDPRICE ;                                                   E1PRDQTY  =  PROD_PRDQTY;
      WRITE Sfl1;                                                                   ENDIF;
  ENDFOR;
  IF RANG = *Zero;      // Si aucun enregistrement détecté dans le sous-fichier     *IN32 = *on;            //   Activer l'indicateur masquant le sous-fichier
  ENDIF;                                                                          LAST_RANG = RANG;        // Sauvegarder le dernier enregistrement chargé
// pour faciliter le chargement de la page suivante                             ENDSR;
```
