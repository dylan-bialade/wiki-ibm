---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: EXMODPGM
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 32
modifie: 2026-11-25
---

# BIB25/QRPGSRC/EXMODPGM

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**free


dcl-s nbr1 packed(6:0) INZ(484);
dcl-s nbr2 packed(6:0) INZ(-200);
dcl-s nbr3 packed(6:0) INZ(215);
dcl-s nbr4 packed(6:0) INZ(-487);

dcl-s result1 packed(7:2);
dcl-s result2 packed(7:2);

dcl-s compteur int(10);

DCL-PR addition packed(7:2);
  nbr1 packed(6:0);
  nbr2 packed(6:0);
END-PR;

DCL-PR returnC INT(10);
END-PR;

result1 = addition(nbr1:nbr2);
DSPLY ('Le résultats n°1 est ' + %char(result1));

result2 = addition(nbr3:nbr4);
DSPLY ('Le résultats n°2 est ' + %char(result2));

compteur = returnC();
DSPLY ('Utilisation du module addition: '  + %char(compteur));


*INLR = *ON;
```
