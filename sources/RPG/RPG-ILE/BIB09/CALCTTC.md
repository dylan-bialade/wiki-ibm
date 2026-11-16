---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: CALCTTC
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 44
modifie: 2026-11-16
---

# BIB09/QSOURCES/CALCTTC

```rpg
**free
ctl-opt dftactgrp(*no) actgrp(*caller);

// --------------------------------------------------
// Programme CALCTTC : Calcule un montant TTC
// Parametres :
//   - montantHT   (entree)  : montant hors taxe
//   - tauxTVA     (entree)  : taux de TVA (ex: 0.20)
//   - montantTTC  (sortie)  : montant TTC calcule
//   - codeRetour  (sortie)  : 0 = OK, -1 = erreur
// --------------------------------------------------

// Interface : declare les parametres recus par CE programme
dcl-pi *n;
  montantHT   packed(11:2) const;  // const = parametre non modifie
  tauxTVA     packed(5:4)  const;
  montantTTC  packed(11:2);        // pas de const = parametre modifie (sortie)
  codeRetour  int(10);
end-pi;

// Variables de travail
dcl-s wMontantTVA packed(11:2) inz(*zero);

// --- Logique principale ---

// Validation des parametres d'entree
if montantHT < 0 or tauxTVA < 0;
  montantTTC = 0;
  codeRetour = -1;
  *inlr = *on;
  return;
endif;

// Calcul du montant TVA
wMontantTVA = montantHT * tauxTVA;

// Calcul du montant TTC
montantTTC = montantHT + wMontantTVA;

// Retour OK
codeRetour = 0;

*inlr = *on;
return;
```
