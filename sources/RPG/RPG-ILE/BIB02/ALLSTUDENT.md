---
bibliotheque: BIB02
fichier_source: QAPI
membre: ALLSTUDENT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 47
modifie: 2026-11-16
---

# BIB02/QAPI/ALLSTUDENT

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO) PGMINFO(*PCML : *MODULE);

       EXEC SQL
       SET OPTION COMMIT = *NONE,
       CLOSQLCSR = *ENDMOD;

       DCL-PR ALLSTUDENT EXTPGM('ALLSTUDENT');
         OStudents likeds (infostudents) dim(1000) options(*varsize);
       END-PR;

       DCL-PI ALLSTUDENT;
         OStudents likeds (infostudents) dim(1000) options(*varsize);
       END-PI;

       DCL-DS infostudents;
         iname varchar(25);
         ispecies varchar(25);
         igender varchar(25);
         ihouse varchar(25);
         iactor varchar(25);
       END-DS;

       DCL-S nbart int(10) inz(0);

       *INLR = *ON;

       EXEC SQL
              Declare C1 CURSOR FOR
               select name, species, gender, house, actor
               from BIB02.OSTUDENTS;

       EXEC SQL
             open C1;

       DOW sqlcode = 0;
         nbart += 1;
         EXEC SQL Fetch C1 into :iname, :ispecies, :igender, :ihouse, :iactor;

         IF %eof or sqlcode <> 0;
           leave;
         ENDIF;

         ostudents(nbart) = infostudents;

       ENDDO;

       EXEC SQL CLOSE c1;
```
