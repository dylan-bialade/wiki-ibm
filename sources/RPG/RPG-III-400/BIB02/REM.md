---
bibliotheque: BIB02
fichier_source: QRPGSRC
membre: REM
type: RPG/RPG-III-400
longueur_enregistrement: 100
lignes: 19
modifie: 2026-11-16
---

# BIB02/QRPGSRC/REM

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**FREE
ctl-opt dftactgrp(*no) actgrp(*new) option(*srcstmt);

dcl-s year int(10);
dcl-s isLeapYear ind;

// Demander à l'utilisateur d'entrer une année
dsply ('Entrez une année : ') ' ' year;

// Utiliser %rem pour la logique des années bissextiles
if (%rem(year : 4) = 0 and %rem(year : 100) <> 0) or (%rem(year : 400) = 0);
    isLeapYear = *on;
    dsply ('L''année est bissextile.');
else;
    isLeapYear = *off;
    dsply ('L''année n''est pas bissextile.');
endif;

*inlr = *on;
```
