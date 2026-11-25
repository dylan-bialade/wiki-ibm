---
bibliotheque: BIB25
fichier_source: QILETP
membre: TPF_PRO
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 13
modifie: 2026-11-25
---

# BIB25/QILETP/TPF_PRO

```rpg
**free

DCL-PR AjoutLivre ind;
  titre char(25);
  auteur char(25);
  sortie char(10);
END-PR;

DCL-PR SupprLivre ind;
  titre char(25);
  auteur char(25);
  sortie date;
END-PR;
```
