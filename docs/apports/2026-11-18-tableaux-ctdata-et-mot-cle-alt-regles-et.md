---
fiche: 03-rpg-par-version
titre: Tableaux CTDATA et mot-cle ALT : regles et limite non verifiee
type: manque
statut: non verifie
source: https://www.ibm.com/docs/ssw_ibm_i_74/rzasd/defrel.htm
origine: remontee automatique par l assistant
date: 2026-11-18
---
Tableaux a charger a la compilation (CTDATA) et mot-cle ALT. VERIFIE (IBM Documentation, "Defining Related Arrays", IBM i 7.4, https://www.ibm.com/docs/ssw_ibm_i_74/rzasd/defrel.htm) : on peut charger deux tableaux de compilation (ou de pre-execution) en format alterne avec le mot-cle ALT place sur la definition du tableau alterne ; le tableau principal porte CTDATA ; dans la definition du tableau alterne les mots-cles PERRCD, FROMFILE, TOFILE et CTDATA ne sont pas valides ; les donnees d'initialisation sont en ordre alterne en commencant par le tableau principal (principal, alterne, principal, alterne...). Page de chargement : https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_71/rzasd/sc092508214.htm (7.1, non lue en entier). NON VERIFIE (a controler dans la reference IBM des messages RNF) : affirmation d'un assistant qu'un tableau principal ne peut avoir qu'UN seul tableau ALT, et qu'il faut une seconde section de donnees pour deux tableaux associes, avec les messages RNF3454 et RNF8045 ; aucune source IBM ou job-i n'a confirme la limite ni ces numeros de message. Un message de forum cite RNF3442 quand ALT est utilise sans CTDATA ni FROMFILE (source non officielle). Etat du wiki : CTDATA et ALT sont utilises dans des sources (ex. exemples de tableaux dans la bibliotheque BIB05) mais ne sont expliques dans aucune fiche ; job-i.fr n'a pas de page sur CTDATA ni ALT (recherche du 2026-11-18, lecture partielle de l'index).
