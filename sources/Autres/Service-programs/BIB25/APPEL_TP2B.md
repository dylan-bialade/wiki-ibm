---
bibliotheque: BIB25
fichier_source: QSRVSRC
membre: APPEL_TP2B
type: Autres/Service-programs
longueur_enregistrement: 100
lignes: 34
modifie: 2026-11-25
---

# BIB25/QSRVSRC/APPEL_TP2B

```text
**FREE
DCL-S id packed(4:0) INZ(4);
DCL-C maxresult const(10);
/COPY BIB25/QSRVSRC,SIGN_SRVTP

/COPY BIB25/QSRVSRC,SIGN_SRV2


DCL-DS TableauFinal QUALIFIED;
   t_id packed(4:0);
   t_nom char(20);
   t_marque char(20);
   t_couleur char(10);
   t_prix packed(5:2);
END-DS;

DCL-DS TableauFinal2 QUALIFIED DIM(maxresult);
   t_id packed(4:0);
   t_nom char(20);
   t_marque char(20);
   t_couleur char(10);
   t_prix packed(5:2);
END-DS;

TableauFinal = Find(id);

dsply TableauFinal.t_nom;


TableauFinal2 = check(TableauFinal.t_marque);

dsply TableauFinal2(1).t_nom;

*INLR = *ON;
```
