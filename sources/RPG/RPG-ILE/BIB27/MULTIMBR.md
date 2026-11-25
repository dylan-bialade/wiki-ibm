---
bibliotheque: BIB27
fichier_source: QRPGLESRC
membre: MULTIMBR
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 46
modifie: 2026-11-25
---

# BIB27/QRPGLESRC/MULTIMBR

```rpg
**free
CTL-OPT COPYRIGHT('(C) ORGFORM 2024.')
OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*NONE)
ACTGRP(*CALLER)  DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
STGMDL(*INHERIT) THREAD(*SERIALIZE);


//*****************************************************************
// Programme : MULTIMBR
// Projet    : Manipulation de fichier multi membres
// Date      : 09/07/2024
// Copyright : ORGFORM - par Léo BIB27
//*****************************************************************


//*****************************************************************
// Fichier : TEST
// Bibliothèque : BIB27
// Membres : TEST | MBR2 | MBR3
// zones : KM , CV , VALEUR
//*****************************************************************

// Déclaration de fichiers

DCL-F TEST RENAME(CAR_FR : TEST1) keyed USAGE(*input) EXTMBR('*ALL');





// Traitement principal
setll *loval test;
READ test;
dow not %eof;
  dsply %char(cv);
  READ test;
ENDDO;






// Sortie du programme

*INLR = *ON;
```
