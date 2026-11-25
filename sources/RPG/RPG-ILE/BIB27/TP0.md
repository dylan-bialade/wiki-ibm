---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: TP0
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 21
modifie: 2026-11-25
---

# BIB27/QFREESRC/TP0

```rpg
**free
// déclaration fichier/ecran

dcl-f e_tp0 workstn;

// déclaration de variables
dcl-s temp int(3);

// traitement
exfmt record1;
temp = nbrA;
nbrA = nbrB;
nbrB = temp;
exfmt record1;


// affichage des variables
// dsply ('variable 1:' +  %char(var1));

// sortie du prog
*inlr = *on;
```
