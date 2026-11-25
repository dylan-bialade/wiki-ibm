---
bibliotheque: BIB25
fichier_source: QFALTER
membre: PF1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 6
modifie: 2026-11-25
---

# BIB25/QFALTER/PF1

```rpg
**free
dcl-f TEST usage(*UPDATE : *OUTPUT) keyed rename(TEST:FTEST);
id = 1;
nom = 'leo';
WRITE FTEST;
return;
```
