---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: MOTSRPG
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 70
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/MOTSRPG

```rpg
**free
// RPG BATTLE DEV 2023 - Manche 1 - Epreuve 2 - Du 7 au 9 juin 2023

// Contexte :
//  Définition : un palindrome est un mot qui peut se lire dans les 2 sens. Exem
//  Le fichier base de données BATTLE/MOTS contient une liste de mots

// Objectif :
//  Afficher le nombre de palindromes présents et les afficher (DSPLY)
//  Exemple de résultat :
// DSPLY  radar
// DSPLY  kayak
// DSPLY  ressasser

// Consignes :                   s
//  1. Ne pas modifier les lignes de code déjà présentes, ajouter vos lignes de
//  2. Utiliser uniquement des instructions RPG natives (pas de SQL)
//  3. Dans le fichier MOTS :
//     - Ne pas tenir compte des espaces et des ponctuations
//     - Considérer les caractères accentués comme leurs caractères de base (é)

// Critères d'évaluation :
//  1. Le résultat doit être celui demandé
//  2. Le code présent ne doit pas être modifié
//  3. Le code doit être le plus simple, le plus lisible possible et le plus
// timisé


// **********************************************************************//
// Option de compilation                                                 //
// **********************************************************************//
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt);
// **********************************************************************//
// Déclaration des fichiers                                              //
// **********************************************************************//
dcl-f mots rename(mots:fmots);

// **********************************************************************//
// Déclaration des variables                                              //
// **********************************************************************//
dcl-s motInverse varchar(50);


// Déclaration des variables
dcl-ds dsM qualified;
  mot char(50);
  c char(1) dim(50) pos(1);
end-ds;
dcl-s l int(5);
dcl-s i int(5);
dcl-s ok ind;

read mots;
dow not %eof(mots);
  dsM.mot = %lower(LEMOT);
  l = %len(%trimr(dsM.mot));
  ok = (l > 0);
  half = l / 2;
  for i = 1 to half;
    if dsM.c(i) <> dsM.c(l - i + 1);
      ok = *off;
      leave;
    endif;
  endfor;
  if ok;
    dsply LEMOT;
  endif;
  read mots;
enddo;
*inlr = *on;
```
