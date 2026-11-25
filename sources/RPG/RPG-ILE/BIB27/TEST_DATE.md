---
bibliotheque: BIB27
fichier_source: QRPGLESRC
membre: TEST_DATE
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 29
modifie: 2026-11-25
---

# BIB27/QRPGLESRC/TEST_DATE

```rpg
**free
dcl-s date_test date;
dcl-s day_test char(2);
dcl-s month_test char(2);
dcl-s year_test char(4);
dcl-s century char(2);
dcl-s year char(2);

date_test = %date(); //on récupère 2024-05-24
dsply 'DATE DU JOUR';
dsply %char(date_test);  // on affiche '2024-05-24'


day_test = %subst(%char(date_test) : 9 : 2);  // position 9 de longueur 2
month_test = %subst(%char(date_test) : 6 : 2); // position 6 de longueur 2
year_test = %subst(%char(date_test) : 1 : 4);  // position 1 de longueur 4
dsply 'JOUR/MOIS/ANNEE';
dsply day_test;
dsply month_test;
dsply year_test;

// découper l'année en 2 chaines de caractères
century = %subst(year_test : 1 : 2); // position 1 de longueur 2
year = %subst(year_test : 3 : 2);
dsply 'SIECLE/ANNEE';
dsply century;
dsply year;

*inlr = *on;
```
