---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: TEST_ILE1
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 24
modifie: 2026-11-25
---

# BIB25/QRPGSRC/TEST_ILE1

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

DCL-PR TESTCALL char(25);
  id packed(6:0);
END-PR;

// Logique du programme
READ FSTUDENT;
dow not %eof;
  nom_f = TESTCALL(id);
  result =  %trim(firstname) + ' a pour formation : ' + %trim(nom_f);
  DSPLY result;
  nom_f = *blanks;
  READ FSTUDENT;
ENDDO;

// Sortie du programme
*inlr = *on;
```
