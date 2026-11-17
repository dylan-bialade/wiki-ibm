# PRETMOD : 3 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB03 | QRPGLESRC | RPG/RPG-ILE | 41 | 100 % | full free, procedures (dcl-proc), prototypes (dcl-pr) | [PRETMOD.md](../../sources/RPG/RPG-ILE/BIB03/PRETMOD.md) |
| BIB13 | QRPGLESRC | RPG/RPG-ILE | 195 | 8 % | full free, procedures (dcl-proc), prototypes (dcl-pr) | [PRETMOD.md](../../sources/RPG/RPG-ILE/BIB13/PRETMOD.md) |
| BIB17 | QRPGLESRC | RPG/RPG-ILE | 145 | 4 % | full free, boucle DOW/DOU/FOR, procedures (dcl-proc), prototypes (dcl-pr), structure de donnees | [PRETMOD.md](../../sources/RPG/RPG-ILE/BIB17/PRETMOD.md) |

## Differences

- Techniques communes : full free, procedures (dcl-proc), prototypes (dcl-pr)
- **BIB17** en propre : boucle DOW/DOU/FOR, structure de donnees

## Codes

### BIB03 (RPG/RPG-ILE, 41 lignes)

```text
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

### BIB13 (RPG/RPG-ILE, 195 lignes)

_Long : voir [PRETMOD.md](../../sources/RPG/RPG-ILE/BIB13/PRETMOD.md)._

### BIB17 (RPG/RPG-ILE, 145 lignes)

```text
**free
ctl-opt nomain option(*srcstmt);

/copy QCPYSRC,PRETIMMOP

dcl-proc calcTotaux export;
    dcl-pi *n likeds(totaux_t);
        duree packed(2:0);
        taux packed(5:2);
        montant packed(10:0);
    end-pi;

    dcl-ds totaux likeds(totaux_t) inz;
    dcl-ds ech likeds(echeance_t);
    dcl-s mois packed(4:0);
    dcl-s crd packed(12:2); //capital restant du
    dcl-s mens packed(8:2);
    dcl-s i packed(10:0);


    crd = montant;
    mois = duree * 12;
    mens = calcMensualite(montant:taux:duree);

    for i = 1 to mois;
        ech = calcEcheance(crd : taux : mens: i = mois);
        totaux.totalInterets += ech.interets;
        crd = ech.crdFin;
    endfor;

    totaux.coutTotal = totaux.totalInterets + montant;

    return totaux;
end-proc;


dcl-proc calcMensualite export;
    dcl-pi *n packed(8 : 2);
        montant packed(10 : 0) const;
        taux    packed(5 : 2)  const;
        duree   packed(2 : 0)  const;
    end-pi;
    dcl-s t    float(8); //taux mensuel
    dcl-s mois int(10);

    mois = duree * 12;
    if taux = 0;
        return %dech(montant / mois : 8 : 2);
    endif;

    t = taux / 100 / 12;
    return %dech(montant * t / (1 - (1 + t) ** -mois) : 8 : 2);
end-proc;

dcl-proc calcEcheance export;
    dcl-pi *n likeds(echeance_t);
        crd     packed(12 : 2) const;
        taux    packed(5 : 2)  const;
        mens    packed(8 : 2)  const;
        dernier ind            const;
    end-pi;

    dcl-ds ech likeds(echeance_t);

    ech.crdDebut = crd;
    ech.interets = %dech(crd * taux / 1200 : 8 : 2);
    if dernier;
        ech.capital    = crd;
        ech.mensualite = ech.capital + ech.interets;
    else;
        ech.capital    = mens - ech.interets;
        ech.mensualite = mens;
    endif;

    ech.crdFin = crd - ech.capital;

    return ech;
end-proc;

dcl-proc calcTotauxAmortConst export;
    dcl-pi *n likeds(totaux_t);
        duree packed(2:0);
        taux packed(5:2);
        montant packed(10:0);
    end-pi;


    dcl-ds totaux likeds(totaux_t) inz;
    dcl-s mois packed(4:0);
    dcl-s crd packed(12:2); //capital restant du
    dcl-s capRemb packed(12:2);
    dcl-s i packed(10:0);
    dcl-ds ech likeds(echeance_t);


    crd = montant;
    mois = duree * 12;
    capRemb = calcCapitalConstant(duree:montant);

    for i = 1 to mois;
        ech = calcEcheanceAmortConst(crd:taux:capRemb:i = mois);
        totaux.totalInterets += ech.interets;
        crd -= capRemb;
    endfor;

    totaux.coutTotal = totaux.totalInterets + montant;
    return totaux;
end-proc;

dcl-proc calcEcheanceAmortConst export;
    dcl-pi *n likeds(echeance_t);
        crd     packed(12 : 2) const;
        taux    packed(5 : 2)  const;
        capRemb packed(12 : 2)  const;
        dernier ind            const;
    end-pi;


    dcl-ds ech likeds(echeance_t);

    ech.crdDebut = crd;
    ech.interets = %dech(crd * taux / 1200 : 8 : 2);

    if dernier;
        ech.capital    = crd;
        ech.mensualite = ech.capital + ech.interets;
    else;
        ech.capital    = capRemb;
        ech.mensualite = ech.capital + ech.interets;
    endif;

    ech.crdFin = crd - ech.capital;

    return ech;

end-proc;

dcl-proc calcCapitalConstant export;
    dcl-pi *n packed(12:2);
        duree packed(2:0);
        montant packed(10:0);
    end-pi;

    return %dech(montant / (DUREE * 12) : 12 : 2);
end-proc;
```
