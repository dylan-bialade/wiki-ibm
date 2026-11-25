---
bibliotheque: BIB25
fichier_source: QWEBSRVTP
membre: ARTPGME
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 95
modifie: 2026-11-25
---

# BIB25/QWEBSRVTP/ARTPGME

```rpg
**free
ctl-opt dftactgrp(*no) actgrp(*new);
dcl-f ARTDSPF workstn sfile(sfl1:rang);
dcl-s rang packed(4:0);
dcl-s urlServiceGET varchar(256) inz('https://agrion.ORGFORM.fr:443/web/services/ARTICLE');
dcl-s entetes    varchar(256) inz('{"header":"Accept,application/json"}');
dcl-ds wARTICLE extname('WSARTICLE') qualified;
end-ds;
dcl-s message varchar(78);

*inlr = *on;
DOW NOT *IN03;
    init();
    chargement();
    write bas;
    exfmt CTL1;
ENDDO;

dcl-proc init;
    *in32 = *on;
    write CTL1;
    *in32 = *off;
    rang = 0;
end-proc;

dcl-proc chargement;
    dcl-s statut int(10);
    dcl-s corps  sqltype(CLOB : 65536);
    dcl-s detail varchar(70);

    message = '';

    // 1. Appel du service : statut HTTP + corps de la reponse
    exec sql
       SELECT JSON_VALUE(RESPONSE_HTTP_HEADER, '$.HTTP_STATUS_CODE' RETURNING INTEGER),
              COALESCE(RESPONSE_MESSAGE, '')
         INTO :statut, :corps
         FROM TABLE(QSYS2.HTTP_GET_VERBOSE(:urlServiceGET, :entetes));

    // Erreur technique : serveur arrete, URL fausse, certificat...
    if sqlcode < 0;
        message = 'Service injoignable (SQLCODE ' + %char(sqlcode) + ')';
        return;
    endif;

    // Erreur renvoyee par le service : 4xx, 5xx
    if statut <> 200;
        exec sql
           SET :detail = COALESCE(JSON_VALUE(:corps, '$.detail'), '');
        message = 'HTTP ' + %char(statut) + ' ' + detail;
        return;
    endif;

    // 2. Decoupage du corps deja recu
    exec sql
       DECLARE C_ARTICLE CURSOR FOR
          SELECT J.CODE, J.LIBELLE, J.FAMILLE, J.PRIX_HT, J.TAUX_TVA, J.STOCK
            FROM JSON_TABLE(:corps, '$[*]'
                    COLUMNS(CODE     CHAR(6)        PATH '$.CODE',
                            LIBELLE  CHAR(30)       PATH '$.LIBELLE',
                            FAMILLE  CHAR(3)        PATH '$.FAMILLE',
                            PRIX_HT  DECIMAL(7, 2)  PATH '$.PRIXHT',
                            TAUX_TVA DECIMAL(4, 2)  PATH '$.TAUXTVA',
                            STOCK    INTEGER        PATH '$.STOCK')
                 ) AS J;
    exec sql OPEN C_ARTICLE;

    DOW 1 = 1;
        exec sql
        fetch C_ARTICLE INTO :wARTICLE.CODE, :wARTICLE.LIBELLE, :wARTICLE.FAMILLE,
                             :wARTICLE.PRIX_HT, :wARTICLE.TAUX_TVA, :wARTICLE.STOCK;
        if sqlcode = 100;
            leave;
        endif;
        if sqlcode < 0;
            message = 'Reponse illisible (SQLCODE ' + %char(sqlcode) + ')';
            leave;
        endif;
        rang += 1;
        code = wARTICLE.code;
        libelle = wARTICLE.libelle;
        prixht = wARTICLE.prix_ht;
        tva = wARTICLE.taux_tva;
        stock = wARTICLE.stock;
        WRITE SFL1;
    ENDDO;
    exec sql CLOSE C_ARTICLE;

    if rang = 0 and message = '';
        message = 'Aucun article';
    endif;
    *in30 = (rang > 0);
    *in31 = *on;
    *in33 = *on;
end-proc;
```
