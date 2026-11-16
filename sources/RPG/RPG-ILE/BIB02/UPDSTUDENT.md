---
bibliotheque: BIB02
fichier_source: QAPI
membre: UPDSTUDENT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 31
modifie: 2026-11-16
---

# BIB02/QAPI/UPDSTUDENT

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO) PGMINFO(*PCML : *MODULE);

       EXEC SQL
       SET OPTION COMMIT = *NONE,
       CLOSQLCSR = *ENDMOD;


       DCL-PR UPDSTUDENT EXTPGM('UPDSTUDENT');
         name varchar(25);
         species varchar(25);
         gender varchar(25);
         house varchar(25);
         actor varchar(25);
         idname varchar(25);
       END-PR;

       DCL-PI UPDSTUDENT;
         name varchar(25);
         species varchar(25);
         gender varchar(25);
         house varchar(25);
         actor varchar(25);
         idname varchar(25);
       END-PI;


       *INLR = *ON;

       EXEC SQL
          update BIB02.ostudents set name = :name,  species = :species,
          gender = :gender, house = :house, actor = :actor where name = :idname;
```
