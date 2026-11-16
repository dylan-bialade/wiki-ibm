---
bibliotheque: BIB02
fichier_source: QAPI
membre: PPDSTUDENT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 147
modifie: 2026-11-16
---

# BIB02/QAPI/PPDSTUDENT

```text
       CTL-OPT option(*nodebugio : *srcstmt) PGMINFO(*PCML : *MODULE);

       EXEC SQL
       SET OPTION COMMIT = *NONE,
       CLOSQLCSR = *ENDMOD;

       // Affichage
       DCL-PR GETSTUDENT;
         name varchar(25);
         species varchar(25);
         gender varchar(25);
         house varchar(25);
         actor varchar(25);
         idname varchar(25);
       END-PR;

       DCL-PR GETALLSTUDENT;
         OStudents likeds (infostudents) dim(1000) options(*varsize);
       END-PR;

       // Création
       DCL-PR CRUSTUDENT;
         name varchar(25);
         species varchar(25);
         gender varchar(25);
         house varchar(25);
         actor varchar(25);
         idname varchar(25);
       END-PR;

       // Modification
       DCL-PR UPDSTUDENT ;
         name varchar(25);
         species varchar(25);
         gender varchar(25);
         house varchar(25);
         actor varchar(25);
         idname varchar(25);
       END-PR;

       // Suppression
       DCL-PR DELSTUDENT;
         idname varchar(25);
       END-PR;

       DCL-DS infostudents;
         iname varchar(25);
         ispecies varchar(25);
         igender varchar(25);
         ihouse varchar(25);
         iactor varchar(25);
       END-DS;
       DCL-S nbart int(10) inz(0);


       /if defined(IMPORT_PROTOTYPES)
       /eof
       /endif

       *INLR = *ON;

       DCL-PROC GETSTUDENT EXPORT;
         DCL-PI GETSTUDENT;
           name varchar(25);
           species varchar(25);
           gender varchar(25);
           house varchar(25);
           actor varchar(25);
           idname varchar(25);
         END-PI;

         EXEC SQL
         select name, species, gender, house, actor
         into :name, :species, :gender, :house, :actor
         from BIB02.OSTUDENTS where name = :idname;

         return;
       END-PROC;

       DCL-PROC GETALLSTUDENT EXPORT;
         DCL-PI GETALLSTUDENT;
          OStudents likeds (infostudents) dim(1000) options(*varsize);
         END-PI;
          clear oStudents;
         EXEC SQL
              Declare C1 CURSOR FOR
               select name, species, gender, house, actor
               from BIB02.OSTUDENTS;

         EXEC SQL
               open C1;

         DOW sqlcode = 0;

           nbart += 1;
         EXEC SQL Fetch C1 into  :iname, :ispecies, :igender, :ihouse, :iactor;

           IF sqlcode <> 0;
             leave;
           ENDIF;

           ostudents(nbart) = infostudents;

         ENDDO;

         EXEC SQL CLOSE c1;
         return;
       END-PROC;

       DCL-PROC CRUSTUDENT EXPORT;
         DCL-PI CRUSTUDENT;
           name varchar(25);
           species varchar(25);
           gender varchar(25);
           house varchar(25);
           actor varchar(25);
           idname varchar(25);
         END-PI;
         EXEC SQL
             insert into BIB02.ostudents (name, species, gender, house, actor)
             values (:name, :species, :gender, :house, :actor);
         return;
       END-PROC;

       DCL-PROC UPDSTUDENT EXPORT;
         DCL-PI UPDSTUDENT;
           name varchar(25);
           species varchar(25);
           gender varchar(25);
           house varchar(25);
           actor varchar(25);
           idname varchar(25);
         END-PI;
         EXEC SQL
            update BIB02.ostudents set name = :name,  species = :species,
          gender = :gender, house = :house, actor = :actor where name = :idname;
         return;
       END-PROC;

       DCL-PROC DELSTUDENT EXPORT;
         DCL-PI DELSTUDENT;
           idname varchar(25);
         END-PI;
         EXEC SQL
          delete BIB02.ostudents where name = :idname;
         return;
       END-PROC;
```
