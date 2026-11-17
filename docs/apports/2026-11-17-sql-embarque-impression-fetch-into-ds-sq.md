---
fiche: 07-sql-embarque-en-rpg
titre: SQL embarque + impression : FETCH INTO DS, SQLCODE, OFLIND
type: manque
statut: non verifie
source: forums et references non IBM (code400, Actian) : non officiel
origine: remontee automatique par l assistant
date: 2026-11-17
---
Constats d'un assistant qui a relu un programme SQL embarque avec impression, a verifier avant integration. (1) FETCH INTO d'une structure hote : non documente dans le wiki ; une reference non IBM (Actian) dit que la structure est expansee en ses membres dans l'ordre de declaration ; a verifier dans la documentation IBM SQL embarque RPG. (2) SQLCODE : 100 = fin de donnees (SQLSTATE 02000) selon des references non IBM ; -501 / SQLSTATE 24501 = curseur non ouvert (forum code400) ; a verifier dans la reference des messages SQL IBM. (3) CLOSE avant OPEN : comportement non documente. (4) OFLIND(*INOF) en full free : tester l'indicateur puis reecrire un titre ne saute PAS de page (le programme doit finir la page lui-meme : lignes blanches jusqu'a la ligne 66 ou DDS avec SKIPB, voir CYCLEQSYS valide) ; un exemple minimal avec SQL (curseur + rupture + total + debordement) manque. (5) Procedure sans MAIN utilisant variables globales, sqlcode et *inof : non documente. (6) DCL-DS LEN(n) sans sous-zone : non documente. (7) OFLIND et OVERFLOW absents de la liste MANQUES.md alors qu'utilises dans le code.
