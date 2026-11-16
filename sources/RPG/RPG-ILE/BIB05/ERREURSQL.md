---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: ERREURSQL
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 34
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/ERREURSQL

```rpg
**free

CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO)
ACTGRP(*CALLER) DATFMT(*ISO) ALLOC(*STGMDL)
STGMDL(*INHERIT) THREAD(*SERIALIZE);

// La variable pour le message d'erreur
dcl-s message varchar(30);
// Une varaiable pour garder le SQLCOD de l'erreur
dcl-s sqlcold varchar(10);

// Une variable pour concaténer message et sqlcode
dcl-s msgERR varchar(50);


// Traitement principal

// Juste une requête fausse pour essayer
exec sql
insert into rien values ('rien');

// Récupération du SQLCOD
sqlcold = %char(sqlcode);

// On précise dans quelle variable on récupère l'erreur SQL
Exec SQL GET DIAGNOSTICS CONDITION 1
:message = MESSAGE_TEXT ;

// On envoie le message d'erreur.
// Je l'ai construit avec le SQLCODE et le message d'erreur SQL
msgERR = 'SQLCODE ' + SQLCOLD + ' : ' + %char(message) ;
dsply msgERR;

*inlr = *on;
```
