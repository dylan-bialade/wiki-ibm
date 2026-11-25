---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: EXO4
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 19
modifie: 2026-11-25
---

# BIB27/QFREESRC/EXO4

```rpg
**free

// declaration

dcl-f LF_EXO4 usage(*update) keyed;
dcl-s i packed(3:0);

 // prog
setll *loval nomf;

READ NOMF;
dow not %eof;
  dsply NOM_P00001;
  read NOMF;
ENDDO;



*inlr = *on;
```
