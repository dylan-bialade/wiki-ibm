---
bibliotheque: BIB27
fichier_source: QSQLRPGLE
membre: TPSOLDAT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 103
modifie: 2026-11-25
---

# BIB27/QSQLRPGLE/TPSOLDAT

```rpg
**free

//-----------------------------------------------------------------------------
// déclaratives
//-----------------------------------------------------------------------------

ctl-opt alwnull(*usrctl);
dcl-f e_tpsoldat workstn;



//-----------------------------------------------------------------------------
// prog
//-----------------------------------------------------------------------------

exec SQL
SET OPTION COMMIT=*NONE;


dow not *in03;

  clear e1_id;
  exfmt fmt1;
  clear e1_erreur;

  if *in12 = *on;
    iter;
  ENDIF;

  //---------------------------------
  // ajout                          |
  // --------------------------------
  if *in06 = *on;
    exfmt fmt4;
    if *in23 = *on;
      exec sql
      insert into soldat ( nom_sld , prenom_sld , arme_sld , arme2_sld , classe_sld )
      values ( :e4_nom , :e4_prenom , :e4_arme , :e4_arme2 , :e2_classe );

      if sqlcod = -545;
        e4_erreur = 'veuillez renseignez la bonne classe';
      endif;
    endif;
  ENDIF;

  //---------------------------------
  // affichage                      |
  // --------------------------------
  exec sql
  select id_sld, nom_sld , prenom_sld , arme_sld , ifnull(arme2_sld , ' ') , classe_sld
  into :e2_id , :e2_nom , :e2_prenom , :e2_arme , :e2_arme2 , :e2_classe
  from soldat where id_sld = :e1_id ;

  if sqlcod = 0;

      exfmt fmt2;
      if *in07 = *on;
        exec sql
        delete from soldat where id_sld = :e2_id;
      ENDIF;
          //------------------------------------
          // modification                      |
          //------------------------------------
      if *in02 = *on;
        dow 1=1;
          if *in03 = *on or *in12 = *on;
            leave;
          ENDIF;
          *in23 = *off;
          exfmt fmt3;
          if *in23 = *on;
            exec sql
            update soldat
            set nom_sld=:e2_nom , prenom_sld = :e2_prenom , arme_sld = :e2_arme,
            arme2_sld = :e2_arme2 , classe_sld = :e2_classe where id_sld = :e2_id;

            if sqlcod = -545;
              e3_erreur = 'veuillez choisir la bonne classe';
            elseif sqlcod = 0;
              clear e3_erreur;
              leave;
            ENDIF;
          ENDIF;
        enddo;
      ENDIF;

  elseif sqlcod = 100;
    e1_erreur = 'Ce soldat n''existe pas ';
  ENDIF;

  if e1_id = 0;
    e1_erreur = 'Veuilez rentrer l''id d''un soldat';
  ENDIF;

ENDDO;



//----------------------------------------------------------------------------
// sortie du prog
//----------------------------------------------------------------------------

*inlr = *on;
```
