---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: RPGSFLFREE
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 155
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/RPGSFLFREE

```text
       CTL-OPT DFTACTGRP(*NO);

       DCL-F EBONSFLOPT WORKSTN SFILE(EBONSFLF:RANG);
       DCL-F LFBONNOM USAGE(*INPUT:*OUTPUT) keyed;
       dcl-f MARQP USAGE(*INPUT) keyed PREFIX(M);
       dcl-f LFBONBON USAGE(*INPUT:*DELETE:*UPDATE) keyed
        PREFIX(NUM) RENAME(FBONBON:NUMBONBONF);

******* DECLARATION VARIABLE

       DCL-S i zoned(2:0) INZ(1);
       DCL-S LASTRANK zoned(4:0) INZ(0);
       DCL-S LASTSCROLL zoned(5:0) INZ(0);
       DCL-PR CREATE EXTPGM('CREABONBON');
       END-PR;
       DCL-PR PRINT EXTPGM('BONRPGFREE');
       END-PR;

******** CODE ***********

       DOW NOT *IN03;
         WRITE EXIT;
         EXFMT EBONCTL;

         // L'indicateur 55 est utilisé pour afficher le message à l'écran
         CLEAR MSGTEXT;

         SELECT;
           WHEN *IN03;
             LEAVE;
           WHEN *IN06;
             CREATE ();
           WHEN *IN29;
             REMP();
           WHEN *IN07;
             PRINT();
             MSGTEXT = '------------- L''impression a été lancé. ------------';
           WHEN SEARCH <> *BLANKS;
             SETLL SEARCH LFBONNOM;
             NETTOYER();
             REMP();
           OTHER;
             DOU NOT %EOF();
               READC EBONSFLF;

               SELECT;
                 WHEN %EOF();
                   RANG = SCROLL;
                   LEAVE;
                 WHEN *IN03;
                   LEAVE;
                 WHEN OPT = 2;
                   MODIFIER();
                 WHEN OPT = 4;
                   SUPPRIMER();
                 WHEN OPT = 5;
                   AFFICHER();
               ENDSL;

               CLEAR OPT;
             ENDDO;
         ENDSL;


         IF MSGTEXT = *BLANKS;
           // L'indicateur 55 est utilisé pour afficher le message à l'écran
           *IN55 = *OFF;
         ELSE;
           *IN55 = *ON;
         ENDIF;
       ENDDO;
       *INLR = *ON;

       //********* BEGSR INITILISATION
       BEGSR *INZSR;
         *IN30 = *ON;
         *IN31 = *ON;
         NETTOYER();
         SETLL *LOVAL LFBONNOM;
         REMP();
       ENDSR;

       //*********  PROC NETTOYER

       DCL-PROC NETTOYER;
         RANG = 0;
         LASTRANK = 0;
         *IN32 = *ON;
         WRITE EBONCTL;
         *IN32 = *OFF;
       END-PROC;

       //********* PROC REMPLISSAGE
       DCL-PROC REMP;
         RANG = LASTRANK;
         FOR i = 1 to 12;
           READ LFBONNOM;

           IF %EOF();
             *IN33 = *ON;
             LEAVE;
           ENDIF;

           RANG += 1;
           CHAIN MARQUE MARQP;
           IF NOT %FOUND();
             *IN50 = *ON;
           ENDIF;

           WRITE EBONSFLF;

           *IN50 = *OFF;
         ENDFOR;
         LASTRANK = RANG;
       END-PROC;


       //********* PROC MODIFIER

       DCL-PROC MODIFIER;
         CHAIN NUMBB LFBONBON;
         EXFMT MODIF;
         UPDATE NUMBONBONF;
         UPDATE EBONSFLF;
       END-PROC;

       //********* PROC SUPPRIMER

       DCL-PROC SUPPRIMER;
         CHAIN NUMBB LFBONBON;
         MSGTEXT = 'Le bonbon ' + %trim(NOM) + ' a été supprimé.';
         DELETE NUMBONBONF;
         CLEAR OPT;
         NEWPLACE();
       END-PROC;

       //********* PROC AFFICHER

       DCL-PROC AFFICHER;
         EXFMT AFFICHE;
       END-PROC;

       //********* PROC RAFRAICHISSEMENT DE LA PAGE JUSQU'AU SCROLL

       DCL-PROC NEWPLACE;
         IF SCROLL <> *ZERO AND SCROLL < LASTRANK;
         LASTSCROLL = SCROLL;
         endif;
         NETTOYER();
         SETLL *LOVAL LFBONNOM;

         DOW RANG < LASTSCROLL;
           REMP();
         ENDDO;
       END-PROC;
```
