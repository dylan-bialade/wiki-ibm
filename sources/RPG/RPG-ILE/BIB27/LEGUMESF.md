---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: LEGUMESF
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 199
modifie: 2026-11-25
---

# BIB27/QFREESRC/LEGUMESF

```rpg
**free

//----------------------|
//     déclaratives     |
//----------------------|

dcl-f e_legume workstn sfile(sf1:rang);
dcl-f i_legume PRINTER;


dcl-s rang packed(4:0);

//----------------------------------|
//         programme                |
// ---------------------------------|
// indicateurs :                    |
// *in50 = SFLDSP                   |
// *IN51 = SFLDSPCTl                |
// *IN52 = SFLCLEAR                 |
// *IN53 = SFLLEND                  |
// *IN60 = protected ID(FMT1)       |
// *IN61 = protected zones (FMT1)   |
// *IN62 = non affichable ID(FMT1)  |
//----------------------------------|

*inlr = *on;

exec sql
set option commit = *none;

exec sql
declare c1 cursor for
select id , nom , saison , poid , couleur
from legume
where nom >= :einput order by nom;



dow not *in03;

  clear opt;
  *in60 = *off;
  *in61 = *off;
  exsr init;
  exsr build;
  write BAS;
  exfmt CTL1;

  if *in05 = *on;
    iter;
  ENDIF;

  if *in06 = *on;
    clear FMT1;
    titre = 'Ajout';
    *in62 = *on;
    *in60 = *on;
    exfmt FMT1;
    if not *in03 and not *in12;
      exec sql
      insert into legume ( nom , saison , couleur , poid )
      VALUES ( :e2nom , :e2saison , :e2couleur , :e2poid );
    ENDIF;
  ENDIF;

  if *in08 = *on;
    exsr printer;
  ENDIF;

  readc sf1;
  dow not %eof;
    select;
      when opt = '5';
        exsr display;
      when opt = '2';
        exsr update;
      when opt = '4';
        exsr delete;
      when opt = '3';
        exsr copy;
    ENDSL;
    readc sf1;
  ENDDO;


ENDDO;

//--------------------------|
//      SOUS ROUTINES       |
//--------------------------|

// sous routines INIT
begsr init;
  exec sql close c1;
  exec sql open c1;
  rang = 0;
  *in52 = *on;
  write CTL1;
  *in52= *off;
ENDSR;

// sous routines BUILD
begsr build;
   exec sql fetch c1 into :eid , :enom , :esaison , :epoid , :ecouleur;
   dow sqlcode <> 100;
     rang += 1;
     write sf1;
     exec sql fetch c1 into :eid , :enom , :esaison , :epoid , :ecouleur;
   ENDDO;
   *in53 = *on;
   if rang > 0;
     *in51 = *on;
     *in50 = *on;
   else;
     *in51 = *on;
   ENDIF;
ENDSR;

// sous routine DISPlAY
begsr display;
  titre = 'Affichage';
  *IN61 = *on;
  *in60 = *on;
  exec sql
  select id , nom , saison , couleur , poid
  into :e2id , :e2nom , :e2saison , :e2couleur , :e2poid
  from legume where id = :eid;
  exfmt FMT1;
  if *in12 = *on or *in03 = *on;
    clear opt;
    exsr init;
    exsr build;
  ENDIF;
ENDSR;

// sous routine UPDATE
begsr update;
  titre = 'Modification';
  *in60 = *on;
  exec sql
    select id , nom , saison , couleur , poid
    into :e2id , :e2nom , :e2saison , :e2couleur , :e2poid
    from legume where id = :eid;
  exfmt FMT1;
  if not *in03 and not *in12;
     exec sql
     update legume set nom = :e2nom , saison=:e2saison , couleur=:e2couleur,
     poid=:e2poid
     where id = :e2id;
  ENDIF;

ENDSR;

// sous routine DELETE
begsr delete;
  titre = 'suppression';
  *in60 = *on;
  *in61 = *on;
  exec sql
    select id , nom , saison , couleur , poid
    into :e2id , :e2nom , :e2saison , :e2couleur , :e2poid
    from legume where id = :eid;
  exfmt FMT1;
  if not *in03 and not *in12;
    exec sql
    delete legume where id = :e2id;
  ENDIF;
ENDSR;

// sous routine COPY
begsr copy;
  exfmt W1;
  if not *in12;
    if wnom <> *blanks;
      exec sql
      insert into legume ( nom , saison , couleur , poid )
      values ( :wnom , :esaison , :ecouleur , :epoid );
    else;
      exec sql
      insert into legume ( nom , saison , couleur , poid )
      values ( :enom , :esaison , :ecouleur , :epoid );
    ENDIF;
  ENDIF;
ENDSR;

// sous routine PRINTER
begsr printer;
  write titres;
  exec sql close c1;
  exec sql open c1;
  exec sql
  fetch c1 into :pid , :pnom , :psaison , :ppoid , :pcouleur;
  WRITE COLONNE;
  dow sqlcode <> 100;
    write details;
    exec sql
    fetch c1 into :pid , :pnom , :psaison , :ppoid , :pcouleur;
  ENDDO;
ENDSR;
```
