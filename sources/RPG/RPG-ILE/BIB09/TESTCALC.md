---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: TESTCALC
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 40
modifie: 2026-11-16
---

# BIB09/QSOURCES/TESTCALC

```rpg
**free
ctl-opt dftactgrp(*no) actgrp(*caller);

// --------------------------------------------------
// Programme TESTCALC : Appelle CALCTTC pour calculer
// un montant TTC et affiche le resultat
// --------------------------------------------------

// Prototype : declare le programme externe a appeler
// Le nom dans EXTPGM doit correspondre au *PGM compile
dcl-pr calculerTTC extpgm('CALCTTCC');
  montantHT   packed(11:2) const;
  tauxTVA     packed(5:4)  const;
  montantTTC  packed(11:2);
  codeRetour  int(10);
end-pr;

// Variables de travail
dcl-s wHT      packed(11:2) inz(1000.00);
dcl-s wTVA     packed(5:4)  inz(0.2000);
dcl-s wTTC     packed(11:2) inz(*zero);
dcl-s wRetour  int(10)      inz(0);
dcl-s wMessage char(52)     inz(*blanks);

// --- Logique principale ---

// Appel du programme CALCTTC avec les parametres
calculerTTC(wHT : wTVA : wTTC : wRetour);

// Verification du code retour
if wRetour = 0;
  wMessage = 'Montant TTC = ' + %char(wTTC);
  dsply wMessage;
else;
  wMessage = 'Erreur lors du calcul TTC';
  dsply wMessage;
endif;

*inlr = *on;
return;
```
