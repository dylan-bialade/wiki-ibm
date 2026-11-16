---
bibliotheque: BIAILE
fichier_source: QRPGLESRC
membre: PRETMAIN
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 95
modifie: 2026-11-16
---

# BIAILE/QRPGLESRC/PRETMAIN

```rpg
**free
ctl-opt decedit('0,') bnddir('BIAILE/PRETBND') dftactgrp(*no);
/include QCPYSRC,PRETMODP

dcl-f PRETDSP workstn indds(ind) sfile(PRETSFL : rrn);

dcl-ds ind len(99);
  f3      ind pos(3);
  f12     ind pos(12);
  sfldsp  ind pos(41);
  sfldspc ind pos(42);
  sflclr  ind pos(43);
  sflend  ind pos(44);
end-ds;

dcl-s rrn zoned(4:0);

wcapital = 200000;
wtaux = 3.5;
wduree = 20;

dou f3;
  exfmt SAISIE;
  if f3;
    leave;
  endif;

  if wcapital <= 0 or wtaux < 0 or wduree < 1 or wduree > 30;
    errmsg = 'Capital > 0, taux >= 0, duree de 1 a 30 ans';
  else;
    errmsg = *blanks;
    afficherTableau();
  endif;
enddo;

*inlr = *on;

dcl-proc afficherTableau;
  dcl-s nbMois int(10);
  dcl-s i int(10);
  dcl-s restant packed(9:2);
  dcl-s mens packed(9:2);
  dcl-s interet packed(9:2);
  dcl-s remb packed(9:2);
  dcl-s totInt packed(11:2);
  dcl-s paiement packed(9:2);
  dcl-s coutTot packed(11:2);

  nbMois = wduree * 12;
  mens = mensualite(wcapital : wtaux : nbMois);   // appel au programme de service

  // vider le sous-fichier
  sfldsp = *off;
  sfldspc = *off;
  sflclr = *on;
  write PRETCTL;
  sflclr = *off;
  rrn = 0;

  restant = wcapital;
  totInt = 0;

  for i = 1 to nbMois;
    interet = interetMois(restant : wtaux);       // appel au programme de service
    if i = nbMois;                                // dernier mois : on solde le pret
      remb = restant;
      paiement = restant + interet;
    else;
      remb = mens - interet;
      paiement = mens;
    endif;

    smois = i;
    srestant = %editc(restant : '1');             // montants mis en forme dans des zones alpha
    sinteret = %editc(interet : '1');
    sremb = %editc(remb : '1');
    smens = %editc(paiement : '1');
    rrn += 1;
    write PRETSFL;

    totInt += interet;
    restant -= remb;
  endfor;

  coutTot = wcapital + totInt;
  wmens = %editc(mens : '1');
  wcoutint = %editc(totInt : '1');
  wcouttot = %editc(coutTot : '1');

  curpage = 1;
  sfldsp = (rrn > 0);
  sfldspc = *on;
  sflend = *on;
  exfmt PRETCTL;                                  // F12 ou F3 : retour a la saisie
end-proc;
```
