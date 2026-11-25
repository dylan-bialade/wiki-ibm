---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: MODBND
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 23
modifie: 2026-11-25
---

# BIB25/QRPGSRC/MODBND

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**free
CTL-OPT NOMAIN;

DCL-PROC NBR_ENREG EXPORT;
 DCL-PI NBR_ENREG packed(9:0);
   filename char(10);
   lib char(10);
 END-PI;

 dcl-s result packed(9:0);
 dcl-s stmt varchar(200);

 // préparation dynamique de la requête
 stmt = 'select count(*) from ' + %trim(lib) + '.' + %trim(filename) ;
 exec sql prepare mystmt from :stmt;
 exec sql declare c cursor for mystmt;
 exec sql open c;
 exec sql fetch c into :result;
 exec sql close c;

 return result;

END-PROC;
```
