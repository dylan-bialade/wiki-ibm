---
bibliotheque: BIAILE
fichier_source: QCPYSRC
membre: TP1MODP
type: RPG/Copy
longueur_enregistrement: 100
lignes: 22
modifie: 2026-11-16
---

# BIAILE/QCPYSRC/TP1MODP

```rpg
**free
/if not defined(TP1MODP)
/define TP1MODP

// Taux de TVA (en %) pour un code TVA : N=20, I=10, R=5,5, autre=0
dcl-pr tauxTva packed(5 : 3) extproc('TAUXTVA');
  cdTva char(1) const;
end-pr;

// Prix TTC a partir du prix HT, arrondi au centime
dcl-pr calcTtc packed(9 : 2) extproc('CALCTTC');
  pxHt  packed(9 : 2) const;
  cdTva char(1) const;
end-pr;

// Prix HT a partir du prix TTC, arrondi au centime
dcl-pr calcHt packed(9 : 2) extproc('CALCHT');
  pxTtc packed(9 : 2) const;
  cdTva char(1) const;
end-pr;

/endif
```
