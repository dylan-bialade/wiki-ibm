---
bibliotheque: BIB02
fichier_source: QCHATGPT
membre: T3DS
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 52
modifie: 2026-11-16
---

# BIB02/QCHATGPT/T3DS

```rpg
**FREE
ctl-opt dftactgrp(*no) actgrp(*caller);

// Déclaration dune DS (Data Structure) pour stocker les données dun article
dcl-ds articleDS ;
  vidmart zoned(5:0);    // Identifiant de larticle
  vnomart char(20);      // Nom de larticle
  vprix   zoned(7:2);    // Prix de larticle (7 chiffres dont 2 après la virgule)
end-ds;

// Variable de message affichée à lécran
dcl-s msg char(52);

// Configuration de la session SQL (aucune gestion de transaction)
exec sql
set option commit = *none;

// Déclaration du curseur SQL pour parcourir les enregistrements de la table ARTICLEPF
exec sql
declare c1 cursor for
select idart, nomart, prix
from articlepf;

// Ouverture du curseur
exec sql
open C1;

// Récupération du premier enregistrement
exec sql
fetch c1 into :articleDS;

// Boucle de traitement tant quil y a des enregistrements à lire
dow sqlcode = 0;

  // Si le prix est supérieur ou égal à 50, on affiche son montant
  if vprix >= 50;
    msg = 'Prix : ' + %char(vprix);
  else;
    // Sinon, on affiche un message indiquant que le prix est trop bas
    msg = 'Prix trop bas';
  endif;

  dsply msg; // Affichage du message à lécran

  // Récupération de lenregistrement suivant
  exec sql
    fetch c1 into :articleDS;

enddo;

// Fin de programme
*inlr = *on;
```
