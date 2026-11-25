---
bibliotheque: BIB27
fichier_source: QTPSRC
membre: TPFINAL
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 268
modifie: 2026-11-25
---

# BIB27/QTPSRC/TPFINAL

```rpg
**free

ctl-opt bnddir('BIB27/TESTREP');

//----------------------|
//     déclaratives     |
//----------------------|


dcl-f e_tpfinal workstn sfile(sf1:rang);
dcl-f tp_prtf PRINTER oflind(*in30);

dcl-pr calculttc packed(6:2);
  tva packed(3:0);
  prix packed(6:2);
END-PR;

dcl-s rang packed(4:0);
dcl-s prixttc packed(6:2);




//----------------------------------|
//         programme                |
// ---------------------------------|
// indicateurs :                    |
// *in50 = SFLDSP (sf1)             |
// *IN51 = SFLDSPCTl (sf1)          |
// *IN52 = SFLCLEAR (sf1)           |
// *IN53 = SFLLEND  (sf1)           |
// *IN60 = zone protégé (FMT1)      |
//----------------------------------|


*inlr = *on;

exec sql set option commit = *none;

exec sql
declare c1 cursor for
select libelle , prixht , tva
from articles
where libelle >= :e_srh
order by libelle;

exec sql
declare c2 cursor for
select libelle , prixht , tva , rayon
from articles
order by rayon;


// Boucle principale
dow not *in03;

  clear opt;
  clear fonction;
  *in60 = *off;

  // ecriture du sous fichier
  exsr init;
  exsr build;
  write BAS;
  exfmt CTL1;

  // actuaslisation du sous fichier
  if *in05 = *on;
    iter;
  ENDIF;

  // gestion de la creation d'articles
  if *in06 = *on;
    exsr creation;
  ENDIF;

  // gestion de l'impression
  if *in08 = *on;
    exsr printer;
  ENDIF;


  // gestion des options
  readc sf1;
  dow not %eof;
    select;
    when opt = '5';
      exsr display;
    when opt = '2';
      exsr update;
    when opt = '4';
      exsr delete;
    ENDSL;
    readc sf1;
  ENDDO;

ENDDO;



//--------------------------|
//      SOUS ROUTINES       |
//--------------------------|

// sous routine INIT
begsr init;
  exec sql close c1;
  exec sql open c1;
  rang = 0;
  *in52 = *on;
  write CTL1;
  *in52 = *off;
ENDSR;

// sous routine BUILD
begsr build;
  exec sql fetch c1 into :e_libelle , :e_prixht , :e_tva;
  dow sqlcode <> 100;
    rang += 1;
    prixttc = calculttc(e_tva:e_prixht);
    e_prixttc = prixttc;
    write sf1;
    exec sql fetch c1 into :e_libelle , :e_prixht , :e_tva;
  ENDDO;
  *in53 = *on;
  if rang > 0;
    *in51 = *on;
    *in50 = *on;
  else;
    *in51 = *on;
  ENDIF;
ENDSR;

// sous routine DISPLAY
begsr display;
  *in60 = *on;
  fonction = ' ';
  titre = 'Affichage';
  exec sql
  select libelle , rayon , prixht , tva
  into :e1_libelle , :e1_rayon , :e1_prixht , :e1_tva
  from articles
  where libelle = :e_libelle;
  prixttc = calculttc(e_tva: e_prixht);
  e1_prixttc = prixttc;
  exfmt FMT1;
  if *in12 or *in03;
    clear opt;
    exsr init;
    exsr build;
  ENDIF;
ENDSR;


// sous routine UPDATE
begsr update;
  clear msg;
  titre = 'Modification';
  fonction = 'f2=Modifier';
  dow 1=1;
    exec sql
    select libelle , rayon , prixht , tva
    into :e1_libelle , :e1_rayon , :e1_prixht , :e1_tva
    from articles
    where libelle = :e_libelle;
    prixttc = calculttc(e_tva: e_prixht);
    e1_prixttc = prixttc;
    exfmt FMT1;
    if *in03 or *in12;
      clear opt;
      exsr init;
      exsr build;
      leave;
    else;
      if *in02;
        if e1_rayon <> 'Épicerie' AND e1_rayon <> 'Décoration'
        AND e1_rayon <> 'Vêtements' AND e1_rayon <> 'Électronique';
          msg = 'Rayon: Épicerie-Décoration-Vêtements-Électronique';
          iter;
        else;
          exec sql
          update articles
          set libelle=:e1_libelle , rayon=:e1_rayon , prixht=:e1_prixht , tva=:e1_tva
          where libelle=:e_libelle;
          leave;
        ENDIF;
      endif;
    ENDIF;
    leave;
  ENDDO;
ENDSR;

// sous routine DELETE
begsr delete;
  *in60 = *on;
  titre = 'Supréssion';
  fonction = 'f23=Supprimer';
  exec sql
    select libelle , rayon , prixht , tva
    into :e1_libelle , :e1_rayon , :e1_prixht , :e1_tva
    from articles
    where libelle = :e_libelle;
  prixttc = calculttc(e_tva: e_prixht);
  e1_prixttc = prixttc;
  exfmt FMT1;
  if *in12 or *in03;
    clear opt;
    exsr init;
    exsr build;
  else;
    if *in23 = *on;
      exec sql
      delete from articles
      where libelle = :e_libelle;
    ENDIF;
  ENDIF;
ENDSR;

// sous routine CREATION
begsr creation;
  CLEAR fmt1;
  fonction = 'f6=ajouter';
  titre = 'Ajouter un article';
  dow 1=1;
    exfmt FMT1;
    if *in03 or *in12;
      clear opt;
      exsr init;
      exsr build;
      leave;
    else;
      if *in06 = *on;
        if e1_rayon <> 'Épicerie' AND e1_rayon <> 'Décoration'
        AND e1_rayon <> 'Vêtements' AND e1_rayon <> 'Électronique';
          msg = 'Rayon: Épicerie-Décoration-Vêtements-Électronique';
          iter;
        else;
          exec sql
          insert into articles ( libelle , rayon , prixht , tva )
          values ( :e1_libelle , :e1_rayon , :e1_prixht , :e1_tva );
          leave;
        ENDIF;
      ENDIF;
    ENDIF;
  ENDDO;
ENDSR;


// sous routine PRINTER
begsr printer;
  write titres;
  exec sql close c2;
  exec sql open c2;
  exec sql
  fetch c2 into :plibelle , :pprixht , :ptva , :prayon;
  write colonne;
  dow sqlcode <> 100;
    pprixttc = calculttc(ptva:pprixht);
    write details;
    if *in30;
      write eject;
      write colonne;
    ENDIF;
    *in30 = *off;
    exec sql
    fetch c2 into :plibelle , :pprixht , :ptva , :prayon;
  ENDDO;
ENDSR;
```
