---
bibliotheque: BIB03
fichier_source: QCPYSRC
membre: PRETMODP
type: RPG/Copy
longueur_enregistrement: 100
lignes: 16
modifie: 2026-11-16
---

# BIB03/QCPYSRC/PRETMODP

```rpg
**free
/if not defined(PRETMODP)
/define PRETMODP

dcl-pr mensualite packed(9:2);
  capital packed(9:2) const;
  tauxAnnuel packed(5:2) const;
  nbMois int(10) const;
end-pr;

dcl-pr interetMois packed(9:2);
  capitalRestant packed(9:2) const;
  tauxAnnuel packed(5:2) const;
end-pr;

/endif
```
