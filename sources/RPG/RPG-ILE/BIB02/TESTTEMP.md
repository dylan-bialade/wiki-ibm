---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: TESTTEMP
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 18
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/TESTTEMP

```rpg
**free
ctl-opt dftactgrp(*no) actgrp(*caller) optimize(*full) bnddir('MYBNDDIR') stgmdl(*inherit);

// Prototype pour la fonction du programme de service
dcl-pr CelsiusToFahrenheit zoned(5:2);
  celsius zoned(5:2);
end-pr;

// Code pour utiliser la fonction
dcl-s myCelsius zoned(5:2);
dcl-s myFahrenheit zoned(5:2);

myCelsius = 100; // 100 degrés Celsius
myFahrenheit = CelsiusToFahrenheit(myCelsius);

//dsply ('Celsius: ' + %char(myCelsius) + ' -> Fahrenheit: ' + %char(myFahrenheit));

*inlr = *on;
```
