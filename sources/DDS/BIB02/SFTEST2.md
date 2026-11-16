---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: SFTEST2
type: DDS
longueur_enregistrement: 100
lignes: 102
modifie: 2026-11-16
---

# BIB02/QDDSRC/SFTEST2

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO);

       DCL-F SFDSP WORKSTN SFILE(SFL1:RANG);
       DCL-F entrepotlf disk USAGE(*UPDATE : *DELETE : *OUTPUT) keyed
       prefix(ent_);


       DCL-C SflPag CONST(15);   // Nombre de ligne à afficher par page ...

       DCL-S LAST_RANG packed(4:0) INZ(0);     // Dernier rrn écrit avant pagination ...
       DCL-S i packed(4:0) INZ(0);
       dcl-pr entretpfr4 extpgm('BIB02/ENTRETPFR4');    // TOI METTREE MAJJJ
       end-pr;


       *Inlr = *On ;

          // A- Initialisation du sous-fichier
          Initialisation_sous_fichier();

          // B- Lecture de la base de données
          SETLL *LOVAL entrepotlf; //On positionne la lecture en début de fichier

          // C - Fabrication du sous-fichier
          Fabrication_sous_fichier();

          Dou *IN03;  // Sortie si touches F3



             Write Fkey1;

             Exfmt Sf1ctl;

             // Et là, on se pose la question : Qu'à fait l'utilisateur ?
             Select;

               When *IN06;  // Appuie sur la Touche F6

                  callp entretpfr4();

               When *IN39;  // a-t-il paginé ?

                 Fabrication_sous_fichier();

               When codpro <> ' ';  // a-t-il touché à la zone "Afficher à partir de" ?

                  // On positionne la lecture sur le "Afficher à partir de" saisi à l'écran
                  // et on reprend le remplissage
                  SETLL (codpro) entrepotlf;
                  Initialisation_sous_fichier();
                  Fabrication_sous_fichier();
                  clear codpro;

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
               RANG += 1;  // Incrémentation du compteur de ligne
               // les zones du PF ayant le même nom que celle du SFL, le "move" de celles-ci
                 codpro = ent_codpro;
                 nmpro = ent_nmpro;
                 qtpro = ent_qtpro;
                 dtdinv= ent_dtdinv;
               // est implicite et ça se passe ici !
                write Sfl1;
             ENDIF;
          ENDFOR;

          If RANG = *Zero;      // Si aucun enregistrement détecté dans le sous-fichier
           *IN32 = *on;            //   Activer l'indicateur masquant le sous-fichier
          Endif;
          LAST_RANG = RANG;        // Sauvegarder le dernier enregistrement chargé
                                   // pour faciliter le chargement de la page suivante
       End-proc;
```
