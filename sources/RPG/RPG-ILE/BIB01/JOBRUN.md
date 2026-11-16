---
bibliotheque: BIB01
fichier_source: QRPGLESRC
membre: JOBRUN
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 5
modifie: 2026-11-16
---

# BIB01/QRPGLESRC/JOBRUN

```rpg
**FREE
Dcl-s date4 date(*iso)
date4 = %date();
dsply ('Date4 + *longjobrun :' + %char(date4):*longjobrun));
*inlr = *on;
```
