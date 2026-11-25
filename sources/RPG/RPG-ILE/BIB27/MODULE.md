---
bibliotheque: BIB27
fichier_source: QTPSRC
membre: MODULE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 16
modifie: 2026-11-25
---

# BIB27/QTPSRC/MODULE

```rpg
**free

ctl-opt nomain;

dcl-proc calculttc export;
  dcl-pi *n packed(6:2);
    tva packed(3:0);
    prix packed(6:2);
  END-PI;
  dcl-s ttc packed(6:2);
  dcl-s newtva packed(4:2);
  newtva = tva / 100;
  newtva = 1 + newtva;
  ttc = prix * newtva;
  return ttc;
END-PROC;
```
