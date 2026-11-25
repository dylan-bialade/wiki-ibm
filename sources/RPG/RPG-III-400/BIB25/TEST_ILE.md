---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: TEST_ILE
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 27
modifie: 2026-11-25
---

# BIB25/QRPGSRC/TEST_ILE

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**free
// Déclaration fichier STUDENT
DCL-F STUDENT usage(*input) keyed;

// Déclaration de variables
DCL-S nom_f char(25) INZ(*blanks);
DCL-S result char(50);

// Déclaration du prototype
DCL-PR TESTCALL EXTPGM('TESTCALL');
  id packed(6:0);
  nom_f char(25);
END-PR;


// Logique du programme
READ STUDENT;
dow not %eof;
  CALLP TESTCALL(id : nom_f);
  result =  %trim(firstname) + ' a pour formation : ' + %trim(nom_f);
  DSPLY result;
  nom_f = *blanks;
  READ FSTUDENT;
ENDDO;

// Sortie du programme
*inlr = *on;
```
