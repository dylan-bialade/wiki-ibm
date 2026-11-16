---
bibliotheque: BIB13
fichier_source: QCPYSRC
membre: TP01MODP
type: RPG/Copy
longueur_enregistrement: 114
lignes: 41
modifie: 2026-11-16
---

# BIB13/QCPYSRC/TP01MODP

```rpg
**free



/if not defined(TP01MODP)

/define TP01MODP





dcl-pr tauxTVA packed(5:3);

  cddta char(1) const;

end-pr;



dcl-pr calcttc packed(9:2);

  pxht packed(9:2) const;

  cdtva char(1) const;

end-pr;



dcl-pr calcht packed(9:2);

  pxttc packed(9:2) const;

  cdtva char(1) const;

end-pr;



/endif
```
