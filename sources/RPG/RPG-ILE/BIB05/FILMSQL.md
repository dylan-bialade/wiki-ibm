---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: FILMSQL
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 36
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/FILMSQL

```rpg
**FREE
ctl-opt copyright('(C) ARMONIE 2025.') option(*srcstmt) dftactgrp(*no)
        actgrp(*caller) datfmt(*iso) timfmt(*iso);

//**********************************************************************//
// Déclaration des variables                                            //
//**********************************************************************//
dcl-s TitreFilm char(50);

//**********************************************************************//
// Traitement principal                                                 //
//**********************************************************************//
exec sql
    set option commit = *none, datfmt = *iso,
                timfmt = *iso, alwcpydta = *optimize, closqlcsr = *endmod;

// Déclaration du curseur
exec sql declare C1 cursor for
    select TITREFILM from FILMS;

// Ouverture du curseur
exec sql open C1;

// Premier fetch
exec sql fetch C1 into :TitreFilm;

// Boucle de lecture
dow sqlcod = 0;
   dsply TitreFilm;
   exec sql fetch C1 into :TitreFilm;
enddo;

// Fermeture du curseur
exec sql close C1;

*inlr = *on;
```
