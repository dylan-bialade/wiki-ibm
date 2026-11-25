---
bibliotheque: BIB25
fichier_source: QSRVSRC
membre: APPEL_TP2
type: Autres/Service-programs
longueur_enregistrement: 100
lignes: 20
modifie: 2026-11-25
---

# BIB25/QSRVSRC/APPEL_TP2

```text
**FREE
/COPY BIB25/QSRVSRC,SIGN_SRVTP

DCL-S id packed(4:0) INZ(4);

DCL-DS TableauFinal QUALIFIED;
   t_id packed(4:0);
   t_nom char(20);
   t_marque char(20);
   t_couleur char(10);
   t_prix packed(5:2);
END-DS;

TableauFinal = Find(id);

dsply TableauFinal.t_nom;



*INLR = *ON;
```
