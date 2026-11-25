---
bibliotheque: BIB27
fichier_source: QSQLRPGLE
membre: TPJEUX
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 154
modifie: 2026-11-25
---

# BIB27/QSQLRPGLE/TPJEUX

```rpg
**free
//-------------------------------------------------------------------------------------------
// déclaratives
//-------------------------------------------------------------------------------------------

dcl-f e_tpjeux workstn;
dcl-s code packed(5:0);
dcl-s code1 packed(5:0);



// -------------------------------------------------------------------------------------------
// prog
// *in70 = jeu non trouvé dans la table
// *in71 = gestion des blanks
// *in60 = zone protégé (idjeu)
// *in72 = update réussi
// *in73 = update pas réussi
// *in81 = gestion affichage f2 (fmt2)
// *in82 = gestion affichage f8 (fmt2)
// *in83 = gestion affichage ID (fmt2)
// -------------------------------------------------------------------------------------------

exec SQL
SET OPTION COMMIT=*NONE;


dow *in03 = *off;
  *in60 = *on;
  *in83 = *on;
  clear e1_nom;
  EXFMT FMT1;
  *in70 = *off;
  *in71 = *off;
  *in72 = *off;
  *in73 = *off;
  *in82 = *off;
  *in81 = *off;

// ---------------------------------------------------------------------------------------
// Création
// ---------------------------------------------------------------------------------------
  if *in06 = *on;
    clear fmt2;
    *in81 = *on;
    *in83 = *on;
    *in84 = *on;
    exfmt fmt2;
    if *in08 = *on;
      exfmt fmt4;
      if valid1 = 'YES';
       exec sql
       select nomedit , idedit into :e2_nomedit , :e2_idedit
       from editeurs
       where nomedit = :e2_nomedit;

       code1 = sqlcod;

       // si editeurs existe deja ==> on insère que dans la table jeux
       if code1 = 0;
         exec sql
         insert into jeux ( nomjeu , date , idedit )
         values ( :e2_nomjeu , :e2_date , :e2_idedit );
         e1_nom = 'réussi';

       // si editeurs n'existe pas
       ENDIF;
       if code1 = 100;
          exec sql
          insert into editeurs ( nomedit , villeedit , devise )
          values ( :e2_nomedit , :e2_ville , :e2_devise );

          exec sql
          select idedit into :e2_idedit from editeurs where nomedit = :e2_nomedit;

          exec sql
          insert into jeux ( nomjeu , date , idedit ) values ( :e2_nomjeu , :e2_date , :e2_idedit );
       ENDIF;


      ENDIF;
    ENDIF;
  ENDIF;

  if e1_nom = *blanks;
    *in71 = *on;
    iter;
  ENDIF;
//----------------------------------------------------------------------------------------
// affichage
//----------------------------------------------------------------------------------------
  exec sql
  select a.idjeu , a.nomjeu , a.date , b.idedit , b.nomedit ,
     b.villeedit , b.devise
  into :e2_idjeu , :e2_nomjeu , :e2_date , :e2_idedit , :e2_nomedit ,
     :e2_ville , :e2_devise
  from jeux a join editeurs b
  on a.idedit = b.idedit
  where a.nomjeu = :e1_nom;

  if sqlcod = 0;
    *in82 = *on;
    exfmt FMT2;

// ----------------------------------------------------------------------------------------------
// update
//-----------------------------------------------------------------------------------------------
    if *in02 = *on;
      clear valid;
      exfmt FMT3;
      if valid = 'YES';
        exec sql
          update jeux
          set nomjeu = :e2_nomjeu , date = :e2_date
          where idjeu = :e2_idjeu;
        code = sqlcod;

        exec sql
        update editeurs
        set nomedit = :e2_nomedit , villeedit = :e2_ville , devise = :e2_devise
        where idedit = :e2_idedit;

        if code = 0 and sqlcod = 0;
          *in72 = *on;
          iter;
        else ;
          *in73 = *on;
        ENDIF;
      ENDIF;
    ENDIF;

// ------------------------------------------------------------------------------------------------
// suppréssion
// ------------------------------------------------------------------------------------------------

    if *in23 = *on;
      exfmt fmt5;
      if valid2 = 'YES';
         exec sql
         delete from jeux where idjeu = :e2_idjeu;
      ENDIF;
    ENDIF;

  elseif sqlcod = 100;
    *in70 = *on;
    iter;
  ENDIF;

ENDDO;

// ----------------------------------------------------------------------------------------
// sortie du prog
//---------------------------------------------------------------------------------------
*inlr = *on;
```
