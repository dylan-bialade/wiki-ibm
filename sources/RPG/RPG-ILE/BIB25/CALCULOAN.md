---
bibliotheque: BIB25
fichier_source: QTEST
membre: CALCULOAN
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 57
modifie: 2026-11-25
---

# BIB25/QTEST/CALCULOAN

```rpg
**FREE
// MODULE de calcul de prêt immobilier

ctl-opt nomain;

//------------------------------------------------------------------------
// calculMensualite : annuité constante avec taux mensuel effectif
//    montant  packed(15:2) value   -> MONTANT emprunté
//    duree    packed( 2:0)  value  -> nombre de mois
//    taux     packed( 4:2)  value  -> taux annuel en %
// retourne mensualité packed(15:2)
//------------------------------------------------------------------------
dcl-proc calculMensualite export;
  dcl-pi calculMensualite packed(15:2);
    montant packed(15:2) value;
    duree   packed( 7:0)  value;
    taux    packed( 7:4)  value;
  end-pi;
 // exposant pour passer du taux annuel à un taux mensuel effectif
  // taux mensuel effectif
  dcl-s i         packed(7:6);
  dcl-s num       packed(7:6);
  dcl-s result    packed(15:2);

 //  taux mensuel proportionnel
  i   = taux / 1200;

  //  numérateur (1 + taux)** -duree
  num = (1 + i) ** (-duree);

  //  dénominateur = mensualité (pour le test)
  result  = (montant * i) / (1 - num);


  return result;
 end-proc;
//------------------------------------------------------------------------
// calculTotalPret : total versé = mensualité * nombre de mois
//------------------------------------------------------------------------
dcl-proc calculTotalPret export;
  dcl-pi calculTotalPret packed(15:2);
    mensualite packed(15:2) value;
    duree      packed( 5:0)  value;
  end-pi;
  return mensualite * duree;
end-proc;

//------------------------------------------------------------------------
// calculInteret : coût total des intérêts = totalPret  MONTANT
//------------------------------------------------------------------------
dcl-proc calculInteret export;
  dcl-pi calculInteret packed(15:2);
    Pret packed(12:2) value;
    MONTANT   packed(12:2) value;
  end-pi;
  return Pret - MONTANT;
end-proc;
```
