---
bibliotheque: BIB19
fichier_source: QRPGLESRC
membre: IDBGSTP
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 23
modifie: 2026-11-16
---

# BIB19/QRPGLESRC/IDBGSTP

```rpg
**free
// ---------------------------------------------------------------------------
// IDBGSTP - programme d'arret (Program-Stop Handler) de BIB19
// Appele par le systeme a chaque point d'arret, pas a pas ou exception non
// surveillee du programme debogue : transmet l'arret a Python et attend.
// Licence MIT
// ---------------------------------------------------------------------------
ctl-opt main(main) option(*srcstmt: *nodebugio);

/copy IDBGSRVPR

dcl-proc main;
  dcl-pi *n;
    qpgm char(20);
    ptype char(10);
    module char(10);
    reason char(10);
    rcv char(16);
    nent int(10);
    msg char(32);
  end-pi;
  idbgStop(qpgm: ptype: module: reason: %addr(rcv): nent: %addr(msg));
end-proc;
```
