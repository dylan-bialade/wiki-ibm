---
bibliotheque: BIB25
fichier_source: QDDSSRC
membre: LVLF_PGM
type: DDS
longueur_enregistrement: 80
lignes: 14
modifie: 2026-11-25
---

# BIB25/QDDSSRC/LVLF_PGM

```text
**free
// Déclaration fichiers PAYS en lecture
dcl-f PAYS keyed usage(*input);

// Affichage des noms des pays
// Lecture du fichier séquentiellement
read FPAYS;
dow not %eof;
  dsply nom; // Affichage du nom du PAYS
  read FPAYS;
ENDDO;

// sortie du programme
*inlr = *on;
```
