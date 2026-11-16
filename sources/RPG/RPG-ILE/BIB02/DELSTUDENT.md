---
bibliotheque: BIB02
fichier_source: QAPI
membre: DELSTUDENT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 20
modifie: 2026-11-16
---

# BIB02/QAPI/DELSTUDENT

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO) PGMINFO(*PCML : *MODULE);

       EXEC SQL
       SET OPTION COMMIT = *NONE,
       CLOSQLCSR = *ENDMOD;


       DCL-PR DELSTUDENT EXTPGM('DELSTUDENT');
         idname varchar(25);
       END-PR;

       DCL-PI DELSTUDENT;
         idname varchar(25);
       END-PI;


       *INLR = *ON;

       EXEC SQL
          delete BIB02.ostudents where name = :idname;
```
