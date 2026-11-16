---
bibliotheque: BIB02
fichier_source: QAPI
membre: STUDENT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 30
modifie: 2026-11-16
---

# BIB02/QAPI/STUDENT

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO) PGMINFO(*PCML : *MODULE);

       EXEC SQL
       SET OPTION COMMIT = *NONE,
       CLOSQLCSR = *ENDMOD;

       DCL-PR STUDENT EXTPGM('STUDENT');
         name varchar(25);
         species varchar(25);
         gender varchar(25);
         house varchar(25);
         actor varchar(25);
         idname varchar(25);
       END-PR;

       DCL-PI STUDENT;
         name varchar(25);
         species varchar(25);
         gender varchar(25);
         house varchar(25);
         actor varchar(25);
         idname varchar(25);
       END-PI;

       *INLR = *ON;

       EXEC SQL
        select name, species, gender, house, actor
         into :name, :species, :gender, :house, :actor
         from BIB02.OSTUDENTS where name = :idname;
```
