# SFTEST : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QDDSRC | DDS | 120 | 100 % | sous-fichier, ecran (WORKSTN), SETLL / READ, boucle DOW/DOU/FOR, procedures (dcl-proc), prototypes (dcl-pr), indicateurs *INxx | [SFTEST.md](../../sources/DDS/BIB02/SFTEST.md) |
| BIB27 | QRPGSRC | RPG/RPG-III-400 | 32 | 0 % | sous-fichier, ecran (WORKSTN), SETLL / READ, boucle DOW/DOU/FOR, procedures (dcl-proc), indicateurs *INxx | [SFTEST.md](../../sources/RPG/RPG-III-400/BIB27/SFTEST.md) |

## Differences

- Techniques communes : sous-fichier, ecran (WORKSTN), SETLL / READ, boucle DOW/DOU/FOR, procedures (dcl-proc), indicateurs *INxx
- **BIB02** en propre : prototypes (dcl-pr)
- Langages / types differents : DDS, RPG/RPG-III-400

## Codes

### BIB02 (DDS, 120 lignes)

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO);

       DCL-F SFDSP WORKSTN SFILE(SFL1:RANG);
       DCL-F entrepotlf disk USAGE(*UPDATE : *DELETE : *OUTPUT) keyed
       prefix(ent_);


       DCL-C SflPag CONST(15);   // Nombre de ligne à afficher par page ...
       DCL-S LAST_RANG packed(4:0) INZ(0);     // Dernier rrn écrit avant pagination ...
       DCL-S i packed(4:0) INZ(0);
       DCL-S nom char(2);
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


         WHEN CODPRO = ' ';
           setll *loval entrepotlf;
           Initialisation_sous_fichier();
           Fabrication_sous_fichier();
           read entrepotlf;
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

           IF %trim(nmpro)  = %trim(NMPROS);
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
```

### BIB27 (RPG/RPG-III-400, 32 lignes)

```text
     ***********     déclaratives       ***************
     Fecransf   cf   e             workstn
     F                                     sfile(cl01:rang)
     Fbonbon    uf a e           k disk

     *********** Traitement   ********************
     c                   seton                                            lr
     c                   z-add     *zero         rang              4 0
     c                   dow       *in03 = '0'
     c                   exsr      traitement_sf
     c                   write     fmt1
     c                   write     fmt2
     c                   exfmt     ctl01
     c                   enddo

     ********** sous routines   *******************
     c     traitement_sf begsr
     c                   seton                                            52
     c                   write     rbonbon
     c                   setoff                                           52
     c                   read      rbonbon                                99
     c                   dow       *in99 = '0'
     c                   add       1             rang
     c                   write     cl01
     c                   read      rbonbon                                99
     c                   enddo
     c                   seton                                            51
     c                   if        rang > *zero
     c                   seton                                            50
     c                   seton                                            53
     c                   endif
     c                   endsr
```
