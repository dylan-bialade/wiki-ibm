---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: FRUIT_CORR
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 155
modifie: 2026-11-25
---

# BIB27/QFREESRC/FRUIT_CORR

```rpg
**free
dcl-f fruits1 usage(*output:*update:*delete) keyed;
dcl-f E_FRUITCOR workstn sfile(sfl1:rang);

dcl-s rang packed(4:0);
dcl-s temp packed(4:0);
dcl-s temp1 packed(4:0);
dcl-s temp2 packed(4:0);

exsr init;
exsr build;
dow not *in03;
  write bas;
  exfmt ctl1;
  if *in05;
    exsr init;
    exsr build;
    iter;
  ENDIF;

  if *in06;
    exsr create;
    exsr init;
    exsr build;
    iter;
  ENDIF;

  readc sfl1;
  dow not %eof;
    select;
    when opt = '2';
      exsr update;
      exsr init;
      exsr build;
    when opt = '4';
      exsr delete;
      exsr init;
      exsr build;
    when opt = '5';
      exsr display;


    ENDSL;
    readc sfl1;
  ENDDO;
  exsr init;
  exsr build;


ENDDO;

*inlr = *on;


begsr init;
  setll *loval fruitf;
  rang = 0;
  *in31 = *on;
  write ctl1;
  *in31 = *off;
  *in32 = *off;
  *in90 = *off;
ENDSR;

begsr build;
  read fruitf;
  dow not %eof;
    rang += 1;
    eidfruit = %char(id);
    enomfruit = nom;
    enomlatin = nom_latin;
    write sfl1;
    read fruitf;
  ENDDO;
  if rang = 0;
    *in32 = *on;
  ENDIF;

ENDSR;

begsr create;
  clear modif;
  titre = 'Créer un nouveau fruit';

  dow not *in03 and not *in12;
    exfmt modif;

    if (e2id <> *blanks and e2nom <> *blanks and e2nomlatin <> *blanks);
      id = %int(e2id);
      nom = e2nom;
      nom_latin = e2nomlatin;
      write fruitf;
      leave;
    endif;
  enddo;

ENDSR;

begsr update;
  temp = %int(eidfruit);
  chain temp fruitf;
  titre = 'Modifier un fruit';
  *in80 = *on;
  e2nom = nom;
  e2nomlatin = nom_latin;
  e2id = %char(id);


  dow 1=1;
    exfmt modif;
    if *in03 or *in12;
      leave;
    ENDIF;
    if nom <> e2nom or nom_latin <> e2nomlatin;
      nom = e2nom;
      nom_latin = e2nomlatin;
      update fruitf;
      leave;
    endif;
  ENDDO;
ENDSR;

begsr delete;
  dow 1=1;
    temp1 = %int(eidfruit);
    chain temp1 fruitf;
    titre = 'supprimer un fruit';
    *in80 = *on;
    e2nom = nom;
    e2nomlatin = nom_latin;
    e2id = %char(id);
    temp2 = %int(e2id);
    exfmt modif;
    if *in03 or *in12;
      leave;
    ENDIF;
    delete temp2 fruitf;
    leave;
  ENDDO;
ENDSR;

begsr display;
  dow 1=1;
    e2nom = enomfruit;
    e2nomlatin = enomlatin;
    e2id = eidfruit;
    *in80 = *on;
    exfmt modif;
    iter;
    if *in03 or *in12;
      leave;
    ENDIF;

  ENDDO;
ENDSR;
```
