---
bibliotheque: BIB02
fichier_source: QILE
membre: RACERILE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 355
modifie: 2026-11-16
---

# BIB02/QILE/RACERILE

```text

       CTL-OPT OPTION(*SRCSTMT) ACTGRP(*NEW)
        DFTACTGRP(*NO)  BNDDIR('RACDI');

       DCL-F RACED WORKSTN SFILE(SFL1:RRN1);
       DCL-F RACEL1 disk USAGE(*UPDATE : *DELETE : *OUTPUT) keyed;

       DCL-C SflPag CONST(14);   // Nombre de ligne à afficher par page ...

       DCL-S Lstrrn packed(4:0) INZ(0);     // Dernier rrn écrit avant pagination ...
       DCL-S i      packed(4:0) INZ(0);


       DCL-S JAI_TROUVE IND INZ(*OFF);   // Pour savoir si j'ai trouvé ...

       DCL-PR Looser ind;
         EP3RACE      packed(4:0);
       END-PR;
       DCL-PR Winner ind;
         EP3RACE      packed(4:0);
       END-PR;
       DCL-PR Vismois char(9);
         datemois date;
       END-PR;

       DCL-PR Write_Racep IND;
         NORACE packed (4:0);
         DTRACE DATE;
         TPRACE CHAR (3);
         NMRACE CHAR (30);
         GRRACE CHAR (1);
         DSRACE packed(3:0);
         T1RACE TIME;
         P3RACE packed(4:0);
         AVRACE    packed(4:2)   ;
         FORME     CHAR(3)  ;
         VAINQUEUR CHAR(10) ;
       END-PR;


       // Renommage des indicateurs pour faire plus Bô ...
       DCL-S pIndicators Pointer Inz(%Addr(*In));
       DCL-DS DspInd Based(pIndicators);
         Sortie   Ind Pos(3);
         Creation Ind Pos(6);
         Annuler  Ind Pos(12);
         Confirmer  Ind Pos(23);
         Sfl_Clr  Ind Pos(31);
         Sfl_Dsp  Ind Pos(32);
         Roll     Ind Pos(39);
         Name_Change Ind Pos(62);
         Sfl_End  Ind Pos(90);
       end-ds;

       // Description des options du sous-fichier:
       DCL-C Afficher       CONST('5');
       DCL-C Kill           CONST('4');
       DCL-C Modification   CONST('2');

       // ******************************************************************
       // **************** MAIN *******************************************
       // ******************************************************************

       *Inlr = *On;

       Clear_Subfile();   // Vidage du sous-fichier
       SETLL *LOVAL RACEFMT;
       Build_Subfile();   // Remplissage du sous-fichier

       Dou Sortie; // Tant que F3 et F12 ne sont pas activées
         Write Bas1;            // Afficher le format de bas d'écran

         Exfmt CTL1;           // Afficher le format de contrôle


         Select;
         // Traiter la demande de repositionnement
         When Z_NORACE <> 0;
           SETLL Z_NORACE RACEFMT;
           Clear_Subfile();        // Vidage du sous-fichier
           Build_Subfile();        // Remplissage du sous-fichier
           Clear Z_NORACE;         // RAZ du champ de repositionnement

         // Traiter la demande de filtre d'affichage  --> pas encore au point, en cours de dev ...
         When Z_TYP <> ' ';
           SETLL *LOVAL RACEFMT;
           Clear_Subfile();        // Vidage du sous-fichier
           Build_Subfile();        // Remplissage du sous-fichier
           Clear Z_TYP;            // RAZ du champ de repositionnement

         // Détection de la pagination arrière
         When Roll And (Not Sfl_Clr);
           Build_Subfile();          // Remplissage du sous-fichier

         // Détection du F6
         When Creation;
           Creaturae(); // Gestion de la création d'un enreg
           SETLL *LOVAL RACEFMT;
           Clear_Subfile();        // Vidage du sous-fichier
           Build_Subfile();        // Remplissage du sous-fichier

         Other;
           TRT_READC();
           SETLL *LOVAL RACEFMT;
           Clear_Subfile();        // Vidage du sous-fichier
           Build_Subfile();        // Remplissage du sous-fichier
         Endsl;
       Enddo;


       //*******************************************************************
       // Subfile_Clear - Clear the subfile
       //*******************************************************************
       Dcl-Proc Clear_Subfile;
         Rrn1 = *Zero;         // Effacer le numéro d'enregistrement de sous-fichier.
         Lstrrn = *Zero;       // Effacer le numéro d'enregistrement de sous-fichier enregistré
         Sfl_Clr = *On;          // Activer l'indicateur de vidage de sous-fichier.
         Write     CTL1;     // Vidage du sous-fichier.
         Sfl_Clr  = *Off;         // Désactiver l'indicateur de vidage de sous-fichier
         Sfl_Dsp  = *Off;         // Désactiver le Non-Affichage du dsp
         Sfl_End = *Off;         // Désactiver l'indicateur de fin de sous-fichier.(à suivre .../ Fi

       End-Proc;

       // ******************************************************************
       // Traitement du READC
       // ******************************************************************
       Dcl-Proc TRT_READC;
         Readc Sfl1;           // Lecture de toutes les lignes modifiées du SFL
         Dow Not %eof;         // Tant que toutes les lignes modifiés n'ont pas été traitées
           Select;
           When OPT = Afficher;  // Option 5 saisie
             Ostendere();

           When OPT = Kill;  // Option 4 supprimer
             Occidere();

           When OPT = Modification;  // Option 4 supprimer
             Recencere();
           Endsl;
           Readc Sfl1;           // Lecture de toutes les lignes du SFL
         ENDDO;
       End-Proc;
       // ******************************************************************
       // Traitement de l'option 2=Modification  (seule la zone nom course est modifiable)
       // ******************************************************************
       Dcl-Proc Recencere;
         // Les zones du sous-fichier sont transférées dans le format écran FMT2
         E2NORACE   =   ENORACE;
         E2DTRACE   =   EDTRACE;
         E2TPRACE   =   ETPRACE;
         E2NMRACE   =   ENMRACE;
         E2GRRACE   =   EGRRACE;
         E2DSRACE   =   EDSRACE;
         E2T1RACE   =   ET1RACE;
         DoW not Sortie or not Annuler;
           EXFMT FMT2 ;
           select;
           when Sortie;
             leave;
           when Annuler;
             leave;
           other;
             // L'indicateur ci-dessous est associé au mot clef CHANGE(62) déclaré dans l
             if Name_Change;
               CHAIN E2NORACE RACEL1;
               if %found(RACEL1);
                 NMRACE   =   E2NMRACE;
                 update(e) RACEFMT %fields(NMRACE);
                 if %error;
                 // à coder ...
                 ENDIF;
               ENDIF;
               leave;
             endif;
           ENDSL;
         enddo;
         OPt = ' ';        // Remise à blanc de l'option saisie
         Update Sfl1;      // dans le sous-fichier
       End-Proc;
       // ******************************************************************
       // Traitement de l'option 5=Afficher
       // ******************************************************************
       Dcl-Proc Ostendere;
         E5NORACE = ENORACE;
         E5DTRACE   =   EDTRACE;
         LIBMOIS = VisMois(E5DTRACE);
         E5TPRACE   =   ETPRACE;
         E5NMRACE   =   ENMRACE;
         E5GRRACE   =   EGRRACE;
         E5DSRACE   =   EDSRACE;
         E5T1RACE   =   ET1RACE;
         EXFMT FMT5 ;
         OPt = ' ';        // Remise à blanc de l'option saisie
         Update Sfl1;      // dans le sous-fichier
       End-Proc;

       // ******************************************************************
       // Traitement de l'option 4=Supprimer
       // ******************************************************************
       Dcl-Proc Occidere;
         E4NORACE   =   ENORACE;
         E4DTRACE   =   EDTRACE;
         E4TPRACE   =   ETPRACE;
         E4NMRACE   =   ENMRACE;
         E4GRRACE   =   EGRRACE;
         E4DSRACE   =   EDSRACE;
         E4T1RACE   =   ET1RACE;
         DoW not Sortie or not Annuler;
           EXFMT FMT4 ;
           select;
           when Sortie;
             leave;
           when Annuler;
             leave;
           when Confirmer;
             CHAIN E4NORACE RACEL1;
             if %found(RACEL1);
               delete RACEFMT;
             ENDIF;
             leave;
           ENDSL;
         enddo;
         OPt = ' ';        // Remise à blanc de l'option saisie
         Update Sfl1;      // dans le sous-fichier
       End-Proc;
       // ******************************************************************
       // Traitement du F6=Création
       // ******************************************************************
       Dcl-Proc Creaturae;
         clear E6NORACE;
         clear E6DTRACE;
         clear E6TPRACE;
         clear E6NMRACE;
         clear E6GRRACE;
         clear E6DSRACE;
         clear E6T1RACE;
         clear E6P3RACE;
         clear E6AVRACE;
         clear E6FORME;
         clear E6VAINC;
         EXFMT FMT6 ;
         select;
         when Sortie;
           return;
         other;
           if not Annuler;
       //                   NORACE   =   E6NORACE;            // N° de course
       //                   DTRACE   =   E6DTRACE;            // Date de la course
       //                   TPRACE   =   E6TPRACE;            //Type de course
             //                   NMRACE   =   E6NMRACE;            // Nom
             //                   GRRACE   =   E6GRRACE;            // Genre
             //                   DSRACE   =   E6DSRACE;            // Distance
             //                   T1RACE   =   E6T1RACE;            // Temps
       //                   P3RACE   =   E6P3RACE;            // Position relative
             //                   write(e) racefmt;
             //                 *in70 = *off;
       //                 *in70 =  Write_Racep(E6NORACE : E6DTRACE : E6TPRACE
             //                    :E6NMRACE : E6GRRACE :
             //                    E6DSRACE : E6T1RACE : E6P3RACE : E6AVRACE
             //                    :E6FORME : E6VAINC);
             //                   dsply *in70;


             EXEC SQL
               SET OPTION COMMIT =*NONE ,
               CLOSQLCSR=*ENDMOD;

             // CONTROLE DES DONNEES SI BESOIN


             // REQUETE
             EXEC SQL
             INSERT INTO races/racep
               (NORACE, DTRACE, TPRACE,
               NMRACE, GRRACE, DSRACE,
               T1RACE, P3RACE, AVRACE,
               FORME, VAINQUEUR)
               VALUES (:E6NORACE, :E6DTRACE, :E6TPRACE,
               :E6NMRACE, :E6GRRACE, :E6DSRACE,
               :E6T1RACE, :E6P3RACE, :E6AVRACE,
               :E6FORME, 'moi')
               ;

             // CONTROLE ERREUR
             IF SQLCODE = 0 ;


             ELSE ;
               dsply sqlcode;

             ENDIF;

             IF %ERROR;
             // à faire ....
             ENDIF;
           ENDIF;
         ENDSL;
       End-Proc;

       // ******************************************************************
       // Build_Subfile - Build the list
       // ******************************************************************
       Dcl-Proc Build_Subfile;

         Rrn1 = Lstrrn;        // Le "relative record number" reçoit la valeur du dernier
         // numéro relatif sauvegardé
         FOR i=1 to Sflpag;
           READ RACEFMT;
           if %eof;
             Sfl_End=*on;
             leave;
           ELSE;
             // si Z_TYP a été saisit, on contrôle l'égalité ici.
             If Z_TYP <> ' ' and Z_TYP = TPRACE;
               Remp_SFL();   // Mouve des zones et write sfl ...
               // je "squize" le programme et lui fais croire qu'on est en fin de lecture ...
               if rrn1 < sflpag;
                 Sfl_End = *on;
               ENDIF;
             ENDIF;
             If Z_TYP = ' ';
               Remp_SFL();   // Mouve des zones et write sfl ...
             ENDIF;
           // je reviens ici du Remp_SFL
           ENDIF;
         ENDFOR;

         If Rrn1 = *Zero;      // Si aucun enregistrement détecté dans le sous-fichier
           Sfl_Dsp = *on;            //   Activer l'indicateur masquant le sous-fichier
         Endif;
         Lstrrn = Rrn1;        // Sauvegarder le dernier enregistrement chargé
       // pour faciliter le chargement de la page suivante

       End-Proc;

       // ******************************************************************
       // Coeur du remplissage du sous-fichier
       // ******************************************************************
       Dcl-Proc Remp_SFL;

         Rrn1 += 1;    // Incrémenter le numéro de ligne de sous-fichier
         ENORACE   =    NORACE;
         EDTRACE   =    DTRACE;
         ETPRACE   =    TPRACE;
         ENMRACE   =    NMRACE;
         EGRRACE   =    GRRACE;
         EDSRACE   =    DSRACE;
         ET1RACE   =    T1RACE;
         EP3RACE   =    P3RACE;
         *IN70=Looser(EP3RACE);
         *IN71=Winner(EP3RACE);
         Write Sfl1;         // Charger en mémoire le format de sous-fichier

       End-Proc;
```
