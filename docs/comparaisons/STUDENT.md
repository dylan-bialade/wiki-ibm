# STUDENT : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QAPI | RPG/RPG-ILE | 30 | 0 % | SQL embarque, prototypes (dcl-pr) | [STUDENT.md](../../sources/RPG/RPG-ILE/BIB02/STUDENT.md) |
| BIB25 | QRPGSRC | RPG/RPG-III-400 | 5 | 100 % |  | [STUDENT.md](../../sources/RPG/RPG-III-400/BIB25/STUDENT.md) |

## Differences

- **BIB02** en propre : SQL embarque, prototypes (dcl-pr)
- Langages / types differents : RPG/RPG-III-400, RPG/RPG-ILE

## Codes

### BIB02 (RPG/RPG-ILE, 30 lignes)

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

### BIB25 (RPG/RPG-III-400, 5 lignes)

```text
                                            UNIQUE                                              R FSTUDENT
                                                                  ID             6S 0
                                  NAME          25A
  FIRSTNAME     25A                                                               DATE_N          L
                                                K ID
```
