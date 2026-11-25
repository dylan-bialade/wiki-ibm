---
bibliotheque: BIB27
fichier_source: QSQLRPGLE
membre: SQLTEST
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 45
modifie: 2026-11-25
---

# BIB27/QSQLRPGLE/SQLTEST

```rpg
**free

// déclaratives

dcl-f e_sqltest workstn;
dcl-s verif char(25);


// prog
exec SQL
SET OPTION COMMIT=*NONE;


dow *in03 = *off;
  exfmt record1;
  verif = '';
  // peux faire un count(*) qui retourne une valeur à chaque fois
  // ==> dans le code on compare verif avec 0(existe pas) ou +0(existe)
  EXEC SQL
  SELECT nom_personne INTO  :verif from tpizi4.nom WHERE nom_personne = :e_name;
  if e_name <> *blanks;
    if e_name = verif ;
      exfmt record2;
      if valid = 'YES' ;
        exec sql
        delete from tpizi4.nom where nom_personne = :e_name;
        // SQLCODE = 0 ===> ok
        // SQLCODE = 100 ==> fin de la requête
        // SQLCODE < 0 ===> erreur dans la requête
        if SQLCOD = 0;
          result = 'nom supprimé';
        ENDIF;
      ENDIF;
    else;
    exec sql
    insert into tpizi4.nom (nom_personne) values (:e_name);
    IF SQLCOD = 0;
      result = 'nom ajouté dans la table';
    ENDIF;
    endif;
  ENDIF;
ENDDO;


*inlr = *on;
```
