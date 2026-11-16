---
bibliotheque: BIB12
fichier_source: QRPGLESRC
membre: EXO1
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 12
modifie: 2026-11-16
---

# BIB12/QRPGLESRC/EXO1

```rpg
**free

dcl-pi *n ;
    nbr packed(4:0);
end-pi;
dcl-s result  packed(5:0);
dcl-s mymove char(10);

result = (nbr*2)*(nbr*2);
dsply mymove;
dsply %editw(result:'  &   ');
*inlr=*on;
```
