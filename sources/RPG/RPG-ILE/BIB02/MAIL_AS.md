---
bibliotheque: BIB02
fichier_source: QSRC
membre: MAIL_AS
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 27
modifie: 2026-11-16
---

# BIB02/QSRC/MAIL_AS

```text
       Ctl-Opt Option (*NoDebugio) DFTACTGRP(*NO);

       Dcl-S pr_cmdstr       Char(4096)      inz(*blanks);
       Dcl-S mailconf        char(64);

       Dcl-Pr QCMDEXC extpgm('QCMDEXC');
         pr_cmdstr       Char(4096)      const options(*varsize);
         pr_cmdstrlen    Packed(15:5)    const;
       End-Pr;

       *inlr=*on;

       send_mail();

       // Sous-routine envoie de mail avec pj
       DCL-PROC send_mail;

         // Mail de la personne qui va recevoir le fichier txt en pj
         mailconf = 'adresse@exemple.invalid';

         // Commande SNDDST
         pr_cmdstr ='SNDDST TYPE(*DOC) TOINTNET(('''+%trim(mailconf)+''')) '+
         'DOC(PA1.txt) FLR(''HOME/OPCHE'')';

         QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));

       End-PROC;
```
