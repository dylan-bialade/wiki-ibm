---
bibliotheque: BIB27
fichier_source: QPROCSRC
membre: S_NOMBRE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 35
modifie: 2026-11-25
---

# BIB27/QPROCSRC/S_NOMBRE

```rpg
**free

// déclaraives

ctl-opt dftactgrp(*no);
dcl-s nbr1 int(5) inz(142);
dcl-s nbr2 int(5) inz(196);
dcl-s nbr3 int(5) inz(259);


dcl-pr traitement int(5);
   a1 int(5);
   a2 int(5);
   a3 int(5) const;
END-PR;



// prog
dsply (traitement(nbr1:nbr2:15));

*inlr = *on;

// procédures

dcl-proc traitement;
  dcl-pi *n int(5) ;
    nbr1 int(5);
    nbr2 int(5);
    nbr3 int(5) const;
  END-PI;
  dcl-s nbr int(5);
  nbr = nbr1 + nbr2 + nbr3;
  return nbr;
END-PROC;
```
