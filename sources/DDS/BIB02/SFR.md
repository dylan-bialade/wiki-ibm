---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: SFR
type: DDS
longueur_enregistrement: 100
lignes: 259
modifie: 2026-11-16
---

# BIB02/QDDSRC/SFR

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO);

       DCL-F SFDSP WORKSTN SFILE(SFL1:RANG);
       DCL-F entrepotlf disk USAGE(*UPDATE : *DELETE : *OUTPUT) keyed
       prefix(ent_);

       DCL-S Lstrrn        packed(4:0) INZ(0);
       DCL-S i             packed(4:0) INZ(0);
       DCL-S compteur_page packed(2:0) INZ(0);
       DCL-S pIndicators Pointer Inz(%Addr(*In));
       DCL-DS DspInd Based(pIndicators);
         Sortie   Ind Pos(3);
         Creation Ind Pos(6);
         Annuler  Ind Pos(12);
         Sfl_Clr  Ind Pos(31);
         Sfl_Dsp  Ind Pos(32);
         Roll     Ind Pos(39);
         Eropt    Ind Pos(85);
         Sfl_End  Ind Pos(90);
       end-ds;

       DCL-C SflPag CONST(15);   // Nombre de ligne à afficher par page ...
       DCL-C Afficher CONST('5');
       DCL-C Kill     CONST('4');
       DCL-C Modification CONST('2');

       DCL-S LAST_RANG packed(4:0) INZ(0);     // Dernier rrn écrit avant pagination ...

       dcl-pr entretpfr3 extpgm('BIB02/ENTRETPFR3');    // TOI METTREE MAJJJ
       end-pr;


       *Inlr = *On ;

       // A- Initialisation du sous-fichier
       Initialisation_sous_fichier();

       // B- Lecture de la base de données
       SETLL *LOVAL entrepotlf; //On positionne la lecture en début de fichier

       // C - Fabrication du sous-fichier
       Fabrication_sous_fichier();
       codpro = ' ';

       Dou *IN03;  // Sortie si touches F3
         RANG = 1;
         Write Fkey1;

         Exfmt Sf1ctl;


         // Et là, on se pose la question : Qu'à fait l'utilisateur ?
         Select;

         When *IN06;  // Appuie sur la Touche F6

           callp entretpfr3();

         When *IN39;  // a-t-il paginé ?

           Fabrication_sous_fichier();

         When codpro <> ' ';  // a-t-il touché à la zone "Afficher à partir de" ?

           // On positionne la lecture sur le "Afficher à partir de" saisi à l'écran
           // et on reprend le remplissage
           SETLL (codpro) entrepotlf;
           Initialisation_sous_fichier();
           Fabrication_sous_fichier();
           clear codpro;



         //WHEN CODPRO = ' ';
         //setll *loval entrepotlf;
         //Initialisation_sous_fichier();
         //Fabrication_sous_fichier();
         //read entrepotlf;
         //clear codpro;

         Other;
           TRT_READC();
           SETLL CODPRO   ENTREPOTF;
           Clear_Subfile();        // Vidage du sous-fichier
           Build_Subfile();        // Remplissage du sous-fichier
           Clear CODPRO ;         // RAZ du champ de repositionnement

         ENDSL;


       Enddo;

       dcl-proc Initialisation_sous_fichier;
         RANG = *Zero;   // Initialisat° du compteur d'enregistrement.
         LAST_RANG = *zero;
         *In31 = *On;    // Activat° de l'indic de vidage de SFL  (Associé au mot clé SFLCR)
         Write Sf1ctl;      // Vidage du sous-fichier
         *In31 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLCLR)
         *In32 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLDSP)
         *In90 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLEND)
       End-proc;



       //************************************************************************
       // Fabrication de sous fichier
       //************************************************************************
       dcl-proc Fabrication_sous_fichier;
         RANG = LAST_RANG;        // Le "relative record number" reçoit la valeur du dernier
         // numéro relatif sauvegardé
         // On va "tourner" 14 fois fois dans cette boucle. 14 étant le nombre de lignes
         // à écrire par pages.
         FOR i=1 to Sflpag;
           READ entrepotlf;
           if %eof;          // Fin de fichier ? On enclanche le jolie message
             *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
             leave;
           ELSE;
             // Incrémentation du compteur de ligne
             // les zones du PF ayant le même nom que celle du SFL, le "move" de celles-ci
             codpro = ent_codpro;
             nmpro = ent_nmpro;
             qtpro = ent_qtpro;
             dtdinv = ent_dtdinv;

           ENDIF;
           IF qtpro > QTPROS;
             RANG += 1;
             write sfl1;
           ENDIF;

           clear codpro;

         ENDFOR;

         If RANG = *Zero;      // Si aucun enregistrement détecté dans le sous-fichier
           *IN32 = *on;            //   Activer l'indicateur masquant le sous-fichier
         Endif;
         LAST_RANG = RANG;        // Sauvegarder le dernier enregistrement chargé
       // pour faciliter le chargement de la page suivante
       End-proc;



       // ******************************************************************
       // Traitement du READC
       // ******************************************************************
       Dcl-Proc TRT_READC;
         Readc Sfl1;           // Lecture de toutes les lignes modifiées du SFL
         Dow Not %eof;         // Tant que toutes les lignes modifiés n'ont pas été traitées
           Select;
           When OPT = Afficher;  // Option 5 saisie
             E5CODPRO = CODPRO;
             E5NMPRO  = NMPRO;
             E5QTPRO  = QTPRO ;
             E5DTDINV = DTDINV;
             EXFMT FMT5 ;
             OPt = ' ';        // Remise à blanc de l'option saisie
             Update Sfl1;      // dans le sous-fichier
           When OPT = Kill;  // Option 4 supprimer
             E4CODPRO = CODPRO;
             E4NMPRO  = NMPRO;
             E4QTPRO  = QTPRO ;
             E4DTDINV = DTDINV;
             EXFMT FMT4 ;
             OPT = ' ';        // Remise à blanc de l'option saisie
             CHAIN E4CODPRO ENTREPOTLF;
             if %found(ENTREPOTLF);
               if *in23; // Si F23 on active le delete
                 delete ENTREPOTF;
               ENDIF;

             ENDIF;
             Update Sfl1;
           When OPT = Modification;  // Option 2 saisie
             E2CODPRO = CODPRO;
             E2NMPRO  = NMPRO;
             E2QTPRO  = QTPRO ;
             E2DTDINV = DTDINV;
             DOW NOT *IN03;
               EXFMT FMT2 ;
               SELECT;
               WHEN *IN03;
                 leave;
               WHEN *IN23;
                 CHAIN E2CODPRO ENTREPOTLF;
                 if %found(ENTREPOTLF);
                   ent_CODPRO = E2CODPRO;
                   ent_NMPRO  = E2NMPRO;
                   ent_QTPRO = E2QTPRO;
                   ent_DTDINV = E2DTDINV;
                   update ENTREPOTF;
                   leave;
                 ENDIF;
               ENDSL;
             ENDDO;
             OPT = ' ';
             Update Sfl1;      // dans le sous-fichier

           When OPT = Creation;  // Option 2 saisie
             callp entretpfr3();
           Endsl;

           Readc Sfl1;           // Lecture de toutes les lignes du SFL
         ENDDO;
       End-Proc;

       //*******************************************************************
       // Subfile_Clear - Clear the subfile
       //*******************************************************************
       dcl-proc Clear_Subfile;
         RANG = *Zero;         // Effacer le numéro d'enregistrement de sous-fichier.
         Lstrrn = *Zero;       // Effacer le numéro d'enregistrement de sous-fichier enregistré
         Sfl_Clr = *On;          // Activer l'indicateur de vidage de sous-fichier.
         Write    SF1CTL;    // Vidage du sous-fichier.
         Sfl_Clr  = *Off;         // Désactiver l'indicateur de vidage de sous-fichier
         Sfl_Dsp  = *Off;         // Désactiver le Non-Affichage du dsp
         Sfl_End = *Off;         // Désactiver l'indicateur de fin de sous-fichier.(à suivre .../ Fi
       end-proc;

       // ******************************************************************
       // Build_Subfile - Build the list
       // ******************************************************************
       Dcl-Proc Build_Subfile;

         RANG = Lstrrn;        // Le "relative record number" reçoit la valeur du dernier
         // numéro relatif sauvegardé
         //  Version sans sélection, "pure" de 1 à 14 ...
         FOR i=1 to Sflpag;
           READ ENTREPOTF;
           if %eof;
             Sfl_End=*on;
             leave;
           ELSE;
             Remp_SFL();   // Mouve des zones et write sfl ...
           ENDIF;
         ENDFOR;

         If RANG = *Zero;      // Si aucun enregistrement détecté dans le sous-fichier
           Sfl_Dsp = *on;            //   Activer l'indicateur masquant le sous-fichier
         Endif;
         Lstrrn = RANG;        // Sauvegarder le dernier enregistrement chargé
       // pour faciliter le chargement de la page suivante

       End-Proc;

       // ******************************************************************
       // Coeur du remplissage du sous-fichier
       // ******************************************************************
       Dcl-Proc Remp_SFL;

         RANG = RANG + 1;    // Incrémenter le numéro de ligne de sous-fichier
         codpro = ent_CODPRO;
         nmpro  = ent_NMPRO;
         qtpro  = ent_QTPRO ;
         dtdinv = ent_DTDINV;
         Write Sfl1;         // Charger en mémoire le format de sous-fichier

       End-Proc;
```
