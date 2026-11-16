---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: TESTSQL
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 31
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/TESTSQL

```rpg
**free

dcl-s name char(52) inz(*blanks);

//exercice 1 : selection d'une valeur dans une table
// exec sql
// select uniname into :name from anime.universv2 where univer = 197;

//exercice 2 : utilisation d'un curseur pour boucler sur bonbon
exec sql
    declare c1 cursor for
        select nom from BIB17.bonbon;

exec sql
    open c1;

dow sqlcode = 0;

    exec sql
    fetch c1 into :name;

    dsply name;

enddo;

exec sql
    close c1;


*inlr
 = *on;
```
