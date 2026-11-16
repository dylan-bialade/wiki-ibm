---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: TESTTPSYL
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 75
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/TESTTPSYL

```rpg
**free
// EXERCICE - Mise en forme d'un texte : "Wesh alors"
// Objectif : afficher dans la joblog le poeme "Wesh alors" de Jul.
//  Victor Hugo a écrit "Demain des l'aube", Jul a écrit "Wesh alors" :
//  3
// Exercice RPG
// Mise en forme d'un texte : « Wesh alors »
//  chacun son siecle, chacun son génie. Les spécialistes sont formels,
//  Jul est le plus grand poete du XXIe siecle (les spécialistes, c'est nous).
//  Texte inédit "à la maniere de" : la maison de disques n'a pas encore appelé.
// Contexte :
//  La table TEAMLIB/MEFTXTF00 contient le texte du poeme sur une seule ligne
//
// 1 colonne : texte à mettre en forme (TEXTE_BRUT)
//  Les regles de mise en forme sont les suivantes :
//   - 2 espaces consécutifs : saut de strophe, à matérialiser par la chaîne '--------------------'
//  Majuscule : passage à la ligne suivante si la majuscule est précédée d'un point + espace
//  ('. ') ou d'une virgule + espace (', ')
//   - Corriger la faute de frappe : ! = 'V' (même Jul a des doigts)
// À vous de jouer :
//  1. Ne pas modifier les lignes déjà présentes, ajouter vos lignes de code à la suite
//  2. Utiliser uniquement des instructions RPG natives (pas de SQL, pas d'appels d'API...)
//  3. Le programme doit s'appeler WESH dans votre bibliotheque
// Criteres d'évaluation :
//  1. Le résultat doit être exactement celui demandé (Jul ne tolere pas l'à-peu-pres)
//  2. Le code présent ne doit pas être modifié
//  3. Le code doit être le plus simple, le plus lisible et le plus optimisé possible
ctl-opt dftactgrp(*no);
dcl-f wesh disk extdesc('TEAMLIB/MEFTXTF00') extfile(*extdesc) ;

dcl-c TIRET '--------------------';

dcl-s texte varchar(1000);
dcl-s ligne varchar(1000);
dcl-s car char(1);
dcl-s suivant char(1);
dcl-s i int(10);

read wesh;
dow not %eof(wesh);
    texte = %scanrpl('!' : 'V' : %trimr(TEXTE_BRUT));
    ligne = '';

    for i = 1 to %len(texte);
        car = %subst(texte : i : 1);

        if car = ' ' and i < %len(texte);
            suivant = %subst(texte : i + 1 : 1);

            // 2 espaces consecutifs : fin de strophe
            if suivant = ' ';
                snd-msg ligne;
                snd-msg TIRET;
                ligne = '';
                i += 1;
                iter;
            endif;

            // '. ' ou ', ' suivi d'une majuscule : nouvelle ligne
            if i > 1 and %scan(%subst(texte : i - 1 : 1) : '.,') > 0
               and %lower(suivant) <> suivant;
                snd-msg ligne;
                ligne = '';
                iter;
            endif;
        endif;

        ligne += car;
    endfor;

    snd-msg ligne;
    read wesh;
enddo;

*inlr = *on;
```
