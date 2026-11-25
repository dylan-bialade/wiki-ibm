---
bibliotheque: BIB25
fichier_source: QMODSRC
membre: PGM2
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 10
modifie: 2026-11-25
---

# BIB25/QMODSRC/PGM2

```rpg
**free

CTL-OPT copyright('(C) ORGFORM 2025.') DATFMT(*ISO);

dcl-pr DisplayDSPF;
end-pr;
dsply 'Avant appel d''écran';
DisplayDSPF();
dsply 'nous somme revenu au programme pricnipal';
*inlr = *on;
```
