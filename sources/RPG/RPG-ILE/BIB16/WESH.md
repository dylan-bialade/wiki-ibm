---
bibliotheque: BIB16
fichier_source: QRPGLESRC
membre: WESH
type: RPG/RPG-ILE
longueur_enregistrement: 114
lignes: 155
modifie: 2026-11-16
---

# BIB16/QRPGLESRC/WESH

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

// À vous de jouer :

// 1. Ne pas modifier les lignes déjà présentes, ajouter vos lignes de code à la suite

// 2. Utiliser uniquement des instructions RPG natives (pas de SQL, pas d'appels d'API...)

// 3. Le programme doit s'appeler WESH dans votre bibliothèque

// Critères d'évaluation :

// 1. Le résultat doit être exactement celui demandé (Jul ne tolère pas l'à-peu-près)

// 2. Le code présent ne doit pas être modifié

// 3. Le code doit être le plus simple, le plus lisible et le plus optimisé possible

ctl-opt dftactgrp(*no);



// Fichier d'entrée

dcl-f MEFTXTF00 extdesc('TEAMLIB/MEFTXTF00') extfile('TEAMLIB/MEFTXTF00');



dcl-c MAJUSCULES 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

dcl-c STROPHE    '--------------------';



dcl-s texttab   char(1) dim(1000);

dcl-s tablength int(10);

dcl-s vers      varchar(1000);

dcl-s c         char(1);

dcl-s i         int(10);



read MEFTXTR;

tablength = %len(texte_brut);



// Copie du texte dans le tableau, avec correction de la faute de frappe

for i = 1 to tablength;

    c = %subst(texte_brut : i : 1);

    if c = '!';

        c = 'V';

    endif;

    texttab(i) = c;

endfor;



// Mise en forme

for i = 1 to tablength;

    c = texttab(i);



    // Deux espaces consécutifs : fin de strophe

    if i < tablength and c = ' ' and texttab(i + 1) = ' ';

        snd-msg %trimr(vers);

        snd-msg STROPHE;

        vers = '';

        i += 1;



    // Majuscule précédée de '. ' ou ', ' : nouveau vers

    elseif i > 2 and %scan(c : MAJUSCULES) > 0

                 and (texttab(i - 2) = '.' or texttab(i - 2) = ',')

                 and texttab(i - 1) = ' ';

        snd-msg %trimr(vers);

        vers = c;



    // Sinon : le caractère s'ajoute au vers en cours

    else;

        vers += c;

    endif;

endfor;



// Le dernier vers

snd-msg %trimr(vers);



*inlr = *on;
```
