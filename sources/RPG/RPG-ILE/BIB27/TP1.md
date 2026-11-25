---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: TP1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 25
modifie: 2026-11-25
---

# BIB27/QFREESRC/TP1

```rpg
**free

// déclaration ecran
dcl-f e_tp1 workstn;

// programmation

dow *in03 = *off;
  exfmt record1;
  select;
  when *in08 = *on;
    result = nbr1 * nbr2;
  when *in07 = *on;
    result = nbr1 - nbr2;
  when *in05 = *on;
    nbr1 = 0;
    nbr2 = 0;
    result = 0;
  // clear record1;
  other;
    result = nbr1 + nbr2 ;
  ENDSL;
ENDDO;

*inlr = *on;
```
