---
bibliotheque: BIB02
fichier_source: QSRC
membre: PRINT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 45
modifie: 2026-11-16
---

# BIB02/QSRC/PRINT

```text
     ***********************************************************************************
       ctl-opt OPTION(*NODEBUGIO : *SRCSTMT) ALWNULL(*USRCTL) ;
     H DFTACTGRP(*NO)
     ***********************************************************************************
     FECRANPRTF O    E             PRINTER
     FSESSIONSP IF A E           K DISK
     ***********************************************************************************
     DLigne            S              3  0
     ***********************************************************************************
       *inlr = *ON;      // On commence par allumer l'indicateur de sortie finale
       Ligne = 1;        // On initialise le compteur de ligne.
       WRITE ENTETE;
       WRITE TITRE;

       // On se positionne en début de fichier ...
       SETLL *LOVAL SESSIONSP  ;

       // ... et on attaque la lecture séquentielle.
       READ SESSIONSP;

       // Tant qu'on est pas à la fin du fichier ...
       DOW NOT %EOF(SESSIONSP);
         Impression();
       ENDDO;

       //Procédure impression
       DCL-PROC Impression;
            TDTDBT = DTDBT ;
            TDTFIN = DTFIN ;
            TNM = NM ;
            TPRN = PRN ;
            TSCTE = SCTE;
            TETAT = ETAT;
            TTPE = TPE;
            TFORM = PRNFMTEUR;
         WRITE DETAIL;
         LIGNE += 1;
         READ SESSIONSP;
         IF LIGNE  = 56;
           WRITE EJECT;
           WRITE ENTETE;
           WRITE TITRE;
           LIGNE = 5;
         ENDIF;
       END-PROC;
```
