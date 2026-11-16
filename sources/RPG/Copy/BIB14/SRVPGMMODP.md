---
bibliotheque: BIB14
fichier_source: QCPYSRC
membre: SRVPGMMODP
type: RPG/Copy
longueur_enregistrement: 100
lignes: 53
modifie: 2026-11-16
---

# BIB14/QCPYSRC/SRVPGMMODP

```rpg
**free

/if not defined(SRVPGMMODP)
/define SRVPGMMODP

// template pour les ds de retour.
dcl-ds modules_t qualified template;
  nom char(10);
  lib char(10);
  attribut char(10);
  source char(33);
  dateCreation timestamp;
  lendta packed(3:0);
end-ds;

dcl-ds linkedPgm_t qualified template;
  nom char(10);
  lib char(10);
  type char(7);
  signature char(32);
  lendta packed(3:0);
end-ds;

dcl-ds procExport_t qualified template;
  nom char(100);
  type char(7);
  lendta packed(3:0);
end-ds;

// Prototype d'appel

dcl-pr getmod likeds(modules_t) dim(300);
  lib char(10) const;
  pgm char(10) const;
end-pr;

dcl-pr getlinkedpgm likeds(linkedPgm_t) dim(300);
  lib char(10) const;
  pgm char(10) const;
end-pr;

dcl-pr getprocexp likeds(procExport_t) dim(300);
  lib char(10) const;
  pgm char(10) const;
end-pr;

dcl-pr CHECKSRV;
  lib char(10);
  pgm char(10);
  exist ind;
end-pr;

/endif
```
