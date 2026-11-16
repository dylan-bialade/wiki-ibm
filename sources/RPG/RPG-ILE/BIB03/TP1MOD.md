---
bibliotheque: BIB03
fichier_source: QRPGLESRC
membre: TP1MOD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 59
modifie: 2026-11-16
---

# BIB03/QRPGLESRC/TP1MOD

```rpg
**free
ctl-opt nomain;

/copy QCPYSRC,TP1MODP

// Donnee exportee : nombre de calculs effectues
dcl-s nbCalculs int(10) export inz(0);

// Procedure interne (non exportee) : arrondi au centime
dcl-proc arrondir;
  dcl-pi *n packed(9 : 2);
    valeur packed(31 : 9) const;
  end-pi;

  return %dech(valeur : 9 : 2);
end-proc;

dcl-proc tauxTva export;
  dcl-pi *n packed(5 : 3);
    cdTva char(1) const;
  end-pi;

select;
    when cdTva = 'N';
      return 20;
    when cdTva = 'I';
      return 10;
    when cdTva = 'R';
      return 5.5;
    other;
      return 0;
  endsl;
end-proc;

dcl-proc calcTtc export;
  dcl-pi *n packed(9 : 2);
    pxHt  packed(9 : 2) const;
    cdTva char(1) const;
  end-pi;

  dcl-s brut packed(31 : 9);

  nbCalculs += 1;
  brut = pxHt * (1 + tauxTva(cdTva) / 100);
  return arrondir(brut);
end-proc;

dcl-proc calcHt export;
  dcl-pi *n packed(9 : 2);
    pxTtc packed(9 : 2) const;
    cdTva char(1) const;
  end-pi;

  dcl-s brut packed(31 : 9);

  nbCalculs += 1;
  brut = pxTtc / (1 + tauxTva(cdTva) / 100);
  return arrondir(brut);
end-proc;
```
