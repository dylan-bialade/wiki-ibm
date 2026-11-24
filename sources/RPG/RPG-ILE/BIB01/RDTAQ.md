---
bibliotheque: BIB01
fichier_source: QRPGLESRC
membre: RDTAQ
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 118
modifie: 2026-11-16
---

# BIB01/QRPGLESRC/RDTAQ

```rpg
**FREE
// -------------------------------------------------------------------
// Programme  :    RDTAQ
// Libellé    :    programme de lecture DTAQ
// -------------------------------------------------------------------
// Projet     :
// Auteur     : VNG
// Date       : 10/11/2023
// -------------------------------------------------------------------
// 10/03/2024 | AQU | TEDL-116
// Remplacement du HTTP_POST et ajout parametre d'entrée
// -------------------------------------------------------------------
// Fin de traitement en inserant *FIN dans la DTAQ  exemple :
// call qsys2.send_data_queue(
//  message_data       => '*FIN',
//  data_queue         => 'POST_LITE',
//  data_queue_library => 'MAX');
// -------------------------------------------------------------------

Ctl-Opt COPYRIGHT('(C) ORGFORM 2023.') USRPRF(*OWNER) OPTIMIZE(*none)
DFTACTGRP(*NO) ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO)
ALLOC(*STGMDL) STGMDL(*INHERIT) THREAD(*SERIALIZE);

// -------------------------------------------------------------------//
//  Paramètres en entrée                                              //
// -------------------------------------------------------------------//
Dcl-pi *N;
  P_Bib  char(10);    // Bibliotheque de la DTAQ
  P_Dtaq char(10);    // Nom de la DTAQ
End-pi;

// -------------------------------------------------------------------
// Declaration Variables
// -------------------------------------------------------------------
Dcl-s wtxt char(10000);
Dcl-S API_RESPONSEMSG sqltype(CLOB:1048576);
Dcl-S API_RESPONSEHTTPHEADER sqltype(CLOB:1048576);
Dcl-s indNull int(5);

Dcl-ds DtaqActif extname('DTAQACTIF');
End-Ds;
// -------------------------------------------------------------------
// Consignes de compilation SQL
// -------------------------------------------------------------------
// Gestion du contrôle de validation, des performances, etc ...
EXEC SQL
  SET OPTION COMMIT = *NONE, ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD,
  DYNUSRPRF = *OWNER, DATFMT = *ISO, TIMFMT = *ISO, DLYPRP = *YES;

// -------------------------------------------------------------------
// Initialisation
// -------------------------------------------------------------------
// Controle des parametres d'entrées
*InLr = (%Parms() <> 2);

// Initialisation des paramètres
Exec SQL
Select *
 Into  :DtaqActif
 From  DTAQACTIF
 where Bib_Dtaq = :P_Bib And Nom_Dtaq = :P_Dtaq
 Fetch first 1 rows only;

*InLr = (SqlCod <> *zero);

Dow (Not *InLr);
  // Lecture DTAQ avec la fonction QSYS2.RECEIVE_DATA_QUEUE()
  Exec SQL
  SELECT MESSAGE_DATA
  into :wtxt
  FROM table (
  qsys2.receive_data_queue(
  data_queue => :Nom_Dtaq,
  data_queue_library => :Bib_Dtaq,
  wait_time => -1));
  *InLr = (SqlCod <> *zero);

  // Récupération des paramètres pour DTAQ
  Exec SQL
  Select *
  Into  :DtaqActif
  From  DTAQACTIF
  where Bib_Dtaq = :P_Bib And Nom_Dtaq = :P_Dtaq
  Fetch first 1 rows only;
  *InLr = (SqlCod <> *zero);

  // Test de fin si la DTAQ est initialisé à *OFF
  // ou la DTAQ est inactive dans la table DTAQACTIF
  If wtxt = '*FIN'
    or (Dtaq_Actif <> '1' );
    *InLr = *On;
    Leave;
  Endif;

  // Traitement
  if sqlcode = 0;
    // Envoi en HTTP POST au serveur LITESOFT
    Exec SQL
    SELECT RESPONSE_MESSAGE , RESPONSE_HTTP_HEADER
      INTO :API_RESPONSEMSG:indNull, :API_RESPONSEHTTPHEADER
      FROM TABLE ( QSYS2.HTTP_POST_VERBOSE (
      :Url_Api,
      :wtxt,
      json_object('header' value 'content-type,application/json',
            'header' value 'content-length, ' concat length(trim(:wtxt)))
    )) AS HTTPDATA
    FETCH FIRST ROW ONLY ;

    // Insert dans la Table de Log
    Exec SQL
    insert into CONSO_API
    (ENDPOINT, IN_DATA, OUT_RESPONSEMSG, OUT_RESPONSEHTTPHEADER)
    VALUES
    (:Url_Api, :wtxt, :API_RESPONSEMSG, :API_RESPONSEHTTPHEADER);
  Endif;
Enddo;

*INLR = *On;
```
