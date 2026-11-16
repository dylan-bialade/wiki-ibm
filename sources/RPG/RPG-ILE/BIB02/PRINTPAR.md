---
bibliotheque: BIB02
fichier_source: QSRC
membre: PRINTPAR
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 43
modifie: 2026-11-16
---

# BIB02/QSRC/PRINTPAR

```text
     ***********************************************************************************
       ctl-opt OPTION(*NODEBUGIO : *SRCSTMT) ALWNULL(*USRCTL) ;
     H DFTACTGRP(*NO)
     ***********************************************************************************
     FECRANPRTFPO    E             PRINTER
     FPARTICIPA IF A E           K DISK
     ***********************************************************************************
     DLigne            S              3  0
     ***********************************************************************************
       *inlr = *ON;      // On commence par allumer l'indicateur de sortie finale
       Ligne = 1;        // On initialise le compteur de ligne.
       WRITE ENTETE;
       WRITE TITRE;

       // On se positionne en début de fichier ...
       SETLL *LOVAL PARTICIPA  ;

       // ... et on attaque la lecture séquentielle.
       READ PARTICIPA;

       // Tant qu'on est pas à la fin du fichier ...
       DOW NOT %EOF(PARTICIPA);
         Impression();
       ENDDO;

       //Procédure impression
       DCL-PROC Impression;
         TCODPAR = CODPAR;
         TNM     = NM ;
         TPRN    = PRN ;
         TSCTE   = SCTE;
         TADR    = ADR;
         TNUM    = NUMTEL;
         WRITE DETAIL;
         LIGNE += 1;
         READ PARTICIPA;
         IF LIGNE  = 56;
           WRITE EJECT;
           WRITE ENTETE;
           WRITE TITRE;
           LIGNE = 5;
         ENDIF;
       END-PROC;
```
