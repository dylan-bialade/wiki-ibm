---
bibliotheque: BIB18
fichier_source: QRPGLESRC
membre: TVAMOD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 61
modifie: 2026-11-16
---

# BIB18/QRPGLESRC/TVAMOD

```rpg
**free
ctl-opt nomain option(*srcstmt);

/copy QRPGLESRC,TVAPROTO

// N = normal 20 %, I = intermédiaire 10 %, R = réduit 5,5 %, autre = 0 %
dcl-enum tauxTvaEnum qualified;
  NORMAL        20;
  INTERMEDIAIRE 10;
  REDUIT        5.5;
end-enum;

dcl-s nbCalculs int(10) inz(0) export;

dcl-proc arrondir;
  dcl-pi *n packed(9 : 2);
    valeur packed(31 : 9) const;
  end-pi;

  return %dech(valeur : 9 : 2);
end-proc;

// N = normal 20 %, I = intermédiaire 10 %, R = réduit 5,5 %, autre = 0 %
dcl-proc tauxTva export;
  dcl-pi *n packed(5 : 3);
    cdTva char(1) const;
  end-pi;

  select;
    when cdTva = 'N';
      return tauxTvaEnum.NORMAL;
    when cdTva = 'I';
      return tauxTvaEnum.INTERMEDIAIRE;
    when cdTva = 'R';
      return tauxTvaEnum.REDUIT;
    other;
      return 0;
  endsl;
end-proc;

dcl-proc calcTtc export;
  dcl-pi *n packed(9 : 2);
    pxHt  packed(9 : 2) const;
    cdTva char(1) const;
  end-pi;

  nbCalculs += 1;

  return arrondir(pxHt * (1 + tauxTva(cdTva) / 100));
end-proc;

dcl-proc calcHt export;
  dcl-pi *n packed(9 : 2);
    pxTtc packed(9 : 2) const;
    cdTva char(1) const;
  end-pi;

  nbCalculs += 1;

  return arrondir(pxTtc / (1 + tauxTva(cdTva) * 0.01));
end-proc;
```
