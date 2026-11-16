---
bibliotheque: BIAILE
fichier_source: QRPGLESRC
membre: PRETMOD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 41
modifie: 2026-11-16
---

# BIAILE/QRPGLESRC/PRETMOD

```rpg
**free
ctl-opt nomain;
/include QCPYSRC,PRETMODP

// Mensualite constante d'un pret a taux fixe
dcl-proc mensualite export;
  dcl-pi *n packed(9:2);
    capital packed(9:2) const;
    tauxAnnuel packed(5:2) const;
    nbMois int(10) const;
  end-pi;

  dcl-s t float(8);
  dcl-s res packed(9:2);

  if nbMois <= 0;
    return 0;
  endif;

  if tauxAnnuel = 0;
    eval(h) res = capital / nbMois;
    return res;
  endif;

  t = tauxAnnuel / 100 / 12;                       // taux mensuel
  eval(h) res = capital * t / (1 - (1 + t) ** (-nbMois));  // (h) = arrondi au centime
  return res;
end-proc;

// Interets d'un mois sur le capital restant du
dcl-proc interetMois export;
  dcl-pi *n packed(9:2);
    capitalRestant packed(9:2) const;
    tauxAnnuel packed(5:2) const;
  end-pi;

  dcl-s res packed(9:2);

  eval(h) res = capitalRestant * tauxAnnuel / 1200;  // taux/100/12
  return res;
end-proc;
```
