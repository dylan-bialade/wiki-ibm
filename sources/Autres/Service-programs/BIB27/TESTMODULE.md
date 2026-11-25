---
bibliotheque: BIB27
fichier_source: QBNDSRC
membre: TESTMODULE
type: Autres/Service-programs
longueur_enregistrement: 100
lignes: 19
modifie: 2026-11-25
---

# BIB27/QBNDSRC/TESTMODULE

```text
**free

ctl-opt nomain;

dcl-proc soustraction export;
  dcl-pi *n packed(4:0) ;
    nbr1 packed(4:0);
    nbr2 packed(4:0);
  END-PI;
  return nbr1 - nbr2;
END-PROC;

dcl-proc multi export;
  dcl-pi *n packed(7:0);
    nbr1 packed(4:0);
    nbr2 packed(4:0);
  END-PI;
  return nbr1 * nbr2;
END-PROC;
```
