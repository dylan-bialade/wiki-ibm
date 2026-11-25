---
bibliotheque: BIB25
fichier_source: QWEBSRVTP
membre: ARTPGM
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 152
modifie: 2026-11-25
---

# BIB25/QWEBSRVTP/ARTPGM

```rpg
**free

// Option du programme
ctl-opt dftactgrp(*no) actgrp(*new);

// Déclaration de l'écran
dcl-f ARTDSPF workstn sfile(sfl1:rang);

// variables
dcl-s rang packed(4:0);

// services
dcl-s urlServiceGET varchar(256) inz('https://agrion.ORGFORM.fr:443/web/services/ARTICLE');
dcl-s entetes    varchar(256) inz('{"header":"Accept,application/json"}');

// Une ligne du JSON au format affichable
dcl-ds wARTICLE extname('WSARTICLE') qualified;
end-ds;

// Sortie du programme
*inlr = *on;

// Boucle d'affichage
DOW NOT *IN03;
    init();
    chargement();
    write bas;
    exfmt CTL1;
    clear message;
    // Gestion des options du sous fichier
ENDDO;



// Procédure interne
dcl-proc init;
    // Message non affichable
    *in50 = *on;
    // Gestion SFLCLEAR
    *in32 = *on;
    write CTL1;
    *in32 = *off;
    rang = 0;
end-proc;

dcl-proc chargement;
    dcl-s statut int(10);                    // code HTTP renvoyé par le service
    dcl-s corps  sqltype(CLOB : 65536);      // corps de la réponse (JSON)
    dcl-s detail varchar(50);                // détail de l'erreur renvoyé par le service

    // Pas de message par défaut : zone cachée (indicateur 50)
    MESSAGE = '';
    *in50 = *on;

    // 1. Appel du webservice : statut HTTP + corps de la réponse
    exec sql
       SELECT JSON_VALUE(RESPONSE_HTTP_HEADER, '$.HTTP_STATUS_CODE' RETURNING INTEGER),
              COALESCE(RESPONSE_MESSAGE, '')
         INTO :statut, :corps
         FROM TABLE(QSYS2.HTTP_GET_VERBOSE(:urlServiceGET, :entetes));

    // Erreur technique : serveur arrêté, URL fausse, certificat...
    if sqlcode < 0;
        afficherMessage('Service injoignable (SQLCODE ' + %char(sqlcode) + ')');
        finChargement();
        return;
    endif;

    // Erreur renvoyée par le service (4xx, 5xx)
    if statut <> 200;
        exec sql
           SET :detail = COALESCE(JSON_VALUE(:corps, '$.detail'), '');
        afficherMessage(detail);
        finChargement();
        return;
    endif;

    // 2. Découpage du tableau JSON reçu en lignes (plus d'appel HTTP ici)
   exec sql
      DECLARE C_ARTICLE CURSOR FOR
         SELECT J.CODE, J.LIBELLE, J.FAMILLE, J.PRIX_HT, J.TAUX_TVA, J.STOCK
           FROM JSON_TABLE(
                   :corps,
                   '$[*]'
                   COLUMNS(CODE     CHAR(6)        PATH '$.CODE',
                           LIBELLE  CHAR(30)       PATH '$.LIBELLE',
                           FAMILLE  CHAR(3)        PATH '$.FAMILLE',
                           PRIX_HT  DECIMAL(7, 2)  PATH '$.PRIXHT' ,
                           TAUX_TVA DECIMAL(4, 2)  PATH '$.TAUXTVA' ,
                           STOCK    INTEGER        PATH '$.STOCK' )
                ) AS J;

    exec sql OPEN C_ARTICLE;

    DOW 1 = 1;
        exec sql
        fetch C_ARTICLE INTO :wARTICLE.CODE ,  :wARTICLE.LIBELLE , :wARTICLE.FAMILLE,
                             :wARTICLE.PRIX_HT , :wARTICLE.TAUX_TVA , :wARTICLE.STOCK;

        if sqlcode = 100;
            leave;
        endif;

        // JSON illisible : on arrête, sinon la boucle tournerait sans fin
        if sqlcode < 0;
            afficherMessage('Réponse illisible (SQLCODE ' + %char(sqlcode) + ')');
            leave;
        endif;

        // Sous-fichier plein (9999 lignes maximum)
        if rang = 9999;
            afficherMessage('Liste tronquée à 9999 articles');
            leave;
        endif;

        // chargement du sous fichier
        rang += 1;
        code = wARTICLE.code;
        libelle = wARTICLE.libelle;
        prixht = wARTICLE.prix_ht;
        tva = wARTICLE.taux_tva;
        stock = wARTICLE.stock;

        WRITE SFL1;

    ENDDO;

    exec sql CLOSE C_ARTICLE;

    if rang = 0 and *in50;
        afficherMessage('Aucun article');
    endif;

    finChargement();
end-proc;

// Gestion des indicateurs SFL
dcl-proc finChargement;
    *in30 = (rang > 0);
    *in31 = *on;
    *in33 = *on;
end-proc;

// Affiche un message dans la zone MESSAGE de l'écran
dcl-proc afficherMessage;
    dcl-pi *n;
        texte varchar(100) const;
    end-pi;

    MESSAGE = texte;                         // tronqué à 50 caractères par l'écran
    *in50 = *off;
end-proc;
```
