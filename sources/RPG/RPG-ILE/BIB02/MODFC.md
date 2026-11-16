---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: MODFC
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 24
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/MODFC

```rpg
**free
ctl-opt nomain ;

// Renvoi le modulo
dcl-proc modulo export;
  dcl-pi *n int(3);
    num1 int(3);
    num2 int(3);
  end-pi;

  return %rem(num1:num2) ;
end-proc;

// Renvoie le prix TTC
dcl-proc calculTVA export;
  dcl-pi *n int(10);
    ht int(10);
    taxe int(3);
  end-pi;
  Dcl-s ttc int(10);

  ttc = ht * ((taxe/100)+1);
  return ttc;
end-proc;
```
