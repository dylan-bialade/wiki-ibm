---
bibliotheque: BIB13
fichier_source: QRPGLESRC
membre: PRETMAIN
type: RPG/RPG-ILE
longueur_enregistrement: 114
lignes: 167
modifie: 2026-11-16
---

# BIB13/QRPGLESRC/PRETMAIN

```rpg
**free



ctl-opt dftactgrp(*no) actgrp(*new) bnddir('PRET_DIR');

/copy QCPYSRC,PRETMODP



dcl-f pretimmo workstn sfile(sfl1: rrn);



dcl-s rrn packed(4:0)inz(0);



dcl-s PtrInd pointer inz(%addr(*in));

dcl-ds DS_Global based(PtrInd);

    // FN

  EXIT ind pos(3);

  ANNULER ind pos(12);

    // sfl

  SFLCLR ind pos(30);

  SFLEND ind pos(31);

  CTLDSP ind pos(32);

  SFLDSP ind pos(33);

end-ds;



*inlr = *on;



dou EXIT;

  exfmt fmt1;

  if EXIT;

    leave;

  endif;

  if (F_DUREE=*zeros or F_MONTANT = *zeros or F_TAUX = *zeros);

    iter;

  endif;

  ecranDetail();

enddo;





dcl-proc ecranDetail;

  initsfl();

  chargeSfl();

  dou (exit or ANNULER);

    exfmt ctl1;

  enddo;



end-proc;



dcl-proc initsfl;

  SFLDSP = *off;

  CTLDSP = *off;

  SFLEND = *off;

  SFLCLR=*on;

  write ctl1;

  SFLCLR = *off;

  rrn = 0;

  clear sfl1;

end-proc;



dcl-proc chargeSfl;

  C_MENS = calcMensualite(F_MONTANT:F_TAUX:F_DUREE);

  C_INTERET = calcTotInteret(F_DUREE:F_TAUX:F_MONTANT);

  C_TOTAL = F_MONTANT + C_INTERET;



  S_CAP = F_MONTANT;

  S_MENS = C_MENS;



  for rrn = 1 to nbMois(F_DUREE);

    S_MOIS = rrn;

    S_CAP = capitalRestant(S_CAP:S_CAPR);

    S_INTR = interetsMois(F_TAUX:S_CAP);

    S_CAPR = ammotismois(S_INTR:S_MENS);

    if S_CAP<S_CAPR;

      S_CAPR = s_cap;

      S_MENS = S_CAPR + S_INTR;

    endif;

    write sfl1;

  endfor;



  if rrn>0;

    SFLDSP =*on;

  else;

    SFLDSP = *off;

  endif;

  SFLEND = *on;

  CTLDSP = *on;

  write foot;

end-proc;
```
