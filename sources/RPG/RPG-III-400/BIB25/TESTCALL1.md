---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: TESTCALL1
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 25
modifie: 2026-11-25
---

# BIB25/QRPGSRC/TESTCALL1

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**free

CTL-OPT NOMAIN;

DCL-PROC TESTCALL export;
  DCL-PI TESTCALL char(25);
    id packed(6:0);
  END-PI;

  //Déclaration de fichiers
  DCL-F ENTRY usage(*input:*update:*output) keyed prefix(E_);

  DCL-DS resultDS EXTNAME('ENTRY': *input) prefix(E_) end-ds;

  DSPLY 'Programme TESTCALL en cours test';

  // logique du module
  CHAIN ID ENTRY resultDS;
  if %found;
    return E_cours;
  else;
    return *blanks;
  ENDIF;

end-proc;
```
