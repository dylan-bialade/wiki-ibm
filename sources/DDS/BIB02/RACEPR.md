---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: RACEPR
type: DDS
longueur_enregistrement: 100
lignes: 98
modifie: 2026-11-16
---

# BIB02/QDDSRC/RACEPR

```text
     ***********************************************************************************
       // But du programme :
       // Imprimer dans un spool le contenu du fichier AGENCEL1.
       // Le fichier PRTF qui va générer le spoole est AGENCET. Les zones à imprimer
       // correspondent aux nom des zones d'AGENCE, préfixé par T.
     ***********************************************************************************
       ctl-opt OPTION(*NODEBUGIO : *SRCSTMT) ALWNULL(*USRCTL) ;
     H DFTACTGRP(*NO)
     ***********************************************************************************
     FRACEPRTF  O    E             PRINTER
     FRACEJ1    IF   E           K DISK
     ***********************************************************************************
     DLigne            S              3  0
     Dmec              S              2  0
     Dmlu              S              2  0
     Dfirsttime        S              2  0
     DPos              S              2  0

     ***********************************************************************************
       *inlr = *ON;      // On commence par allumer l'indicateur de sortie finale
       Ligne = 1;        // On initialise le compteur de ligne.
       // Tableau Mois
       WRITE ENTETE;
       WRITE TITRE;

       // On se positionne en début de fichier ...
       SETLL *LOVAL RACEJ1;

       // ... et on attaque la lecture séquentielle.
       READ RACEJ1;

       mec = %subdt(DTRACE : *M);  // mec = 01

       // Tant qu'on est pas à la fin du fichier ...
       DOW NOT %EOF(RACEJ1);
         Impression();
       ENDDO;

       WRITE SA;

       //Procédure impression
       DCL-PROC Impression;

         // Mois lu en cours    01
         mlu = %subdt(DTRACE : *M);
         if firsttime = 1;
           mec = mlu;
           firsttime = 0;
         ENDIF;
         IF mlu = mec ;
           Pos +=1;
           TDTRACE  = DTRACE;
           TLIBELLE = LIBELLE;
           TNMRACE  = NMRACE;
           TDSRACE  = DSRACE;
           TT1RACE  = T1RACE;
           TP3RACE  = P3RACE;
           TDTRACESA  = %dec(%subdt(TDTRACE : *Y));
           TDTRACESM  = %dec(%subdt(TDTRACE : *M));
           TDTRACEDS += TDSRACE;
           TDTRACEMT  = T1RACE;

           IF TP3RACE <> 0;
             TDTRACEMP += TP3RACE;
           ELSE;
             POS = POS -1;
           ENDIF;

           WRITE DETAIL;
         ENDIF;
         IF mlu <> mec;
           mlu = mec;
           firsttime = 1;

           IF POS <> 0;
       //      TDTRACEMT = TDTRACEMT/POS;
             TDTRACEMP = TDTRACEMP/POS;
           ENDIF;

           WRITE SA;
           TDTRACEDS = 0;
           TDTRACEMP = 0;
           //    TDTRACEMT = ' ';
           Pos = 0;
         ENDIF;


         LIGNE += 1;
         READ RACEJ1;
         IF LIGNE  = 56;
           WRITE EJECT;
           WRITE ENTETE;
           WRITE TITRE;
           LIGNE = 5;
         ENDIF;

       // ENDIF;
       END-PROC;
```
