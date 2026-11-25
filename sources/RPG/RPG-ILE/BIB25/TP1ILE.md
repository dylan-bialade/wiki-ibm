---
bibliotheque: BIB25
fichier_source: QILETP
membre: TP1ILE
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 58
modifie: 2026-11-25
---

# BIB25/QILETP/TP1ILE

```rpg
**FREE

CTL-OPT DFTACTGRP(*NO) ACTGRP(*CALLER) STGMDL(*INHERIT) BNDDIR('TP1BND');

// Insertion des prototypes
/COPY BIB25/QILETP,TP1PRO

// Déclaration écran
DCL-F TP1DSPF WORKSTN;

// Déclaration Variable
DCL-S IndEmail ind;
DCL-S IndNumsecu ind;
DCL-S email char(120);

// Indicateurs
// *IN40 : Non affichage ERREMAIL (message d'erreur)
// *IN41 : Non affichage ERRNUMSECU (message d'erreur)
// *IN42 : Non affichage ERRSAISI (message d'erreur)

// Logique du programme
DOW NOT *IN03;
  EXFMT FMT1;
  *IN40 = *ON;
  *IN41 = *ON;
  *IN42 = *ON;
  IF *IN03 = *ON;
     LEAVE;
  ENDIF;

  // Contrôle sur les données saisies par l'utilisateur
  IF e_email = *blanks and e_numsecu = *blanks;
    *IN42 = *OFF;
    ERRSAISI = 'Renseignez Email et/ou NumSecu';
    iter;
  ENDIF;

  // Appel des modules si besoin
  email = e_email;
  IF e_email <> *blanks;
    IndEmail = CheckEmail(email);
    IF not IndEmail; // affichage msg erreur si pas valide
      *IN40 = *OFF;
      ERRMAIL = 'L''email "' + %trim(email) + '" : Pas valide';
    ENDIF;
  ENDIF;
  IF e_numsecu <> *blanks;
    IndNumsecu = CheckNumSecu(e_numsecu);
    IF not IndNumsecu;  // Affichage msg erreur si pas valide
      *IN41 = *OFF;
      ERRNUMSECU = 'Le numéro de Secu "' + %trim(e_numsecu) + '" : Pas valide';
    ENDIF;
  ENDIF;

ENDDO;

// sortie du programme
*INLR = *ON;
```
