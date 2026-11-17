---
fiche: 03-rpg-par-version
titre: %LOWER et %UPPER : existence, version et PTF
type: manque
statut: verifie
source: https://www.ibm.com/docs/en/ssw_ibm_i_75/rzasd/rpgrelv7r5.htm
origine: remontee automatique par l assistant
date: 2026-11-17
---
La fonction %LOWER (et %UPPER) existe : job-i.fr la liste dans l'index des fonctions RPG (section chaines de caracteres, "Passer en minuscules", page /fonctions-rpg/lower, syntaxe non lue). IBM : "What's New in 7.5" indique que %LOWER convertit la casse d'une chaine caractere ou UCS-2 ; l'article IBM Support RPG Cafe precise qu'on peut limiter la conversion a une sous-chaine (position de depart et longueur) et que la fonction renvoie la chaine entiere ; un PTF d'execution est requis sur tout systeme qui execute un programme utilisant %LOWER, %UPPER ou %SPLIT ; introduite avec IBM i 7.4 TR4 (source secondaire : article TechChannel). A faire : lire la page job-i /fonctions-rpg/lower et la page IBM de reference pour la syntaxe exacte (ordre des operandes) avant de l'ajouter a la fiche 03.
