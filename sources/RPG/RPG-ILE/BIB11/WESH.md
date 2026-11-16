---
bibliotheque: BIB11
fichier_source: QRPGLESRC
membre: WESH
type: RPG/RPG-ILE
longueur_enregistrement: 114
lignes: 99
modifie: 2026-11-16
---

# BIB11/QRPGLESRC/WESH

```rpg
**free

// EXERCICE - Mise en forme d'un texte : "Wesh alors"

// Objectif : afficher dans la joblog le poème "Wesh alors" de Jul.

// Victor Hugo a écrit "Demain dès l'aube", Jul a écrit "Wesh alors" :

// chacun son siècle, chacun son génie. Les spécialistes sont formels,

// Jul est le plus grand poète du XXIe siècle (les spécialistes, c'est nous).

// Texte inédit "à la manière de" : la maison de disques n'a pas encore appelé.

// Contexte :

// La table TEAMLIB/MEFTXTF00 contient le texte du poème sur une seule ligne

// 1 colonne : texte à mettre en forme (TEXTE_BRUT)

// Les règles de mise en forme sont les suivantes :

// - 2 espaces consécutifs : saut de strophe, à matérialiser par la chaîne '--------------------'

// - Majuscule : passage à la ligne suivante si la majuscule est précédée d'un point + espace ('. ') ou d'une virg
ule + espace (', ')
// - Corriger la faute de frappe : ! = 'V' (même Jul a des doigts)

// À vous de jouer:

// 1. Ne pas modifier les lignes déjà présentes, ajouter vos lignes de code à la suite

// 2. Utiliser uniquement des instructions RPG natives (pas de SQL, pas d'appels d'API...)

// 3. Le programme doit s'appeler WESH dans votre bibliothèque

// Critères d'évaluation :

// 1. Le résultat doit être exactement celui demandé (Jul ne tolère pas l'à-peu-près)

// 2. Le code présent ne doit pas être modifié

// 3. Le code doit être le plus simple, le plus lisible et le plus optimisé possible

ctl-opt dftactgrp(*no) actgrp(*new);



dcl-f meftxtf00 disk usage(*input);

dcl-c maj 'ABCDEFGHIJKLMNOPKRSTUVWXYZ';

dcl-s strophe char(2000);



dcl-s ligne char(240);



dcl-s i packed(4:0) inz(1);

dcl-s iold packed(4:0)inz(1);



*inlr=*on;

read meftxtf00;



// gestion des saut de stroph

strophe = %scanrpl('  ':'--------------------':TEXTE_BRUT);

strophe = %scanrpl('!':'V':strophe);



dou i > %len(strophe)-2;

    i+=1;

    if %subst(strophe:i:2)='. ' or %subst(strophe:i:2)=', ';

        if  %check(maj:%subst(strophe:i+2:1)) = 0;

            ligne = %subst(strophe:iold:i-iold+1);

            snd-msg ligne;

            iold = i+1;

        endif;

    endif;

enddo;
```
