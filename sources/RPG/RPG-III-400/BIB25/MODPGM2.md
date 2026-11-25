---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: MODPGM2
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 12
modifie: 2026-11-25
---

# BIB25/QRPGSRC/MODPGM2

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```rpg
**free
// Insertion des prototypes
/COPY BIB25/QRPGSRC,PROTOTYPES
// Déclaration variables
DCL-S date_n date INZ(d'1995-12-28');
DCL-S result_age packed(3:0);
// Appel des procédures
result_age = CALCUL_AGE(date_n);
// Affichage du résultat
DSPLY %char(result_age);
// Sortie du programme
*inlr = *on;
```
