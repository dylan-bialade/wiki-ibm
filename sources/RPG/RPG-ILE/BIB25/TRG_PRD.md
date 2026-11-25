---
bibliotheque: BIB25
fichier_source: QRPGLESRC
membre: TRG_PRD
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 63
modifie: 2026-11-25
---

# BIB25/QRPGLESRC/TRG_PRD

```text
       //*****************************************************************
       // Programme : TRG_PRD
       // Ficher ou l'on doit déposer le trigger : PRODUITS
       // Fichier qui va loger le trigger : LOGPRD
       // FORMATION - TRIGGER
       // Copyright - ORGFORM
       //*****************************************************************

       CTL-OPT COPYRIGHT('(C) ORGFORM 2023.') USRPRF(*OWNER) OPTIMIZE(*NONE)
       DFTACTGRP(*NO) ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO)
       ALLOC(*STGMDL) STGMDL(*INHERIT);

       // Premier parametre du Trigger --  Coder ici


       // Second parametre du Trigger --   Coder ici


       //**********************************************************************/
       // Déclaration des data-structures                                      /
       //**********************************************************************/

       // Définit une DS qui est utilisée pour représenter les données
       // d'un fichier externe 'LOGPRD'. -- Coder ici



       Dcl-DS ENREG  qualified;
         Avant                     likeds(enreg_av);
         Apres                     likeds(enreg_ap);
       End-DS;

       // Image enregistrement avant  - // Coder ici



       // Image enregistrement apres  - // Coder ici


       //**********************************************************************/
       // Déclaration des prototypes                                           /
       //**********************************************************************/
     C     *Entry        PList
     C                   Parm                    P1
     C                   Parm                    P2


      //**********************************************************************//
      //               T R A I T E M E N T    P R I N C I P A L               //
      //**********************************************************************//

       //Gestion du contrôle de validation, des performances, etc ...
       EXEC SQL
        SET OPTION COMMIT = *NONE, ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD,
        DYNUSRPRF = *OWNER, DATFMT = *ISO, TIMFMT = *ISO;


       //Reception des param passé par le Call (si pgm std) ou passé par trigger
       //Prend les parametres passé par pgm pour les traiter ensuite (ss)

       // Coder ici

       *inlr =*on;
```
