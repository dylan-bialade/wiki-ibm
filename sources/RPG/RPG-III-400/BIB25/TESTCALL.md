---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: TESTCALL
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 22
modifie: 2026-11-25
---

# BIB25/QRPGSRC/TESTCALL

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**free
//Déclaration de fichiers
DCL-F ENTRY usage(*input) keyed;

// Réception des paramètre
DCL-PI *N;
  id packed(6:0);
  nom_f char(25);
END-PI;

DSPLY 'Programme TESTCALL en cours';
DSPLY 'en cours ...';
DSPLY 'en cours encore ...';

// logique du programme
CHAIN ID FENTRY;
if %found;
  nom_f =  cours;
ENDIF;

// sortie du programme
*inlr = *on;
```
