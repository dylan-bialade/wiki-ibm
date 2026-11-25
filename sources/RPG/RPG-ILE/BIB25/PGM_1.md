---
bibliotheque: BIB25
fichier_source: QILESRC
membre: PGM_1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 29
modifie: 2026-11-25
---

# BIB25/QILESRC/PGM_1

```rpg
**free

dcl-s num1 packed(5:0) inz(10);
dcl-s num2 packed(5:0) INZ(20);
dcl-s num3 packed(4:0) inz(10);
dcl-s num4 packed(4:0) INZ(20);
dcl-s resultat packed(5:0);
dcl-s resultat2 packed(4:0);

DCL-PR Addition packed(5:0);
  num1 packed(5:0);
  num2 packed(5:0);
END-PR;
DCL-PR soustraction packed(4:0);
  num1 packed(4:0);
  num2 packed(4:0);
END-PR;


resultat = Addition(num1:num2);


dsply %char(resultat);

resultat2 = soustraction(num3:num4);

dsply %char(resultat2);

*inlr = *on;
```
