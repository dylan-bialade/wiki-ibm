---
bibliotheque: BIB02
fichier_source: QSFSRC
membre: PRINTSQLRO
type: DDS
longueur_enregistrement: 100
lignes: 41
modifie: 2026-11-16
---

# BIB02/QSFSRC/PRINTSQLRO

```text
       CTL-OPT OPTION(*NODEBUGIO : *SRCSTMT) ALWNULL(*USRCTL) DFTACTGRP(*NO);

       DCL-F PRTFSQLRDO  PRINTER;
       DCL-F entrepotlf disk USAGE(*UPDATE : *DELETE : *OUTPUT : *INPUT)
       keyed;

       DCL-S Ligne zoned(3:0);


       *INLR = *ON;      // On commence par allumer l'indicateur de sortie finale
       Ligne = 1;        // On initialise le compteur de ligne.
       WRITE ENTETE;
       WRITE TITRE;

       // On se positionne en début de fichier ...
       SETLL *LOVAL ENTREPOTF  ;

       // ... et on attaque la lecture séquentielle.
       READ ENTREPOTF;

       // Tant qu'on est pas à la fin du fichier ...
       DOW NOT %EOF(ENTREPOTLF);
         Impression();
       ENDDO;

       //Procédure impression
       DCL-PROC Impression;
         TCODPRO = CODPRO  ;
         TNMPRO  = NMPRO ;
         TQTPRO  = QTPRO ;
         TDTDINV = DTDINV ;
         WRITE DETAIL;
         LIGNE += 1;
         READ ENTREPOTF;
         IF LIGNE  = 56;
           WRITE EJECT;
           WRITE ENTETE;
           WRITE TITRE;
           LIGNE = 5;
         ENDIF;
       END-PROC;
```
