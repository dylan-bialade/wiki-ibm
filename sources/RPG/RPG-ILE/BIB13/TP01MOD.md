---
bibliotheque: BIB13
fichier_source: QRPGLESRC
membre: TP01MOD
type: RPG/RPG-ILE
longueur_enregistrement: 114
lignes: 119
modifie: 2026-11-16
---

# BIB13/QRPGLESRC/TP01MOD

```rpg
**free

ctl-opt nomain option(*srcstmt:*nodebugio);



// copie des pr

/copy QCPYSRC,TP01MODP



// declaration variable globale

dcl-s nbCalcul int(10) inz(0) export;



// thaux de tva en fonction du code

dcl-proc tauxTVA export;

  dcl-pi *n packed(5:3);

    cdtva char(1) const;

  end-pi;



  select;

    when (cdtva = 'N');

      return 20;

    when (cdtva = 'I');

      return 10;

    when (cdtva = 'R');

      return 5.5;

    other;

      return 0;

  endsl;



end-proc;



// calcul TTc avec arrondi au centime

dcl-proc calcttc export;

  dcl-pi *n packed(9:2);

    pxht packed(9:2) const;

    cdtva char(1) const;

  end-pi;

  dcl-s var packed(31:9);

  var+=pxht*(1+tauxTVA(cdtva)*0.01);

  nbCalcul+=1;

  return arrondir(var);

end-proc;



// calcul TTc avec arrondi au centime

dcl-proc calcht export;

  dcl-pi *n packed(9:2);

    pxttc packed(9:2) const;

    cdtva char(1) const;

  end-pi;

  dcl-s var packed(31:9);



  var=pxttc / (1 + tauxTVA(cdtva)*0.01);

  nbCalcul+=1;

  return arrondir(var);

end-proc;





dcl-proc arrondir;

  dcl-pi *n packed(9:2);

    valeur packed(31:9);

  end-pi;

  return %dech(valeur:9:2);

end-proc;
```
