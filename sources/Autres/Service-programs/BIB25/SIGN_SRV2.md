---
bibliotheque: BIB25
fichier_source: QSRVSRC
membre: SIGN_SRV2
type: Autres/Service-programs
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-25
---

# BIB25/QSRVSRC/SIGN_SRV2

```text
**free
DCL-DS Tableaubonbon2 QUALIFIED DIM(maxresult);
   t_id packed(4:0);
   t_nom char(20);
   t_marque char(20);
   t_couleur char(10);
   t_prix packed(5:2);
END-DS;


DCL-PR check LIKEDS(Tableaubonbon);
  chk_marque char(20);
END-PR;
```
