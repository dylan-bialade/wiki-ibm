---
bibliotheque: BIB25
fichier_source: QILETP
membre: TPF_PGM
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 179
modifie: 2026-11-25
---

# BIB25/QILETP/TPF_PGM

```rpg
**FREE
CTL-OPT copyright('(C) ORGFORM 2025.') dftactgrp(*no)
actgrp(*caller) datfmt(*ISO) timfmt(*ISO) BNDDIR('TPF_DIR');

// Insertion des prototypes
/COPY BIB25/QILETP,TPF_PRO


//------------------------------------------------------------------//
// Programme : TPF_PGM (gestion des livres et des prets)            //
// Observation : Ce programme est le programme final du cours ILE   //
//               Utilisation de modules et de programmes de services//
// Source : QILETP / BIB25                                       //
// Date : 28/04/2025  (Léo BIB27 : LEO2)                          //
//------------------------------------------------------------------//

// Indicateurs
// *IN30 = SFLDSP
// *IN31 = SFLDSPCTL
// *IN32 = SFLCLEAR
// *IN33 = SFLCLEAR


// Déclaration écran TPF_ECR
DCL-F TPF_ECR workstn sfile(sfl1:rang);

// Variables globales
DCL-S rang packed(4:0); // rang sous fichier
DCL-S valid ind INZ(*OFF); // Indicateur de validité
DCL-S msg_usr ind INZ(*OFF); // indicateur message utilisateur
DCL-s message char(78); // Message utilisateur

// Pas de contrôle de validité
exec sql set option commit = *none;
// Date au format *ISO
exec sql set option datfmt = *iso;

// Déclaration curseur remplissage du sous fichier
// + Fonction de recherche
exec sql
declare C1 cursor for
select titre , auteur , sortie , disponible
from TP_LIVRES
where upper(titre) > upper(:search)
order by upper(titre);

// Logique principale
DOW NOT *IN03;
  // Initialisation et écriture du SF
  EXSR init;
  EXSR build;
  WRITE BAS;
  // Envoie des messages à l'utilisateur CREATION
  IF msg_usr;
    SND-MSG *STATUS message %target(*ext);
  ENDIF;
  EXFMT CTL1;


  // Création d'un livre
  IF *IN06;
    EXSR CREATE;
  ENDIF;

  // Sortir du programme
  IF *IN03;
    leave;
  ENDIF;

  // Actualisation du sous fichier
  IF *IN05;
    clear opt;
    iter;
  ENDIF;


  // Lecture du sous fichier
  READC SFL1;
  DOW NOT %EOF;
    SELECT;
    when opt = '5'; // Afficher
    // sous routines ?
    when opt = '4'; // Supprimmer
      EXSR DELETE;
    when opt = '2'; // Modifier
    // sous routines ? utilisation procédure module
    ENDSL;
  ENDDO;

ENDDO;

// Sortie du programme
*INLR = *ON;

// Procédures internes
// Initialisation du SF
BEGSR INIT;
  rang = 0;
  // clear du SF
  *IN32 = *ON;
  WRITE CTL1;
  *IN32 = *OFF;
ENDSR;
// Remplissage du SF
BEGSR BUILD;
  exec sql
  open c1;
  exec sql
  fetch c1 into :e_titre , :e_auteur , :e_sortie  , :e_dispo;
  DOW SQLCODE <> 100;
    rang += 1;
    WRITE SFL1;
    exec sql
    fetch c1 into :e_titre , :e_auteur , :e_sortie  , :e_dispo;
  ENDDO;
  exec sql
  close c1;
  *IN33 = *ON; // SFLEND
  if rang > 0;
    *IN31 = *ON;
    *IN30 = *ON;
  else;
    *IN31 = *ON;
  ENDIF;
ENDSR;
// Création d'un livre
BEGSR CREATE;
  clear valid;
  clear message;
  clear err_msg;
  msg_usr = *OFF;
  DOW NOT *IN03;
    clear w_sortie;
    clear w_titre;
    clear w_auteur;
    EXFMT WIN1;
    IF *IN12;
      leave;
    ENDIF;
    // contrôle sur la date
    IF %check('0123456789-': w_sortie) <> 0 and %subst(w_sortie:5:1) <> '-'
       and %subst(w_sortie:8:1) <> '-' ;
      err_msg = 'Format date : YYYY-MM-JJ';
      iter;
    ENDIF;
    IF *IN15;
      // Utilisation procédure Ajout Livre module TPF_MOD1
      valid = AjoutLivre(w_titre:w_auteur:w_sortie);
      msg_usr = *ON;
      IF valid;
        message = 'Livre ' + %trim(w_titre) + ' créé';
      else;
        message = 'Livre ' + %trim(w_titre) + ' non créé : '
                  + w_sortie + ' n''est pas une date de sortie valide' ;
      ENDIF;
      leave;
    ENDIF;
  ENDDO;
ENDSR;
//// Suppression d'un livre
BEGSR DELETE;
  DOW NOT *IN03;
    msg_usr = *OFF;
    EXFMT WIN2;
    IF *IN12;
      leave;
    ENDIF;
    IF *IN23;
      valid = SupprLivre(e_titre:e_auteur:%char(e_sortie));
      msg_usr = *ON;
      IF valid;
        message = 'Livre ' + %trim(e_titre) + ' supprimé';
      else;
        message =  'Livre ' + %trim(e_titre) + ' non supprimé';
      ENDIF;
      leave;
    ENDIF;
  ENDDO;
ENDSR;
```
