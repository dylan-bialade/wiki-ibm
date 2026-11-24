---
bibliotheque: BIB02
fichier_source: QVSRC
membre: SFR2
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 203
modifie: 2026-11-16
---

# BIB02/QVSRC/SFR2

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*FULL)
       ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
       STGMDL(*INHERIT) THREAD(*SERIALIZE) USRPRF(*OWNER);

       //*****************************************************************
       // Programme : SFR2
       // BIB02 SYLVAIN - EXEMPLE DE SOUS-FICHIER A L'ANCIENNE (CHAIN)
       // Date      - 04/07/2022
       // Mise à jour - 10/11/2022
       // IMPORTANT !!- CHANGEZ LE OPTIMIZE(*FULL) EN *NONE POUR DEBUG
       // POUR DEBUGGER
       // Copyright - ORGFORM
       //*****************************************************************

       //**********************************************************************//
       // Déclaration des fichiers                                             //
       //**********************************************************************//
       DCL-F SFRDSP WORKSTN SFILE(SFL1:RANG);
       DCL-F entrepotlf disk USAGE(*UPDATE : *DELETE : *OUTPUT : *INPUT) keyed
       prefix(ent_);

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

       *Inlr = *On;

       // A- Initialisation du sous-fichier
       Initialisation_sous_fichier();

       // B- Lecture de la base de données
       SETLL *LOVAL entrepotlf; //On positionne la lecture en début de fichier

       // C - Fabrication du sous-fichier
       Fabrication_sous_fichier();
       SCODPRO = *BLANKS;

       DOU *IN03;  // Sortie si touches F3
         Write Fkey1;
         Exfmt Sf1ctl;

         // Et là, on se pose la question : Qu'à fait l'utilisateur ?
         SELECT;
           WHEN *IN06;  // Appuie sur la Touche F6
             creation_pr();
             SETLL *LOVAL entrepotlf;  // positionne la lecture en début de fichier
             Initialisation_sous_fichier();
             Fabrication_sous_fichier();
           WHEN *IN39;  // a-t-il paginé ?
             Fabrication_sous_fichier();
           WHEN SCODPRO <> *BLANKS;  // a-t-il touché à la zone "Afficher à partir de" ?
             // On positionne la lecture sur le "Afficher à partir de" saisi à l'écran
             // et on reprend le remplissage
             SETLL (SCODPRO) ENTREPOTLF;
             Initialisation_sous_fichier();
             Fabrication_sous_fichier();
             clear scodpro;
           OTHER;
              chain e1codpro entrepotlf;    // voir si le fichier est vide
              IF %found();
                   TRT_READC();
              ENDIF;

         ENDSL;
       ENDDO;

       //************************************************************************
       // Initialisation de sous fichier
       //************************************************************************
       DCL-PROC Initialisation_sous_fichier;
         RANG = *Zero;   // Initialisat° du compteur d'enregistrement.
         LAST_RANG = *Zero;
         *In31 = *On;    // Activat° de l'indic de vidage de SFL  (Associé au mot clé SFLCR)
         Write Sf1ctl;   // Vidage du sous-fichier
         *In31 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLCLR)
         *In32 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLDSP)
         *In90 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLEND)
         i = 1;
       END-PROC;


       //************************************************************************
       // Fabrication de sous fichier
       //************************************************************************
       DCL-PROC Fabrication_sous_fichier;
         RANG = LAST_RANG;        // Le "relative record number" reçoit la valeur du dernier
         // numéro relatif sauvegardé
         // On va "tourner" 14 fois fois dans cette boucle. 14 étant le nombre de lignes
         // à écrire par pages.
         FOR i=1 to Sflpag;
           READ ENTREPOTLF;
           IF %eof;          // Fin de fichier ? On enclanche le jolie message
             *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
             leave;
           ELSE;
             // Incrémentation du compteur de ligne
             RANG += 1;  // Incrémentation du compteur de ligne
             // les zones du PF ayant le même nom que celle du SFL, le "move" de celles-ci
             E1CODPRO = ENT_CODPRO;
             E1NMPRO  = ENT_NMPRO;
             E1QTPRO  = ENT_QTPRO;
             E1DTDINV = ENT_DTDINV;
             write Sfl1;
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
         Readc Sfl1;           // Lecture de toutes les lignes modifiées du SFL
         DOW NOT %eof;         // Tant que toutes les lignes modifiés n'ont pas été traitées
           SELECT;
           WHEN OPT = Afficher;  // Option 5 saisie
             E5CODPRO = E1CODPRO;
             E5NMPRO  = E1NMPRO;
             E5QTPRO  = E1QTPRO ;
             E5DTDINV = E1DTDINV;
             EXFMT FMT5 ;
             OPT = *blanks;        // Remise à blanc de l'option saisie
             Update Sfl1;      // dans le sous-fichier
           WHEN OPT = Supprimer;    // Option 4 supprimer
             E4CODPRO = E1CODPRO;
             E4NMPRO  = E1NMPRO;
             E4QTPRO  = E1QTPRO ;
             E4DTDINV = E1DTDINV;
             EXFMT FMT4 ;
             OPT = *blanks;        // Remise à blanc de l'option saisie
             CHAIN E4CODPRO ENTREPOTLF;
             IF %found(ENTREPOTLF);
               IF *in23; // Si F23 on active le delete
                 delete ENTREPOTF;
               ENDIF;
             ENDIF;
             Update Sfl1;
           WHEN OPT = Modifier;  // Option 2 saisie
             E2CODPRO = E1CODPRO;
             E2NMPRO  = E1NMPRO;
             E2QTPRO  = E1QTPRO ;
             E2DTDINV = E1DTDINV;
             DOW NOT *IN03;
               EXFMT FMT2 ;
               SELECT;
               WHEN *IN03;
                 leave;
               WHEN *IN12;
                 return;
               WHEN *IN23;
                 CHAIN E2CODPRO ENTREPOTLF;
                 if %found(ENTREPOTLF);
                   ENT_CODPRO = E2CODPRO;
                   ENT_NMPRO  = E2NMPRO;
                   ENT_QTPRO  = E2QTPRO;
                   ENT_DTDINV = E2DTDINV;
                   update ENTREPOTF;
                   OPT = *blanks;
                   Update Sfl1;      // dans le sous-fichier
                   leave;
                 ENDIF;
               ENDSL;
             ENDDO;
           ENDSL;
           Readc Sfl1;           // Lecture de toutes les lignes du SFL
         ENDDO;
         Initialisation_sous_fichier();
         SETLL *LOVAL entrepotlf; //On positionne la lecture en début de fichier
         Fabrication_sous_fichier();
       END-PROC;


       // ******************************************************************
       // Création
       // ******************************************************************
       DCL-PROC Creation_pr;
         E6DTDINV = datejour;
         EXFMT FMT6;
         IF *IN23;
           ENT_CODPRO = E6CODPRO;
           ENT_NMPRO  = E6NMPRO;
           ENT_QTPRO  = E6QTPRO;
           ENT_DTDINV = E6DTDINV;
           write  ENTREPOTF;
         ENDIF;
       END-PROC;
```
