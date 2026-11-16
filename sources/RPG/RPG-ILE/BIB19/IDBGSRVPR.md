---
bibliotheque: BIB19
fichier_source: QRPGLESRC
membre: IDBGSRVPR
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 25
modifie: 2026-11-16
---

# BIB19/QRPGLESRC/IDBGSRVPR

```rpg
**free
// IDBGSRVPR - prototypes exportes par IDBGSRV
dcl-pr idbgInit;
  key char(16) const;
end-pr;
dcl-pr idbgEvent;
  kind char(8) const;
  data char(8192) const options(*varsize);
  len int(10) value;
end-pr;
dcl-pr idbgSession char(10);
end-pr;
dcl-pr idbgLastCmd char(3000);
end-pr;
dcl-pr idbgKill;
end-pr;
dcl-pr idbgStop char(10);
  qpgm char(20) const;
  ptype char(10) const;
  module char(10) const;
  reason char(10) const;
  rcv pointer value;
  nent int(10) value;
  msg pointer value;
end-pr;
```
