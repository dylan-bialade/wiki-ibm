---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: ILE_SRV
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 38
modifie: 2026-11-25
---

# BIB25/QRPGSRC/ILE_SRV

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**free
// Exemple ILE avec un programme de service

// Déclaration de variables
DCL-S add_result packed(6:0);
DCL-S mult_result packed(6:0);

// Réception des paramètres
DCL-Pi *N;
  num1 packed(4:0);
  num2 packed(4:0);
  num3 packed(4:0);
  num4 packed(4:0);
END-PI;

// Déclaration des Prototypes
DCL-PR Addition packed(6:0);
  nbr1 packed(4:0);
  nbr2 packed(4:0);
END-PR;

DCL-PR Multiplication packed(6:0);
  nbr1 packed(4:0);
  nbr2 packed(4:0);
END-PR;

// Logique du programme
IF num1 <> *zero and num2 <> *zero;
  add_result = Addition(num1:num2);
  DSPLY %dec(add_result);
ENDIF;

IF num3 <> *zero and num4 <> *zero;
  mult_result = Multiplication(num3:num4);
  DSPLY %dec(mult_result);
ENDIF;

*INLR = *ON;
```
