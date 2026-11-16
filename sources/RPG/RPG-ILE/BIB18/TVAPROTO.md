---
bibliotheque: BIB18
fichier_source: QRPGLESRC
membre: TVAPROTO
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 19
modifie: 2026-11-16
---

# BIB18/QRPGLESRC/TVAPROTO

```rpg
**free
// Interface pour le module TVAMOD.rpgle
/if not defined(TVAPROTO)
/define TVAPROTO
dcl-pr tauxTva packed(5 : 3);
  cdTva char(1) const;
end-pr;

dcl-pr calcTtc packed(9 : 2);
  pxHt  packed(9 : 2) const;
  cdTva char(1) const;
end-pr;

dcl-pr calcHt packed(9 : 2);
  pxTtc packed(9 : 2) const;
  cdTva char(1) const;
end-pr;

/endif
```
