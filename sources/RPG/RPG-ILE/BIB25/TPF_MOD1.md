---
bibliotheque: BIB25
fichier_source: QILETP
membre: TPF_MOD1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 52
modifie: 2026-11-25
---

# BIB25/QILETP/TPF_MOD1

```rpg
**free
//-------------------------------------------------------------------//
// Module : TPF_MOD1                                                 //
// Contexte : TP Final ILE (formation)
// Bibliothèque de compilation : BIB25                            //
// 28/04/2025 - LEO2 (Léo BIB27)                                   //
// ------------------------------------------------------------------//
CTL-OPT NOMAIN copyright('(C) ORGFORM 2025.') DATFMT(*ISO);

// Ajout d'un livre du fichier TP_LIVRES
DCL-PROC AjoutLivre EXPORT;
  DCL-PI *n ind;
    titre char(25);
    auteur char(25);
    sortie char(10);
  END-PI;
  // Récupération de l'id le plus grand
  DCL-S maxid INT(10);
  exec sql
  select max(id) into :maxid from tp_livres;
  maxid += 1;
  exec sql
  insert into tp_livres ( id , titre , auteur , sortie )
  VALUES ( :maxid , :titre , :auteur , :sortie );

  // Retour au programme sur la bonne insertion dans la bdd
  if sqlcode = 0;
    return *on;
  else;
    return *off;
  ENDIF;
END-PROC;


// Suppresion d'un livre du fichier TP_LIVRES
DCL-PROC SupprLivre EXPORT;
  DCL-PI *n ind;
    titre char(25);
    auteur char(25);
    sortie char(10);
  END-PI;

  exec sql
  delete from tp_livres where titre = :titre and auteur = :auteur
  and sortie = :sortie;

  IF sqlcode = 0;
    return *ON;
  else;
    return *OFF;
  ENDIF;
END-PROC;
```
