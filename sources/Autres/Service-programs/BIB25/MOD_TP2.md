---
bibliotheque: BIB25
fichier_source: QSRVSRC
membre: MOD_TP2
type: Autres/Service-programs
longueur_enregistrement: 100
lignes: 80
modifie: 2026-11-25
---

# BIB25/QSRVSRC/MOD_TP2

```text
**free
CTL-OPT NOMAIN;

DCL-F BONBON usage(*input);
DCL-C maxresult const(10);

DCL-DS Tableaubonbon QUALIFIED;
   t_id packed(4:0);
   t_nom char(20);
   t_marque char(20);
   t_couleur char(10);
   t_prix packed(5:2);
END-DS;

DCL-DS Tableaubonbon2 QUALIFIED DIM(maxresult);
   t_id packed(4:0);
   t_nom char(20);
   t_marque char(20);
   t_couleur char(10);
   t_prix packed(5:2);
END-DS;


dcl-proc Find EXPORT;
  DCL-PI *N likeDS(Tableaubonbon);
    checkid packed(4:0);
  END-PI;


  DCL-DS Retour LIKEDS(Tableaubonbon);
  dow 1 = 1;
    if cle <> checkid;
      READ RBONBON;
      iter;
    ENDIF;
    Retour.t_id = cle;
    Retour.t_nom = nom;
    Retour.t_marque = marque;
    Retour.t_couleur = couleur;
    Retour.t_prix = prix;
    leave;
  ENDDO;
  CLOSE BONBON;
  return Retour;

END-PROC;



DCL-PROC check export;
   DCL-PI *N LIKEDS(Tableaubonbon2) DIM(maxresult);
     chk_marque char(20);
   END-PI;

   DCL-S i int(10) INZ(1);

   DCL-DS Retour LIKEDS(Tableaubonbon2) DIM(maxresult);
   OPEN BONBON;
   READ RBONBON;
   DOW not %eof;
     if chk_marque <> marque;
       i = i + 1;
       READ BONBON;
       iter;
     ENDIF;
     if i > maxresult;
       leave;
     ENDIF;
     Retour(i).t_id = cle;
     Retour(i).t_nom = nom;
     Retour(i).t_marque = marque;
     Retour(i).t_couleur = couleur;
     Retour(i).t_prix = prix;
     i = i + 1;
     READ BONBON;
   ENDDO;
   CLOSE BONBON;
   return Retour;

END-PROC;
```
