---
bibliotheque: BIB02
fichier_source: QCHATGPT
membre: T3DW1
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 50
modifie: 2026-11-16
---

# BIB02/QCHATGPT/T3DW1

```rpg
**FREE
ctl-opt dftactgrp(*no) actgrp(*caller);

// Déclaration des variables pour stocker les données dun article
dcl-s vidmart zoned(5:0);   // Identifiant de larticle
dcl-s vnomart char(20);     // Nom de larticle
dcl-s vprix   zoned(7:2);   // Prix de larticle (7 chiffres dont 2 décimales)
dcl-s msg char(52);         // Message à afficher via DSPF

// Initialisation des options SQL (désactivation du contrôle de commit)
exec sql
set option commit = *none;

// Déclaration du curseur SQL pour lire tous les articles depuis ARTICLEPF
exec sql
declare c1 cursor for
select idart, nomart, prix
from articlepf;

// Ouverture du curseur
exec sql
open C1;

// Boucle infinie avec condition de sortie manuelle
dow 1=1;

  // Lecture dun enregistrement du curseur dans les variables RPG
  exec sql
    fetch c1 into :vidmart, :vnomart, :vprix;

  // Si aucun enregistrement nest retourné, on quitte la boucle
  if sqlcode <> 0;
    leave;
  endif;

  // Vérification du prix : si supérieur ou égal à 50, on affiche le prix
  if vprix >= 50;
    msg = 'Prix : ' + %char(vprix);
  else;
    // Sinon, on indique que le prix est trop bas
    msg = 'Prix trop bas';
  endif;

  // Affichage du message à lécran
  dsply msg;

enddo;

// Fin du programme
*inlr = *on;
```
