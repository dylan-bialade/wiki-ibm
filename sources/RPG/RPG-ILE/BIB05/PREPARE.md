---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: PREPARE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 72
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/PREPARE

```rpg
**FREE
ctl-opt copyright('(C) ARMONIE 2025.') option(*srcstmt) dftactgrp(*no)
        actgrp(*caller) datfmt(*iso) timfmt(*iso);

//*********************************************************
// Déclarations des variables                             *
//*********************************************************
dcl-s stmt    varchar(100);
dcl-s empnum  zoned(5:0);
dcl-s nom     char(20);
dcl-s prenom  char(20);

EXEC SQL
 SET option commit = *NONE , Datfmt = *iso,
 timfmt =*iso, ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD;

//*********************************************************
// Préparation de la requête dynamique SQL                *
// '?' représente un paramètre qui sera fourni au moment  *
// de l'exécution avec USING                               *
//*********************************************************
stmt = 'SELECT NOMCLI, PRECLI FROM CLIENT WHERE NUMCLI = ?';

exec sql
  prepare S1 from :stmt;

//*********************************************************
// Déclaration du curseur basé sur la requête préparée     *
//*********************************************************
exec sql
  declare C1 cursor for S1;

//*********************************************************
// Affectation d'une valeur au paramètre NUMCLI           *
//*********************************************************
empnum = 2;

//*********************************************************
// Ouverture du curseur avec passage du paramètre à USING *
//*********************************************************
exec sql
  open C1 using :empnum;

//*********************************************************
// Boucle de lecture des résultats                        *
// Note : FETCH doit être appelé avant d'entrer dans la   *
// boucle si on ne veut pas tester SQLCODE à l'intérieur. *
// Ici, on utilise DOW avec test direct dans la boucle.   *
//*********************************************************
dow sqlcode = 0;

  // Récupération d'une ligne
  exec sql
    fetch C1 into :nom, :prenom;

  // Si fin de données, on quitte la boucle
  if sqlcode <> 0;
    leave;
  endif;

  // Affichage du résultat
  dsply nom   ' '   prenom;

enddo;

//*********************************************************
// Fermeture propre du curseur                            *
//*********************************************************
exec sql
  close C1;

*inlr = *on;
```
