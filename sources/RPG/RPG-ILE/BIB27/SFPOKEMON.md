---
bibliotheque: BIB27
fichier_source: QRPGLESRC
membre: SFPOKEMON
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 156
modifie: 2026-11-25
---

# BIB27/QRPGLESRC/SFPOKEMON

```rpg
**FREE
CTL-OPT COPYRIGHT('(C) ORGFORM 2024.')
OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*FULL)
ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
STGMDL(*INHERIT) THREAD(*SERIALIZE);

//*****************************************************************
// Programme : SFUSER
// BIB02 SYLVAIN - EXEMPLE DE SOUS-FICHIER DYNAMIQUE EN SQL
// Date      - 23/05/2023
// IMPORTANT !!- CHANGEZ LE OPTIMIZE(*FULL) EN *NONE POUR DEBUG
// Copyright - ORGFORM
//*****************************************************************

//**********************************************************************//
// Déclaration des fichiers                                             //
//**********************************************************************//
DCL-F PKMNDSPF WORKSTN SFILE(SFL1:RANG);

//**********************************************************************//
// Déclaration des variables                                            //
//**********************************************************************//
DCL-S LAST_RANG ZONED(4:0)   INZ(*ZERO);
DCL-S i         ZONED(4:0)   INZ(*ZERO);

//**********************************************************************//
// Déclaration des constantes                                           //
//**********************************************************************//
DCL-C SflPag    CONST(12);   // Nombre de ligne à afficher par page ...


// DS format d'écran SFL1
DCL-DS DSSFL1;
  E1NAME           char(20);
  E1TYPE1          char(10);
  E1TYPE2          char(10);
  E1TALENT         char(20);
  E1PV             zoned(3:0);
  E1ATK            zoned(3:0);
  E1DEF            zoned(3:0);
  E1ATS            zoned(3:0);
  E1DFS            zoned(3:0);
  E1VIT            zoned(3:0);
END-DS;




//**********************************************************************//
// Traitement pricipale                                                 //
//**********************************************************************//

EXEC SQL
  SET option commit = *none , ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD;

// A - Initialisation du sous-fichier
EXSR Initialisation_sous_fichier;

// B - Fabrication du sous-fichier
EXSR Fabrication_sous_fichier;


DOU *IN03;  // Sortie F3
  Write Fkey1;
  Exfmt Sf1ctl;

  // Et là, on se pose la question : Qu'à fait l'utilisateur ?
  SELECT;
  WHEN *IN39;    // a-t-il paginé ? (Pagedown)
    EXSR Fabrication_sous_fichier;
  WHEN *IN05; // F5=Réafficher
    EXEC SQL close C1;
    EXSR Initialisation_sous_fichier;
    EXSR Fabrication_sous_fichier;
  OTHER; // La touche ENTRER
    EXSR Initialisation_sous_fichier;
    EXSR Fabrication_sous_fichier;
  ENDSL;

ENDDO;

EXEC SQL close C1;
*Inlr = *On;

//************************************************************************
// Initialisation du sous fichier  - GET                                //
//************************************************************************
BEGSR Initialisation_sous_fichier;
  RANG = *ZERO;      // Initialisat° du compteur d'enregistrement.
  LAST_RANG = *ZERO; // Initialisat° du dernier rrn d'enregistrement.
  *In31 = *ON;       // Activat° de l'indic de vidage de SFL  (Associé au mot clé SFLCR)
  Write Sf1ctl;      // Vidage du sous-fichier
  *In31 = *OFF;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLCLR)
  *In32 = *OFF;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLDSP)
  *In90 = *OFF;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLEND)
      EXEC SQL
       //**CODER ICI
       Declare C1 cursor for (select  COALESCE(NOM,''),
                  COALESCE(TYPE1, ''),
                  COALESCE(TYPE2, ''),
                  COALESCE(TALENT, ''),
                  COALESCE(PV, 0),
                  COALESCE(ATK, 0),
                  COALESCE(DEF, 0),
                  COALESCE(ATS, 0),
                  COALESCE(DFS, 0),
                  COALESCE(VIT, 0)
                  from json_table( systools.HTTPGETCLOB (
                 cast( 'https://tyradex.vercel.app/api/v1/pokemon' as varchar(255)),
                 cast(null as clob(1k)
                        )),
                  '$'
                 COLUMNS(
                  NOM VARCHAR(20) PATH '$.name.fr' ,
                  TYPE1 VARCHAR(20) PATH '$.types[0].name',
                  TYPE2 VARCHAR(20) PATH '$.types[1].name',
                  TALENT VARCHAR(20) PATH '$.talents.name[0]',
                  PV DECIMAL PATH '$.stats.hp',
                  ATK DECIMAL PATH '$.stats.atk',
                  DEF DECIMAL PATH '$.stats.def',
                  ATS DECIMAL PATH '$.stats.spe_atk',
                  DFS DECIMAL PATH '$.stats.spe_def',
                  VIT DECIMAL PATH '$.stats.vit'
                )
               ));


  EXEC SQL
        open C1;

ENDSR;

//************************************************************************
// Fabrication du sous fichier                                          //
//************************************************************************
BEGSR Fabrication_sous_fichier;
  RANG = LAST_RANG;        // Le "RRN" reçoit la valeur du dernier rang

  FOR i=1 to Sflpag;  // Tantque i est inférieur à sflpag
    EXEC SQL Fetch C1 into :DSSFL1 ;
    IF sqlcode = 100;
      *IN90=*ON;   // "Fin" en bas à droite de l'écran et on sort.
      leave;
    ENDIF;

    RANG += 1;  // Incrémentation du compteur de ligne
    write Sfl1; // Ecrie le sous-fichier

  ENDFOR;

  IF RANG = *ZERO;
    *IN32 = *ON;
  ENDIF;
  LAST_RANG = RANG;

ENDSR;
```
