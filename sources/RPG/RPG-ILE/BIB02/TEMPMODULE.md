---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: TEMPMODULE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/TEMPMODULE

```rpg
**free
ctl-opt nomain optimize(*full) stgmdl(*inherit);

// Fonction pour convertir Celsius en Fahrenheit
dcl-proc CelsiusToFahrenheit export;
  dcl-pi CelsiusToFahrenheit zoned(5:2);
    celsius zoned(5:2);
  end-pi;

  dcl-s temperature zoned(5:2);
  temperature = (celsius * 9 / 5) + 32;
  return temperature;
end-proc;
```
