---
bibliotheque: BIB02
fichier_source: QAPI
membre: CRUSTUDENT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 31
modifie: 2026-11-16
---

# BIB02/QAPI/CRUSTUDENT

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO) PGMINFO(*PCML : *MODULE);

       EXEC SQL
       SET OPTION COMMIT = *NONE,
       CLOSQLCSR = *ENDMOD;


       DCL-PR CRUSTUDENT EXTPGM('CRUSTUDENT');
         name varchar(25);
         species varchar(25);
         gender varchar(25);
         house varchar(25);
         actor varchar(25);
         idname varchar(25);
       END-PR;

       DCL-PI CRUSTUDENT;
         name varchar(25);
         species varchar(25);
         gender varchar(25);
         house varchar(25);
         actor varchar(25);
         idname varchar(25);
       END-PI;


       *INLR = *ON;

       EXEC SQL
           insert into BIB02.ostudents (name, species, gender, house, actor)
           values (:name, :species, :gender, :house, :actor);
```
