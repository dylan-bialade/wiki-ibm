---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: MODFC
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 12
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/MODFC

```rpg
**free
ctl-opt nomain ;

// Renvoi le modulo
dcl-proc modulo export;
  dcl-pi *n zoned(5:0);
    num1 zoned(5:0);
    num2 zoned(5:0);
  end-pi;

  return %rem(num1:num2) ;
end-proc;
```
