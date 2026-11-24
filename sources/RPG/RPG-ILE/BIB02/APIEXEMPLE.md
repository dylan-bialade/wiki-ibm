---
bibliotheque: BIB02
fichier_source: QSRC
membre: APIEXEMPLE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 97
modifie: 2026-11-16
---

# BIB02/QSRC/APIEXEMPLE

```text
        CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*FULL)
        ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
        STGMDL(*INHERIT) THREAD(*SERIALIZE);

       //*****************************************************************
       // Programme : APIEXEMPLE
       // Auteurs : BIB02 SYLVAIN
       // Libéllé :      - PGM QUI CRÉE UN FICHIER TXT AVEC DATA
       // CECI EST UN EXEMPLE POUR LES API INTERNE EN RPG
       // Date Création  - 25/05/2022
       // Mise à jour    - 14/11/2022
       // Copyright - ORGFORM
       //*****************************************************************

       //**********************************************************************//
       // Déclaration des DS                                                   //
       //**********************************************************************//
       Dcl-Ds spla0100 len(1537);
         username char(10)    pos(51);  // Username
         splflnbr bindec(9:0) pos(77);  // Spooled file number
         jobname  char(10)    pos(41);  // Job name
         jobnbr   char(6)     pos(61);  // Job number
       END-DS;

       //**********************************************************************//
       // Déclaration des variables                                            //
       //**********************************************************************//
       Dcl-S pr_cmdstr       Char(4096)      inz(*blanks);
       // Pour l'API QUSRSPLA
       Dcl-S SplFALen              bindec(9:0) ; // Length of receiver variable
       Dcl-S SplFAFmt              char(8)     ; // Format name
       Dcl-S SplFJobN              char(26)    ; // Qualified job name
       Dcl-S SplFIJob              char(16)    ; // Internal job identifier
       Dcl-S SplFIntI              char(16)    ; // Internal spooled file identifier
       Dcl-S SplFName              char(10)    ; // Spooled file name
       Dcl-S SplFNumb              bindec(9:0) ; // Spooled file number
       Dcl-S ApiErr                char(4)     ; // Error Code

       //**********************************************************************//
       // Déclaration des prototypes                                           //
       //**********************************************************************//
       Dcl-Pr QCMDEXC extpgm('QCMDEXC');
         pr_cmdstr       Char(4096)      const options(*varsize);
         pr_cmdstrlen    Packed(15:5)    const;
       End-Pr;

       Dcl-Pr QUSRSPLA extpgm('QUSRSPLA');
         spla0100              likeds(spla0100) const; // Receiver variable
         SplFALen              bindec(9:0)      const; // Length of receiver variable
         SplFAFmt              char(8)          const; // Format name
         SplFJobN              char(26)         const; // Qualified job name
         SplFIJob              char(16)         const; // Internal job identifier
         SplFIntI              char(16)         const; // Internal spooled file identifier
         SplFName              char(10)         const; // Spooled file name
         SplFNumb              bindec(9:0)      const; // Spooled file number
         ApiErr                char(4)          const; // Error Code (Optionel)
       End-Pr;

       //**********************************************************************//
       // Traitement pricipale                                                 //
       //**********************************************************************//
       SplFALen = %size(spla0100); // longueur de la DS
       SplFAFmt = 'SPLA0100'; // Format (voir la doc chez ibm)
       SplFJobN = '*';   // Récupere le Job en entier
       SplFIJob = *Blanks;  // Toujours à vide,  laisser faire l'as400
       SplFIntI = *Blanks;  // Toujours à vide,  laisser faire l'as400
       SplFName = 'PRTFSQL'; // Nom du fichier spool
       SplFNumb = -1; // Utilise le fichier spoule portant le numéro le plus élevé
       ApiErr   = *Loval; // Gestion de l'erreur

       // API qui renvoie des informations spécifiques (attribut) sur un fichier spoule
       QUSRSPLA(spla0100:SplFALen:SplFAFmt:SplFJobN:SplFIJob
         :SplFIntI:SplFName:SplFNumb:ApiErr);

       // Créer le PF
       pr_cmdstr='CRTPF FILE(BIB02/PAS'+ %char(splflnbr) +') RCDLEN(10000)';
       callp QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));
       pr_cmdstr=*Blanks;

       // Copie les données du fichier spool dans le PF
       pr_cmdstr='CPYSPLF FILE(' + SplFName + ') +
       TOFILE(BIB02/PAS'+ %char(splflnbr) + ') +
       JOB('+ SplFJobN +') SPLNBR('+ %char(splflnbr) +') MBROPT(*ADD)';
       callp QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));
       pr_cmdstr=*blanks;

       // Transforme le PF en fichier .TXT (voir sur l'ifs dans /HOME/OPCHE/PAS...)
       pr_cmdstr='CPYTOSTMF FROMMBR('+ X'7D' + '/QSYS.LIB/BIB02.LIB/PAS'
       + %char(splflnbr)
       + '.FILE/PAS' + %char(splflnbr) + '.MBR' + X'7D'
       +') TOSTMF('+ X'7D' +'/HOME/OPCHE/PAS' + %char(splflnbr)
       + '.txt' + X'7D' + ') STMFOPT(*ADD) STMFCCSID(*PCASCII)';
       callp QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));
       pr_cmdstr = *Blanks;


       *inlr=*on;
```
