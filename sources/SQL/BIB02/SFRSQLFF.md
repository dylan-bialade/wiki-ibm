---
bibliotheque: BIB02
fichier_source: QSQLSRC
membre: SFRSQLFF
type: SQL
longueur_enregistrement: 100
lignes: 239
modifie: 2026-11-16
---

# BIB02/QSQLSRC/SFRSQLFF

```sql
**free
CTL-OPT COPYRIGHT('(C) ARMONIE 2023.') USRPRF(*OWNER)
OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*FULL)
ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
STGMDL(*INHERIT) THREAD(*SERIALIZE);

//*****************************************************************
// Programme : SFRSQL
// BIB02 SYLVAIN - EXEMPLE DE SOUS-FICHIER DYNAMIQUE EN SQL
// Date      - 04/07/2022
// Mise à jour - 18/01/2022
// IMPORTANT !!- CHANGEZ LE OPTIMIZE(*FULL) EN *NONE POUR DEBUG
// POUR DEBUGGER   !!!!!!!!!
// Copyright - ARMONIE
//*****************************************************************

//**********************************************************************//
// Déclaration des fichiers                                             //
//**********************************************************************//
DCL-F SFDSPSQL WORKSTN SFILE(SFL1:RANG);

//**********************************************************************//
// Déclaration des variables                                            //
//**********************************************************************//
DCL-S LAST_RANG ZONED(4:0) INZ(0);    // Dernier rrn écrit avant pagination
DCL-S i         ZONED(4:0) INZ(0);
DCL-S datejour  DATE(*ISO) INZ(*JOB);

//**********************************************************************//
// Déclaration des constantes                                           //
//**********************************************************************//
DCL-C SflPag    CONST(12);   // Nombre de ligne à afficher par page ...
DCL-C Afficher  CONST('5');
DCL-C Supprimer CONST('4');
DCL-C Modifier  CONST('2');


//**********************************************************************//
// Traitement pricipale                                                 //
//**********************************************************************//
*Inlr = *On;
EXEC SQL
  SET option commit = *NONE , ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD;

// A - Initialisation du sous-fichier
Initialisation_sous_fichier();

// B - Fabrication du sous-fichier
Fabrication_sous_fichier();

// La zone de "afficher à partir de" à blanc
scodpro = '';

DOU *IN03;  // Sortie F3
  Write Fkey1;
  Exfmt Sf1ctl;

  // Et là, on se pose la question : Qu'à fait l'utilisateur ?
  SELECT;
  WHEN *IN39;    // a-t-il paginé ? (Pagedown)
    Fabrication_sous_fichier();
  WHEN scodpro <> ''; // a-t-il touché à la zone "Afficher à partir de" ?
    EXEC SQL close C1;
    Initialisation_sous_fichier();
    Fabrication_sous_fichier();
    clear Scodpro;
  WHEN *IN05; // F5=Réafficher
    EXEC SQL close C1;
    Initialisation_sous_fichier();
    Fabrication_sous_fichier();
  WHEN *IN06; // F6=Création
    creation();
    EXEC SQL close C1;
    Initialisation_sous_fichier();
    Fabrication_sous_fichier();
  OTHER; // La touche ENTRER
    EXEC SQL
    select codpro into :e1codpro from BIB02.entrepot;
    IF SQLCODE <> 100;  // si SQLCODE est différent de vide
      trt_readc();  // on fait un readc seulement s'il y a des données
    ENDIF;
    EXEC SQL close C1;
    Initialisation_sous_fichier();
    Fabrication_sous_fichier();
  ENDSL;

ENDDO;

EXEC SQL close C1;

//************************************************************************
// Initialisation du sous fichier                                       //
//************************************************************************
DCL-PROC Initialisation_sous_fichier;
  RANG = 0;      // Initialisat° du compteur d'enregistrement.
  LAST_RANG = 0; // Initialisat° du dernier rrn d'enregistrement.
  *In31 = *ON;       // Activat° de l'indic de vidage de SFL  (Associé au mot clé SFLCR)
  Write Sf1ctl;      // Vidage du sous-fichier
  *In31 = *OFF;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLCLR)
  *In32 = *OFF;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLDSP)
  *In90 = *OFF;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLEND)
  EXEC SQL
        Declare C1 CURSOR FOR
        (select codpro, nmpro, qtpro, dtdinv
        from entrepot
        order by codpro)
        FOR READ ONLY OPTIMIZE FOR ALL ROWS;

  EXEC SQL
        open C1;
END-PROC;

//************************************************************************
// Fabrication du sous fichier                                          //
//************************************************************************
DCL-PROC Fabrication_sous_fichier;
  RANG = LAST_RANG;        // Le "RRN" reçoit la valeur du dernier rang

  FOR i=1 to Sflpag;  // Tantque i est inférieur à sflpag
    EXEC SQL Fetch C1 into :e1codpro, :e1nmpro, :e1qtpro, :e1dtdinv;
    IF sqlcode = 100;
      *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
      leave;
    ENDIF;

    // Gere le "Afficher à partir de..."
    IF e1codpro >= scodpro;
      RANG += 1;  // Incrémentation du compteur de ligne
      write Sfl1; // Ecrie le sous-fichier
    ENDIF;
  ENDFOR;

  IF RANG = 0;
    *IN32 = *ON;
  ENDIF;
  LAST_RANG = RANG;

END-PROC;


//******************************************************************
// Traitement du READC                                            //
//******************************************************************
DCL-PROC TRT_READC;
  Readc Sfl1;
  DOW NOT %eof;
    SELECT;
    WHEN OPT = Afficher;  // Option 5 Afficher
      affiche();
    WHEN OPT = Supprimer;  // Option 4 Supprimer
      suppression();
    WHEN OPT = Modifier;  // Option 2 Modifier
      modification();
    ENDSL;
    Readc Sfl1;
  ENDDO;
END-PROC;

//************************************************************************
// Créer                                                                //
//************************************************************************
DCL-PROC creation;
  DOU *IN03;
    E6DTDINV = datejour;
    EXFMT FMT6;
    SELECT;
    WHEN *IN03;
      iter;
    WHEN *IN12;
      leave;
    WHEN *IN23;
      EXEC SQL
       insert into entrepot (codpro, nmpro, qtpro, dtdinv)
      values ( :E6CODPRO, :E6NMPRO, :E6QTPRO, :datejour);
      leave;
    ENDSL;
  ENDDO;
  clear OPT; // Remise à blanc de l'option saisie
END-PROC;

//************************************************************************
// Afficher                                                             //
//************************************************************************
DCL-PROC affiche;
  EXEC SQL
   SELECT codpro, nmpro, qtpro, dtdinv
     INTO :e5codpro, :e5nmpro, :e5qtpro, :e5dtdinv
   FROM entrepot
   WHERE codpro = :e1codpro;
  EXFMT FMT5;
  clear OPT; // Remise à blanc de l'option saisie
END-PROC;

//************************************************************************
// Modifier                                                             //
//************************************************************************
DCL-PROC modification;
  EXEC SQL
   SELECT codpro, nmpro, qtpro, dtdinv
     INTO :e2codpro, :e2nmpro, :e2qtpro, :e2dtdinv
   FROM entrepot
   WHERE codpro = :e1codpro;
  DOU *IN03;
    EXFMT FMT2;
    SELECT;
    WHEN *IN03;
      iter;
    WHEN *IN12;
      leave;
    WHEN *IN23;
      EXEC SQL
      update entrepot
      set codpro = :E2CODPRO, nmpro = :E2NMPRO,
      qtpro = :E2QTPRO, dtdinv = :E2DTDINV
      where codpro = :e2codpro;
      leave;
    ENDSL;
  ENDDO;
  clear OPT; // Remise à blanc de l'option saisie
  Update Sfl1;  // Mets à jour le Sous-fichier
END-PROC;

//************************************************************************
// Supprimer                                                            //
//************************************************************************
DCL-PROC suppression;
  EXEC SQL
   SELECT codpro, nmpro, qtpro, dtdinv
     INTO :e4codpro, :e4nmpro, :e4qtpro, :e4dtdinv
   FROM entrepot
   WHERE codpro = :e1codpro;
  EXFMT FMT4 ;
  clear OPT; // Remise à blanc de l'option saisie
  IF *IN23; // Si F23 on active le delete
    EXEC SQL
      delete from entrepot where codpro = :e4codpro;
  ENDIF;
  Update Sfl1;   // Mets à jour le Sous-fichier
END-PROC;
```
