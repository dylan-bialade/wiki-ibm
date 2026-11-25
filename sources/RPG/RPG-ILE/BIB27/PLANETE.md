---
bibliotheque: BIB27
fichier_source: QSQLRPGLE
membre: PLANETE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 140
modifie: 2026-11-25
---

# BIB27/QSQLRPGLE/PLANETE

```rpg
**FREE
CTL-OPT COPYRIGHT('(C) ORGFORM 2024.')
OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*NONE)
ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
STGMDL(*INHERIT) THREAD(*SERIALIZE);

//*****************************************************************
// Programme : sf_dyn_rpg
// BIB02 SYLVAIN - EXEMPLE DE SOUS-FICHIER EN SQL
// Date      - 25/06/2024
// IMPORTANT !!- CHANGEZ LE OPTIMIZE(*FULL) EN *NONE POUR DEBUG
// Copyright - ORGFORM
//*****************************************************************

//**********************************************************************//
// Déclaration des fichiers                                             //
//**********************************************************************//
DCL-F PLANETE WORKSTN SFILE(SFL1:RANG);

//**********************************************************************//
// Déclaration des variables                                            //
//**********************************************************************//

DCL-S rang zoned(4:0);
dcl-s sql  varchar(32000);
dcl-s sqlw varchar(32000);

//**********************************************************************//
// Déclaration des constantes                                           //
//**********************************************************************//


//**********************************************************************//
// Réception paramètre                                                  //
//**********************************************************************//

DCL-pi *N;
  type char(10);
  statut char(1);
END-PI;


//**********************************************************************//
// SFLDSP = *IN30                                                       //
// SFLDSPCTL = *IN31                                                    //
// SFLCLR =  *IN32                                                      //
// SFLEND = *IN33                                                       //
// AFFICHAGE ZONE "planete associée" FMT1 = *IN50                       //
//**********************************************************************//

//**********************************************************************//
// Traitement pricipale                                                 //
//**********************************************************************//

EXEC SQL
  SET option commit = *none , ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD;



DOW NOT *IN03;
  EXSR INIT;
  EXSR CHARGEMENT;
  TITLE = TYPE;
  WRITE BAS;
  EXFMT CTL1;

  IF *IN05;
    ITER;
  ENDIF;
  IF *IN08;
    statut = '1';
    *IN03 = *ON;
  ENDIF;

  READC SFL1;
  DOW NOT %EOF;
    SELECT;
      WHEN OPT = '5';
        EXSR DISPLAY;
    ENDSL;
  ENDDO;
ENDDO;

*INLR = *ON;

//**********************************************************************//
// SOUS ROUTINES                                                        //
//**********************************************************************//

// Iitialisation du sous fichier
BEGSR INIT;
  RANG = 0;
  *IN32 = *ON;
  WRITE CTL1;
  *IN32 = *OFF;
  *IN30 = *OFF;
  *IN31 = *OFF;
ENDSR;

// Chargement du sous fichier
BEGSR CHARGEMENT;
   sql = 'SELECT NAME , DIAMETER , DENSITY , ORBITALPERIOD FROM ';
   sql += type;
   EXEC SQL
   PREPARE P1 FROM :SQL;
   EXEC SQL
   DECLARE C1 CURSOR FOR P1;
   EXEC SQL
   OPEN C1;
   EXEC SQL
   FETCH C1 INTO
   :E1NAME , :E1DIAMETRE , :E1DENSITE , :E1PERIOD;
   DOW SQLCODE >= 0 AND SQLCODE <> 100;
     RANG += 1;
     WRITE SFL1;
     EXEC SQL
     FETCH C1 INTO
     :E1NAME , :E1DIAMETRE , :E1DENSITE , :E1PERIOD;
   ENDDO;
   *IN33 = *ON;
   IF RANG > 0;
     *IN31 = *ON;
     *IN30 = *ON;
   ELSE;
     *IN31 = *ON;
   ENDIF;
   EXEC SQL
   CLOSE C1;
ENDSR;

// Affichage enreg sous fichier
BEGSR DISPLAY;
   IF TYPE = 'LUNES';
      EXEC SQL
      SELECT NAME , DIAMETER , DENSITY , ORBITALPERIOD , PLANET
        INTO
        FROM :TYPE
   ENDIF;

ENDSR;
```
