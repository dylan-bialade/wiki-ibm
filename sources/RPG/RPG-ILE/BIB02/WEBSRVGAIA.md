---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: WEBSRVGAIA
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 212
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/WEBSRVGAIA

```rpg
**free

// Appel Web Service Joor - création des articles
// ============================================================================

// ============================================================================
// !! Attention au CCSID du travail !!
// Ne doit pas être 65535 (HEX)
// ============================================================================



// Options de compilation
// -----------------------------------------------------------------------------
ctl-opt OPTION(*SRCSTMT) DFTACTGRP(*NO)
ACTGRP(*CALLER) DATFMT(*ISO) ALLOC(*STGMDL)
STGMDL(*INHERIT) THREAD(*SERIALIZE) OPTIMIZE(*FULL) ;

// inclusion définition des paramètres
//include WS_Createpr

// Paramètres
// -----------------------------------------------------------------------------
dcl-pi *n ;
  P_token           varchar(1200) const ;
  p_codeErreur      char(3)           ;
  p_libelleErreur   char(80)          ;
end-pi ;



// Constantes
// -----------------------------------------------------------------------------
dcl-c CODE_RET_OK              const('OK ') ;
dcl-c CODE_RET_ERREUR          const('ERR') ;

// Variables globales
// -----------------------------------------------------------------------------

// Endpoint du web service
dcl-s g_endpoint varchar(128)
                 inz('https://apisandbox.jooraccess.com/v4/products/bulk_create?account="714791"') ;

// Données à envoyer au web service
dcl-s g_dataWS       sqltype(clob : 20000) inz ;
// Données reçues du web service
dcl-s g_resultatWS   sqltype(clob : 1000000) inz ;

// Option SQL
// -----------------------------------------------------------------------------
exec sql set option commit=*none, alwcpydta = *optimize, closqlcsr = *endmod, datfmt=*iso;

// Corps du programme
// -----------------------------------------------------------------------------

// Paramètres en sortie
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
p_codeErreur = CODE_RET_OK ;
clear p_libelleErreur ;

// Paramètres en entrée
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if not check_input() ;
  p_codeErreur = CODE_RET_ERREUR ;
  return ;
endif ;

// Construction des données à envoyer au service
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if not prepare_data() ;
  p_codeErreur = CODE_RET_ERREUR ;
  p_libelleErreur = 'Erreur dans la constitution des données' ;
  return ;
endif ;

// Appel du service
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if not call_WS() ;
  p_codeErreur = CODE_RET_ERREUR ;
  p_libelleErreur = 'Erreur dans l''appel du service web' ;
  return ;
endif ;

// Extraction des valeurs utiles dans les données de retour du service
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if not parse() ;
  p_codeErreur = CODE_RET_ERREUR ;
  p_libelleErreur = 'Erreur lors de l''extraction des valeurs' ;
  return ;
endif ;


// Fin
// -----------------------------------------------------------------------------
return ;

// ============================================================================
// Sous procédures
// ============================================================================

// Controle des paramètres en entrée
// -----------------------------------------------------------------------------
dcl-proc check_input ;
  dcl-pi *n ind ;
  end-pi ;

  if P_token = *blanks ;
    p_libelleErreur = 'token obligatoire' ;
    return *off ;
  ENDIF;

  // Controles OK !
  return *on;

end-proc ;




// Préparer les données à envoyer au web service
// -----------------------------------------------------------------------------
dcl-proc prepare_data ;
  dcl-pi *n ind ;
  end-pi ;

  // Constitution du flux JSON
  exec sql set :g_dataWS =
   json_array(json_object(
        'name' value 'TESTDT',
        'external_id' value '99999',
        'product_identifier' value 'FUR' ,
        'description' value 'Test cration 20032023',
        'order_minimum' value 5,
        'category_ids' value json_array('A'),
        'product_trait_values' value json_array(json_object(
            'trait_id' value 'iddttest',
            'trait_name' value 'test de dt',
            'value' value 'A value',
            'external_id' value '1323413')),
         'tags' value json_array(json_object(
            'name' value 'Tag A',
            'value' value 'Fur',
            'code' value '3',
            'parent_id' value '1')))) ;

  // Fin OK ?
  return SqlCode >= 0  ;
end-proc ;



// Appel du web service
// -----------------------------------------------------------------------------
dcl-proc call_WS ;
  dcl-pi *n ind ;
  end-pi ;

  // Variables locales
  dcl-s l_httpHeader sqltype(CLOB:10000) inz ;
  dcl-s l_codeHTTP int(10) inz;
  dcl-s l_Authorization varchar(1200) ;

  l_Authorization = 'Authorization, Bearer ' + %trim(P_token) ;
  exec sql
    select w.RESPONSE_MESSAGE,
       w.RESPONSE_HTTP_HEADER,
       h.code_http
    into :g_resultatWS,
     :l_httpHeader,
     :l_codeHTTP
    from table(
   qsys2.http_post_verbose( :g_endpoint,
                            :g_dataWS ,
      json_object( 'header' value 'Content-Type, application/json',
                   'header' value :l_Authorization
                   )))
       as w
    cross join
     json_table(w.RESPONSE_HTTP_HEADER , '$' columns (
        code_HTTP integer path '$.HTTP_STATUS_CODE')) as h
        ;

  // Fin OK ?
  if SqlCode < 0 or l_codeHTTP <> 200 ;
    return *off ;
  endif ;
  return *on ;

end-proc ;


// Extraction des valeurs
// -----------------------------------------------------------------------------
dcl-proc parse ;
  dcl-pi *n ind ;
  end-pi ;

  // variables locales

  // Corps

  //exec sql
  //  select Token into :p_Token from
  //    json_table( :g_resultatWS , '$' columns (
  //    Token varchar(2000) path '$.access_token')) ;
  //
  //  if SqlCode < 0 ;
  //    return *off ;
  //  endif ;
  //
  return *on ;
end-proc ;
```
