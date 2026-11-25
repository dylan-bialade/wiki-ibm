---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: P_FRUITS
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 197
modifie: 2026-11-25
---

# BIB27/QFREESRC/P_FRUITS

```rpg
**free

//-----------------------|
//      FRUITS           |
// ----------------------|

// ---------------------------------|
// indicateurs :                    |
// *in50 = SFLDSP                   |
// *IN51 = SFLDSPCTl                |
// *IN52 = SFLCLEAR                 |
// *IN53 = SFLLEND                  |
// *IN60 = protected id(creation)   |
// *IN61 = zone protégé affichage   |
// *IN62 = non affichable f6=creer  |
// *IN63 = non affichable f4=suppr  |
// *IN64 = non affichable f2=modif  |
// ---------------------------------|


// Déclaratives

dcl-f e_fruits workstn sfile(sf1:rang);
dcl-f fruits usage(*update:*output:*input:*delete) KEYED;
dcl-s rang packed(4:0);


// Programme

dow not *in03;

  // clear + setoff indicateurs
  clear opt;
  clear e2_titre;
  *in61 = *off;
  *in60 = *off;
  *in62 = *off;
  *in63 = *off;
  *in64 = *off;

  // initialise le rang à 0
  rang = 0;

  // clear du sous fichier
  *in52 = *on;
  write CTL1;
  *in52 = *off;

  // lecture du fichier puis ecriture du sf
  setll *loval fruitfmt;
  read fruitfmt;
  dow  not %eof;
    rang = rang + 1;
    e1_nom = nom;
    e1_id = id;
    e1_com = commestibl;
    e1_saison = saison;
    e1_couleur = couleur;
    e1_gout = gout;
    write SF1;
    read fruitfmt;
  ENDDO;

  // verification si données dans sf
  *in53 = *on;
  if rang > 0;
    *in51 = *on;
    *in50 = *on;
  else;
    *in51 = *on;
  ENDIF;

  // affichage sf
  write BAS;
  exfmt CTL1;

  // lecture du sf
  readc SF1;
  dow not %eof;

    *in62 = *off;
    *in63 = *off;
    *in64 = *off;



    if opt = '5';
      *in62 = *on;
      *in60 = *on;
      *in61 = *on;
      *in63 = *on;
      *in64 = *on;
      e2_titre = 'Affichage';
      chain e1_id fruitfmt;
      e2_nom = nom;
      e2_id = id;
      e2_com = commestibl;
      e2_saison = saison;
      e2_gout = gout;
      e2_couleur = couleur;
      e2_latin = nomlatin;
      exfmt FMT1;
      if *in12 = *on;
        leave;
      ENDIF;

    elseif opt = '4';
      *in62 = *on;
      *in60 = *on;
      *in61 = *on;
      *in64 = *on;
      e2_titre = 'Suppréssion';
      chain e1_id fruitfmt;
      e2_nom = nom;
      e2_id = id;
      e2_com = commestibl;
      e2_saison = saison;
      e2_gout = gout;
      e2_couleur = couleur;
      e2_latin = nomlatin;
      exfmt FMT1;
      if *in12 = *on;
        leave;
      ENDIF;
      if *in04 = *on;
        delete e2_id fruitfmt;
      ENDIF;

    elseif opt = '2';
      e2_titre = 'modification';
      *in60 = *on;
      *in62 = *on;
      *in63 = *on;
      chain e1_id fruitfmt;
      e2_nom = nom;
      e2_id = id;
      e2_com = commestibl;
      e2_saison = saison;
      e2_gout = gout;
      e2_couleur = couleur;
      e2_latin = nomlatin;
      exfmt FMT1;
      if *in12 = *on;
        leave;
      ENDIF;
      if *in02 = *on;
        nom = e2_nom;
        id = e2_id;
        commestibl = e2_com;
        saison = e2_saison;
        gout = e2_gout;
        nomlatin = e2_latin;
        couleur = e2_couleur;
        update fruitfmt;
      ENDIF;
    ENDIF;

    readc SF1;
  ENDDO;

  // gestion de la création
  if *in06 = *on;
    *in63 = *on;
    *in64 = *on;
    e2_titre = 'création d''un fruit';
    *in60 = *on;
    setll *hival fruitfmt;
    read fruitfmt;
    e2_id = id + 1;
    exfmt FMT1;
    if *in12 = *on;
      iter;
    ENDIF;
    // validation de la création
    if *in06 = *on;
      id = e2_id;
      nom = e2_nom;
      nomlatin = e2_latin;
      commestibl = e2_com;
      saison = e2_saison;
      gout = e2_gout;
      couleur = e2_couleur;
      write fruitfmt;
      clear FMT1;
    ENDIF;
  ENDIF;

  if *in05 = *on;
    iter;
  ENDIF;


ENDDO;

// Sortie du programme

*inlr = *on;
```
