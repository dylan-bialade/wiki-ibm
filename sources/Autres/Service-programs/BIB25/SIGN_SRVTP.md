---
bibliotheque: BIB25
fichier_source: QSRVSRC
membre: SIGN_SRVTP
type: Autres/Service-programs
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-25
---

# BIB25/QSRVSRC/SIGN_SRVTP

```text
**free

DCL-DS Tableaubonbon QUALIFIED;
   t_id packed(4:0);
   t_nom char(20);
   t_marque char(20);
   t_couleur char(10);
   t_prix packed(5:2);
END-DS;

DCL-PR Find LIKEDS(Tableaubonbon);
  checkid packed(4:0);
END-PR;
```
