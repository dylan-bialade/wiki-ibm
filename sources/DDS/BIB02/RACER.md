---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: RACER
type: DDS
longueur_enregistrement: 100
lignes: 231
modifie: 2026-11-16
---

# BIB02/QDDSRC/RACER

```text
          CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO) ;
          DCL-F RACED WORKSTN SFILE(SFL1:RRN1);
          DCL-F RACEL1 disk USAGE(*UPDATE : *DELETE : *OUTPUT) keyed;

          DCL-C SflPag        CONST(14);
          DCL-S Lstrrn        packed(4:0) INZ(0);
          DCL-S i             packed(4:0) INZ(0);
          DCL-S compteur_page packed(2:0) INZ(0);

       // Renommage des indicateurs pour faire plus Bô ....

          DCL-S pIndicators Pointer Inz(%Addr(*In));
          DCL-DS DspInd Based(pIndicators);
               Sortie   Ind Pos(3);
               Creation Ind Pos(6);
               Impression Ind Pos(8);
               Annuler  Ind Pos(12);
               Sfl_Clr  Ind Pos(31);
               Sfl_Dsp  Ind Pos(32);
               Roll     Ind Pos(39);
               Eropt    Ind Pos(85);
               Sfl_End  Ind Pos(90);
          end-ds;

          DCL-C Afficher CONST('5');
          DCL-C Kill     CONST('4');
          DCL-C Modification   CONST('2');

      // En cas d'externalisation de la procédure
          DCL-PR Looser ind;
           EP3RACE      packed(4:0);
         END-PR;

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

           // Traiter la demande de filtre d'affichage
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

           When Impression;
               Impression();

           Other;
             TRT_READC();
         Endsl;
       Enddo;


       //*******************************************************************
       // Subfile_Clear - Clear the subfile
       //*******************************************************************
        dcl-proc Clear_Subfile;
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
                   E5NORACE = ENORACE;
                    E5DTRACE   =   EDTRACE;
                    E5TPRACE   =   ETPRACE;
                    E5NMRACE   =   ENMRACE;
                    E5GRRACE   =   EGRRACE;
                    E5DSRACE   =   EDSRACE;
                    E5T1RACE   =   ET1RACE;
                //  E5P3RACE   =   EP3RACE;
                   EXFMT FMT5 ;
                   OPt = ' ';        // Remise à blanc de l'option saisie
                   Update Sfl1;      // dans le sous-fichier
                When OPT = Kill;  // Option 4 supprimer
                   E4NORACE = ENORACE;
                    E5DTRACE   =   EDTRACE;
                    E5TPRACE   =   ETPRACE;
                    E5NMRACE   =   ENMRACE;
                    E5GRRACE   =   EGRRACE;
                    E5DSRACE   =   EDSRACE;
                    E5T1RACE   =   ET1RACE;
               //   E5P3RACE   =   EP3RACE;
                   EXFMT FMT4 ;
                   OPt = ' ';        // Remise à blanc de l'option saisie
                   CHAIN E4NORACE RACEL1;
                   if %found(RACEL1);
                     delete RACEFMT;
                   ENDIF;

                   Update Sfl1;      // dans le sous-fichier
                   OTHER;
                     Eropt = '1';
                     Update Sfl1;      // dans le sous-fichier
              Endsl;
              Readc Sfl1;           // Lecture de toutes les lignes du SFL
           ENDDO;
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
                    EXFMT FMT6 ;
                    select;
                    when Sortie;
                      return;
                    other;
                      if not Annuler;
                          NORACE   =   E6NORACE;            // N° de course
                          DTRACE   =   E6DTRACE;            // Date de la course
                          TPRACE   =   E6TPRACE;            //Type de course
                          NMRACE   =   E6NMRACE;            // Nom
                          GRRACE   =   E6GRRACE;            // Genre
                          DSRACE   =   E6DSRACE;            // Distance
                          T1RACE   =   E6T1RACE;            // Temps
                          P3RACE   =   E6P3RACE;            // Position relative
                          write(e) racefmt;
                      ENDIF;
                    ENDSL;
        End-Proc;

       // ******************************************************************
       // Build_Subfile - Build the list
       // ******************************************************************
        Dcl-Proc Build_Subfile;

         Rrn1 = Lstrrn;        // Le "relative record number" reçoit la valeur du dernier
                               // numéro relatif sauvegardé
       //  Version sans sélection, "pure" de 1 à 14 ...
           FOR i=1 to Sflpag;
               READ RACEFMT;
               if %eof;
                 Sfl_End=*on;
                  leave;
               ELSE;
                  Remp_SFL();   // Mouve des zones et write sfl ...
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

                   Rrn1 = Rrn1 + 1;    // Incrémenter le numéro de ligne de sous-fichier
                   ENORACE   =    NORACE;
                   EDTRACE   =    DTRACE;
                   ETPRACE   =    TPRACE;
                   ENMRACE   =    NMRACE;
                   EGRRACE   =    GRRACE;
                   EDSRACE   =    DSRACE;
                   ET1RACE   =    T1RACE;
                   EP3RACE   =    P3RACE;
                   *IN70=Looser(EP3RACE);
                   Write Sfl1;         // Charger en mémoire le format de sous-fichier

        End-Proc;

       // ******************************************************************
       // Fonctions
       // ******************************************************************
        Dcl-proc Looser;
            Dcl-pi *N ind;
               EP3RACE packed(4);
            END-PI;

            if EP3RACE > 50;
               return *ON;
            else;
               return *OFF;
            ENDIF;
        END-PROC;
```
