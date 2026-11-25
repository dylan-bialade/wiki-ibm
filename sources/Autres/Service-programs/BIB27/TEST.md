---
bibliotheque: BIB27
fichier_source: QBNDSRC
membre: TEST
type: Autres/Service-programs
longueur_enregistrement: 100
lignes: 28
modifie: 2026-11-25
---

# BIB27/QBNDSRC/TEST

```text
**free
ctl-opt bnddir('BIB27/TESTREP');

dcl-pr soustraction packed(4:0);
  nbr1 packed(4:0);
  nbr2 packed(4:0);
end-pr;

dcl-pr multi packed(7:0);
  nbr1 packed(4:0);
  nbr2 packed(4:0);
END-PR;

dcl-s result packed(4:0);
dcl-s result1 packed(7:0);
dcl-s nbr1 packed(4:0) inz(52);
dcl-s nbr2 packed(4:0) inz(15);


result = soustraction(nbr1:nbr2);

dsply result;

result1 = multi(nbr1:nbr2);

dsply result1;

*inlr = *on;
```
