---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: CTVATP
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 78
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/CTVATP

```rpg
**FREE
ctl-opt dftactgrp(*no) actgrp(*caller);

// Déclaration des variables
dcl-s MontantHT zoned(7:2);    // Montant HT saisi par l'utilisateur
dcl-s MontantTTC zoned(7:2);   // Montant TTC retourné par la procédure
dcl-s Saisie varchar(10);      // Zone pour lire l'entrée utilisateur
dcl-s Msg char(52);            // Message à afficher avec DSPLY
dcl-s pos int(5);              // Position du caractère non valide

// Prototype de la procédure CalculTVA
dcl-pr CalculTVA zoned(7:2);
  HT zoned(7:2) value;
end-pr;

// Lecture du montant HT
dsply 'Montant HT ?' '' Saisie;

// Nettoyage des blancs
Saisie = %trim(Saisie);

// Vérifie si tous les caractères sont bien numériques ou un point
pos = %checkr('0123456789.' : Saisie);

// Si la saisie n'est pas vide et ne contient pas de caractère invalide
if Saisie <> *blanks and pos = *zero;

  monitor;
     // Tente la conversion
     MontantHT = %dec(Saisie : 7 : 2);

     // Appel de la procédure
     MontantTTC = CalculTVA(MontantHT);

     // Prépare le message d'affichage
     Msg = 'Montant TTC : ' + %char(MontantTTC);
     dsply Msg;

  on-error;
     dsply 'Erreur : la saisie est invalide ou mal formatée.';
  endmon;

else;
  dsply 'Erreur : caractères non numériques ou saisie vide.';
endif;

*inlr = *on;

//
// PROCÉDURE CalculTVA
//
dcl-proc CalculTVA;  // Début de la procédure nommée CalculTVA

  // Déclaration des paramètres dentrée/sortie de la procédure
  dcl-pi *n zoned(7:2);     // *n signifie que la procédure na pas de nom interne
    HT zoned(7:2) value;    // Paramètre en entrée : montant HT, passé par valeur (copie)
  end-pi;

  // Déclaration des variables internes à la procédure
  dcl-s TVA zoned(5:2);     // Taux de TVA
  dcl-s TTC zoned(7:2);     // Montant TTC calculé

  // Application des règles de TVA selon le montant HT
  if HT >= 500;                             // Si le montant est supérieur ou égal à 500
    TVA = 20.00;                            // Appliquer une TVA de 20%
  elseif (HT > 250 and HT < 500)            // Sinon, si entre 250 et 499,99...
         or (HT = 7);                       // ... ou si le montant est exactement égal à 7
    TVA = 10.00;                            // Appliquer une TVA de 10%
  else;                                     // Dans tous les autres cas
    TVA = 5.50;                             // Appliquer une TVA réduite de 5.5%
  endif;

  // Calcul du montant TTC : HT + (HT * TVA / 100)
  TTC = HT + (HT * TVA / 100);

  return TTC;  // La procédure retourne le montant TTC

end-proc;  // Fin de la procédure
```
