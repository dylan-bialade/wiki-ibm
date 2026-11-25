---
bibliotheque: BIB27
fichier_source: QRPGLESRC
membre: USERAPI
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 320
modifie: 2026-11-25
---

# BIB27/QRPGLESRC/USERAPI

```rpg
**FREE
CTL-OPT COPYRIGHT('(C) ORGFORM 2024.') OPTION(*SRCSTMT) DFTACTGRP(*NO) ACTGRP(*CALLER)
OPTIMIZE(*NONE);

//*****************************************************************
// Programme : USERAPI
// Date      - 07/05/2024
// Copyright - ORGFORM
//*****************************************************************

//**********************************************************************//
// Déclaration des fichiers                                             //
//**********************************************************************//
DCL-F SFUSERDSPF WORKSTN SFILE(SFL1:RANG); // Sources dans QDDSSRC

//**********************************************************************//
// Déclaration des variables                                            //
//**********************************************************************//
DCL-S LAST_RANG ZONED(4:0)   INZ(*ZERO);
DCL-S i         ZONED(4:0)   INZ(*ZERO);
DCL-S rqt       VARCHAR(255) INZ(*BLANK);
DCL-S rqtcast   VARCHAR(255) INZ(*BLANK);

//**********************************************************************//
// Déclaration des constantes                                           //
//**********************************************************************//
DCL-C SflPag    CONST(12);   // Nombre de ligne à afficher par page ...
DCL-C Supprimer CONST('4');  // Option 4 Supprimer
DCL-C Modifier  CONST('2');  // Option 2 Modifier

// Coder **ici**
// Remplacer le Token par votre Token
// Replacer ça 4351191126d6eeb8e576b79d24e6028f603194de443e3d1a1fec8b5796dd8e74
DCL-C UrlFull   CONST('https://gorest.co.in/public/v2/users?access-token+
=151ad7b69c61e1ee94d7907eac7c9b2babc0fad3017ee7582a069ff141d6aa2f');
DCL-C Token     CONST('?access+
                -token=151ad7b69c61e1ee94d7907eac7c9b2babc0fad3017ee7582a069ff141d6aa2f');
DCL-C Url       CONST('https://gorest.co.in/public/v2/users/');
DCL-C header    CONST('<httpheader><header name="Content-Type" value="application/x-www-form-urlencoded"/>+
                 <httpheader>');


// DS format d'écran SFL1 Affichage   GET
DCL-DS DSSFL1;
  E1IDUSER       char(20);
  E1NAME         char(20);
  E1STATUS       char(20);
  E1GENDER       char(20);
  E1EMAIL        char(30);
END-DS;

// DS format d'écran FMT2 Modificiation  PUT
DCL-DS DSSFL2;
  E2IDUSER       char(20);
  E2NAME         char(20);
  E2STATUS       char(20);
  E2GENDER       char(20);
  E2EMAIL        char(30);
END-DS;

// DS format d'écran FMT4  Suppression  DELETE
DCL-DS DSSFL4;
  E4IDUSER       char(20);
  E4NAME         char(20);
  E4STATUS       char(20);
  E4GENDER       char(20);
  E4EMAIL        char(30);
END-DS;

// DS format d'écran FMT6  Création POST
DCL-DS DSSFL6;
  E6IDUSER       char(20);
  E6NAME         char(20);
  E6STATUS       char(20);
  E6GENDER       char(20);
  E6EMAIL        char(30);
END-DS;


//**********************************************************************//
// Traitement pricipale                                                 //
//**********************************************************************//
*Inlr = *On;
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
  WHEN *IN06; // F6=Création
    EXSR creation;
    EXEC SQL close C1;
    EXSR Initialisation_sous_fichier;
    EXSR Fabrication_sous_fichier;
  OTHER; // La touche ENTRER
    EXSR trt_readc;  // on fait un readc seulement s'il y a des données
    EXEC SQL close C1;
    EXSR Initialisation_sous_fichier;
    EXSR Fabrication_sous_fichier;
  ENDSL;

ENDDO;

EXEC SQL close C1;

//************************************************************************
// Initialisation du sous fichier - //
//************************************************************************
BEGSR Initialisation_sous_fichier;
  RANG = *ZERO;      // Initialisation du compteur d'enregistrement.
  LAST_RANG = *ZERO; // Initialisation du dernier rrn d'enregistrement.
  *In31 = *ON;       // Activation de l'indicateur de vidage de SFL (Associé au mot clé SFLCLR)
  Write Sf1ctl;      // Vidage du sous-fichier
  *In31 = *OFF;      // Désactivation de l'indicateur de vidage de SFL (Associé au mot clé SFLCLR)
  *In32 = *OFF;      // Désactivation de l'indicateur de vidage de SFL (Associé au mot clé SFLDSP)
  *In90 = *OFF;      // Désactivation de l'indicateur de vidage de SFL (Associé au mot clé SFLEND)

  // Déclaration d'un curseur SQL pour récupérer des données via une requête HTTP
  EXEC SQL
        Declare C1 CURSOR FOR
        (select * from json_table(systools.HTTPGETCLOB(
          cast(:UrlFull as varchar(255)),
          cast(null as clob(1k)
             )),
     '$'
          COLUMNS(
           // Ajouter les colonnes nécessaires ici
           // ** coder ici **
           idUser varchar(20) PATH '$.id',
           name varchar(20) PATh '$.name',
           status varchar(20) PATH '$.status',
           gender varchar(20) PATH '$.gender',
           email varchar(30) PATH '$.email'

         )
        ) order by idUser) FOR READ ONLY OPTIMIZE FOR 10 ROWS;

  // Ouverture du curseur pour commencer à traiter les lignes
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


//******************************************************************
// Traitement du READC                                            //
//******************************************************************
BEGSR TRT_READC;
  Readc Sfl1;
  DOW NOT %eof;
    SELECT;
    WHEN OPT = Supprimer;  // Option 4 Supprimer
      EXSR suppression;
    WHEN OPT = Modifier;   // Option 2 Modifier
      EXSR modification;
    ENDSL;
    Readc Sfl1;
  ENDDO;
ENDSR;

//************************************************************************
// Créer    - POST                                                      //
//************************************************************************
BEGSR creation;
  DOU *IN03;
    EXFMT FMT6;
    SELECT;
    WHEN *IN03;
      iter;
    WHEN *IN12;
      leave;
    WHEN *IN23;
      rqtcast = *blank;
      rqtcast = %trim('{"name":'+ '"' + %trim(E6NAME) + '"' +
      ',"gender":'+ '"' +%trim(E6GENDER)+ '"' + ',"email":'+
          '"' + %trim(E6EMAIL) +'"'+ ',"status":' +'"' + %trim(E6STATUS)
          + '"' +'}');
      EXEC SQL
         // Coder **ici**
         select * into :DSSFL6 from json_table(systools.HTTPPOSTCLOB(
           cast(:UrlFull as varchar(255)),
           cast(:header as clob(1k)),
           cast(:rqtcast as clob(10k))
           ));
      leave;
    ENDSL;
  ENDDO;
  clear OPT; // Remise à blanc de l'option saisie
ENDSR;


//************************************************************************
// Modifier  - PUT                                                           //
//************************************************************************
BEGSR modification;
  EXEC SQL
  select  * into :DSSFL2  from json_table( systools.HTTPGETCLOB (
      cast(:UrlFull   as varchar(255)),
      cast(null as clob(1k)
             )),
     '$'
          COLUMNS(
           idUser CHAR(20) PATH '$.id' ,
           name   CHAR(20) PATH '$.name',
           status CHAR(20) PATH '$.status',
           gender CHAR(20) PATH '$.gender',
           email  CHAR(30) PATH '$.email'
         )
        ) where iduser = :DSSFL1.E1IDUSER;


  DOU *IN03;
    EXFMT FMT2;
    SELECT;
    WHEN *IN03;
      iter;
    WHEN *IN12;
      leave;
    WHEN *IN23;
      rqt = *blank;
      rqtcast = *blank;
      rqt = %trim(Url+ %trim(E1IDUSER)+
                  Token);
      rqtcast = %trim('{"name":'+ '"' + %trim(E2NAME) + '"' +
      ',"gender":'+ '"' +%trim(E2GENDER)+ '"' + ',"email":'+
          '"' + %trim(E2EMAIL) +'"'+ ',"status":' +'"' + %trim(E2STATUS)
          + '"' +'}');
      EXEC SQL
         // Coder **ici**
         select * from TABLE(systools.HTTPPUTCLOBVERBOSE(
           cast(UrlFull as varchar(255)),
           cast(header as clob(1k)),
           cast(rqtcast as clob(10k))
           ));
      leave;
    ENDSL;
  ENDDO;
  clear OPT; // Remise à blanc de l'option saisie
  Update Sfl1;  // Mets à jour le Sous-fichier
ENDSR;

//************************************************************************
// Supprimer - DELETE                                                           //
//************************************************************************
BEGSR suppression;
  EXEC SQL
   select  * into :DSSFL4  from json_table( systools.HTTPGETCLOB (
        cast(:UrlFull as varchar(255)),
        cast(null as clob(1k)
               )),
       '$'
            COLUMNS(
             idUser CHAR(20) PATH '$.id' ,
             name   CHAR(20) PATH '$.name',
             status CHAR(20) PATH '$.status',
             gender CHAR(20) PATH '$.gender',
             email  CHAR(30) PATH '$.email'
           )
          ) where iduser = :DSSFL1.E1IDUSER;
  EXFMT FMT4 ;
  clear OPT; // Remise à blanc de l'option saisie
  IF *IN23; // Si F23 on active le delete
    rqt = *blank;
    rqtcast = *blank;
    rqt = %trim(Url + %trim(E1IDUSER)+
            Token);
    EXEC SQL
    select  * into :DSSFL4 from json_table( systools.HTTPDELETECLOB (
       cast(:rqt as varchar(255)),
       cast(null as clob(1k)
              )),
      '$'
           COLUMNS(
           // Coder **ici**
          )
         );
  ENDIF;
  Update Sfl1;   // Mets à jour le Sous-fichier
ENDSR;
```
