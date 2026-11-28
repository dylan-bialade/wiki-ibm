---
fiche: 03-rpg-par-version
titre: IWS : cours PDF (service program, wrapping, pieges PCML)
type: manque
statut: non verifie
source: docs/ILE-ET-SERVICES-WEB.md
integre: oui
origine: remontee automatique par l assistant
date: 2026-11-24
---
Document de formation IWS fourni par l'utilisateur (PDF de 4 pages, auteur non identifie, bibliotheque d'exemple generique FORMLIB). Synthese, non verifiee sur ibm.com ni job-i.fr (recherche job-i.fr sur RNF0320 : page 404 ; ZUI_54441, QZRCSRVS, STRPGMEXP : pas de fiche directe).
1) Chaine de construction d'un service REST en RPG : source NOMAIN avec ctl-opt pgminfo(*pcml:*module:*dclcase:*v7) ; module par CRTSQLRPGI OBJTYPE(*MODULE) (ou CRTRPGMOD sans SQL) ; source de liage STRPGMEXP/EXPORT SYMBOL/ENDPGMEXP (ajouter les nouvelles procedures a la fin) ; CRTSRVPGM ... EXPORT(*SRCFILE) ACTGRP(*CALLER) ; GRTOBJAUT a QWSERVICE (*EXECUTE sur la bibliotheque, *USE sur le *SRVPGM et les fichiers) ; controle par DSPSRVPGM DETAIL(*PROCEXP) et DSPMOD DETAIL(*EXPORT) ; listWebServices.sh -server <serveur>.
2) Convention de parametres : id en const (entree, parametre de chemin {id}) ; http_code int(10) (code retour HTTP) ; http_text char(64) (corps en erreur) ; un seul parametre de corps JSON (client char(4096)). Un parametre non const est vu en entree-sortie par le PCML.
3) Assistant Deploy New Service (HTTPAdmin port 2001) : type REST, objet /QSYS.LIB/<BIB>.LIB/<SRVPGM>.SRVPGM, nom de ressource, procedures exportees, verbe HTTP, modele d'URI, Consumes/Produces application/json, origine des entrees (chemin, requete, en-tete, formulaire, corps JSON), HTTP response code output parameter = http_code, HTTP error response output parameter = http_text, profil d'execution, liste de bibliotheques (position *LAST par defaut).
4) Wrap output parameter : decoche = le corps est le JSON du RPG ; coche = JSON du RPG encapsule en chaine echappee dans un objet (a decoder deux fois). Erreur ZUI_54441 (plus d'une sortie sans wrapping) : designer http_code et http_text comme parametres de code retour et d'erreur.
5) Pieges PCML : int(3)/uns(3) sans equivalent PCML -> RNF0320 (gravite 30), module non cree ; pointeur refuse ; int(5/10/20), uns, packed, zoned, char, likeds OK ; tableau dim(n) OK avec compteur. Produces laisse en XML+JSON -> reponse XML. Toujours 200 -> pas de parametre de code retour designe. Jobs QZRCSRVS reutilises (sous-systeme QUSRWRK) -> reinitialiser toutes les sorties en debut de procedure. 500 + CPF9801/SQL0204 : liste de bibliotheques ; 500 + CPF9802/SQL0551 : droits du profil. JSON tronque : parametre de corps trop court. Apres recompilation sans changement de parametres : pas de redeploiement mais arret/redemarrage du service ; si un parametre change : redeployer.
6) Ou regarder : job log du job QZRCSRVS, messages.log du serveur IWS, STRSRVJOB + STRDBG.
Recoupe ILE-ET-SERVICES-WEB.md (PGMINFO, QWSERVICE verifies) ; apporte en plus : *V7, RNF0320, ZUI_54441, QZRCSRVS, wrapping, source de liage. Confirme le point 'wrapping' que le wiki marquait non confirme (comportement JSON brut ou echappe).
