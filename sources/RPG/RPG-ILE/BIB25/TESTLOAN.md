---
bibliotheque: BIB25
fichier_source: QTEST
membre: TESTLOAN
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 93
modifie: 2026-11-25
---

# BIB25/QTEST/TESTLOAN

```rpg
**FREE
ctl-opt dftactgrp(*no) actgrp(*new) BNDDIR('LOANFUNC');

// on lie le display file
dcl-f ECRAN9 workstn;

// prototype des services
dcl-pr calculMensualite packed(15:2);
  montant      packed(15:2) value;
  duree        packed( 7:0)  value;
  taux         packed( 7:4)  value;
end-pr;

dcl-pr calculTotalPret packed(15:2);
  mensualite   packed(15:2) value;
  duree        packed( 5:0)  value;
end-pr;

dcl-pr calculInteret packed(15:2);
  totalPret    packed(15:2) value;
  capital      packed(15:2) value;
end-pr;

// variables liées aux champs
dcl-s mensualite   packed(15:2);
dcl-s Pret    packed(12:2);
dcl-s coutint packed(12:2);
dcl-s dureeMois    packed( 7:0);


// // MAIN
//  // Boucle de saisie, pour gérer PF12 (Annuler)
//   dou *in03;
//   // écran 1 : saisie
//   exfmt FMT1;
//   // PF12 : on remet à zéro
//   if *in12;
//       montant = 0;
//       duree   = 0;
//       taux    = 0;
//     endif;
//     leave;               // on sort de la boucle DO
//   enddo;
// // Si PF3, on quitte immédiatement
//   if *in03;
//     *inlr = *on;
//     return;
//   endif;
// dureeMois = duree * 12;
//   // calculs via le service
//   mensualite   = calculMensualite(montant : dureeMois : taux);
//   Pret    = calculTotalPret(mensualite : dureeMois);
//   coutint = calculInteret(Pret: montant);

//   // écran 2 : affichage
//   exfmt FMT2;

//   *inlr = *on;


dow not *in03;
  clear MONTANT;
  clear DUREE;
  clear TAUX;
  exfmt fmt1;
  clear message;
  *in30 = *on;
  if *in03;
    leave;
  endif;
  if *in12;
    iter;
  endif;
  if montant = *zero or duree = *zero or taux = *zero;
    *in30 = *off;
    message = 'Veuilez saisir avant d''appuyer sur ENTREE';
    iter;
  endif;
  dureeMois = duree * 12;
  // calculs via le service
  mensualite   = calculMensualite(montant : dureeMois : taux);
  Pret    = calculTotalPret(mensualite : dureeMois);
  coutint = calculInteret(Pret: montant);
  exfmt fmt2;
  if *in03;
    leave;
  endif;
  if *in12;
    iter;
  endif;
enddo;

*inlr = *on;
```
