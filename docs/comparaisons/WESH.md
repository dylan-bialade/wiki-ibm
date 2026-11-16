# WESH : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB04 | QRPGLESRC | RPG/RPG-ILE | 167 | 100 % | full free, SETLL / READ, boucle DOW/DOU/FOR, procedures (dcl-proc), prototypes (dcl-pr) | [WESH.md](../../sources/RPG/RPG-ILE/BIB04/WESH.md) |
| BIB11 | QRPGLESRC | RPG/RPG-ILE | 94 | 4 % | full free, SETLL / READ, boucle DOW/DOU/FOR | [WESH.md](../../sources/RPG/RPG-ILE/BIB11/WESH.md) |

## Differences

- Techniques communes : full free, SETLL / READ, boucle DOW/DOU/FOR
- **BIB04** en propre : procedures (dcl-proc), prototypes (dcl-pr)

## Codes

### BIB04 (RPG/RPG-ILE, 167 lignes)

_Long : voir [WESH.md](../../sources/RPG/RPG-ILE/BIB04/WESH.md)._

### BIB11 (RPG/RPG-ILE, 94 lignes)

```text
**free
                                                                                                            // EXERCICE
- Mise en forme d'un texte : "Wesh alors"
                                                                                                // Objectif : afficher d
ans la joblog le poème "Wesh alors" de Jul.
                                                                                    // Victor Hugo a écrit "Demain dès l
'aube", Jul a écrit "Wesh alors" :
                                                                        // chacun son siècle, chacun son génie. Les spéc
ialistes sont formels,
                                                            // Jul est le plus grand poète du XXIe siècle (les spécialis
tes, c'est nous).
                                                // Texte inédit "à la manière de" : la maison de disques n'a pas encore
appelé.
                                    // Contexte :

                        // La table TEAMLIB/MEFTXTF00 contient le texte du poème sur une seule ligne

            // 1 colonne : texte à mettre en forme (TEXTE_BRUT)

// Les règles de mise en forme sont les suivantes :
                                                                                                            // - 2 espac
es consécutifs : saut de strophe, à matérialiser par la chaîne '--------------------'
                                                                                                // - Majuscule : passage
 à la ligne suivante si la majuscule est précédée d'un point + espace ('. ') ou d'une virgule + espace (', ')
                                                                                    // - Corriger la faute de frappe : !
 = 'V' (même Jul a des doigts)
                                                                        // À vous de jouer:

                                                            // 1. Ne pas modifier les lignes déjà présentes, ajouter vos
 lignes de code à la suite
                                                // 2. Utiliser uniquement des instructions RPG natives (pas de SQL, pas
d'appels d'API...)
                                    // 3. Le programme doit s'appeler WESH dans votre bibliothèque

                        // Critères d'évaluation :

            // 1. Le résultat doit être exactement celui demandé (Jul ne tolère pas l'à-peu-près)

// 2. Le code présent ne doit pas être modifié
                                                                                                            // 3. Le cod
e doit être le plus simple, le plus lisible et le plus optimisé possible
                                                                                                ctl-opt dftactgrp(*no) a
ctgrp(*new);

                                                                        dcl-f meftxtf00 disk usage(*input);

                                                            dcl-c maj 'ABCDEFGHIJKLMNOPKRSTUVWXYZ';

                                                dcl-s strophe char(2000);

                        dcl-s ligne char(240);

dcl-s i packed(4:0) inz(1);
                                                                                                            dcl-s iold p
acked(4:0)inz(1);

                                                                                    *inlr=*on;

                                                                        read meftxtf00;

                                                // gestion des saut de stroph

                                    strophe = %scanrpl('  ':'--------------------':TEXTE_BRUT);

                        strophe = %scanrpl('!':'V':strophe);

dou i > %len(strophe)-2;
                                                                                                                i+=1;

                                                                                                    if %subst(strophe:i:
2)='. ' or %subst(strophe:i:2)=', ';
                                                                                            if  %check(maj:%subst(stroph
e:i+2:1)) = 0;
                                                                                    ligne = %subst(strophe:iold:i-iold+1
);
                                                                        snd-msg ligne;

                                                            iold = i+1;

                                            endif;

                            endif;

            enddo;
```
