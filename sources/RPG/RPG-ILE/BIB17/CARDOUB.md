---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: CARDOUB
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/CARDOUB

```rpg
**free
dcl-pi *n;
    nombre packed(4:0);
end-pi;

dcl-s result packed(10:0);

result= nombre*2;
result = result * result;

dsply result;

*inlr = *on;
```
