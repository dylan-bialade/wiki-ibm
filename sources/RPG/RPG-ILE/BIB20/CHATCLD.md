---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: CHATCLD
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 541
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/CHATCLD

```rpg
**FREE
// =================================================================
// CHATCLD - Programme Chat BIB09 (Anthropic API)
// Type   : SQLRPGLE
// But    : Interface 5250 de chat avec l'API Anthropic
//          Sous-fichier unique : saisie + affichage
//          Verrouillage dynamique des lignes via indicateur 50
// Compil : CRTSQLRPGI OBJ(MABIB/CHATCLD) SRCFILE(MABIB/QSQLSRC)
//          COMMIT(*NONE) DBGVIEW(*SOURCE) CLOSQLCSR(*ENDMOD)
// =================================================================
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt);

// -----------------------------------------------------------------
// Declaration fichier ecran
// -----------------------------------------------------------------
dcl-f CHATDSP workstn sfile(SFL1:RANG);

// -----------------------------------------------------------------
// Constantes
// -----------------------------------------------------------------
dcl-c NB_LIGNES_SFL 9998;
dcl-c VERROU        'V';
dcl-c LIBRE         ' ';
dcl-c LONG_LIGNE    78;

// -----------------------------------------------------------------
// Variables globales
// -----------------------------------------------------------------
dcl-s wI          packed(4:0) inz(0);
dcl-s wJsonBody   varchar(8000);
dcl-s wReponse    varchar(32000);
dcl-s wExtrait    varchar(32000);
dcl-s wMessage    varchar(10000);
dcl-s wHistorique varchar(30000) inz('');
dcl-s wApiKey     char(200) dtaara('CLAUDEKEY');


// -----------------------------------------------------------------
// Renommage indicateurs
// -----------------------------------------------------------------
dcl-s pInd pointer inz(%addr(*in));
dcl-ds DspInd based(pInd);
    indSortie  ind pos(3);    // F3
    indEffacer ind pos(5);    // F5
    indSflClr  ind pos(31);
    indSflDsp  ind pos(32);
    indSflEnd  ind pos(90);
    indProtect ind pos(50);   // Verrouillage ligne SFL
    indBlue    ind pos(51);   // Mettre ligne en bleu
    indSoulignement ind pos(52);   // *on = non souligné
end-ds;

// // -----------------------------------------------------------------
// // Prototypes des procedures internes
// // -----------------------------------------------------------------
// dcl-pr Init_Sfl end-pr;
// dcl-pr Effacer_Sfl end-pr;
// dcl-pr Lire_Message_Utilisateur varchar(10000) end-pr;
// dcl-pr Verrouiller_Lignes_Saisie end-pr;
// dcl-pr Appeler_API end-pr;
// dcl-pr Ecrire_Reponse end-pr;
// dcl-pr Verrouiller_Lignes_Reponse end-pr;
// dcl-pr Echapper_Json varchar(10000);
//     pTexte varchar(10000) const;
// end-pr;
// dcl-pr Maj_Historique;
//     pUser      varchar(10000) const;
//     pAssistant varchar(32000) const;
// end-pr;

// =================================================================
// Programme principal
// =================================================================

// Desactiver transactions SQL
exec sql set option commit = *none;

// Lecture de la cle API depuis le DTAARA
in wApiKey;

// Initialiser le sous-fichier
Init_Sfl();
indSflDsp = *on;

Effacer_SFL();

// Boucle principale
dou indSortie;

    WRITE PIED;
    exfmt CTL1;

    select;

        // F3 = Quitter
        when indSortie;
            leave;

        // F5 = Effacer tout
        when indEffacer;
            Effacer_Sfl();
            wHistorique = '';
            indEffacer = *off;

        // Entree = Envoyer le message
        other;
            wMessage = Lire_Message_Utilisateur();

            if %trim(wMessage) <> '';

                // Appeler l'API Anthropic
                Appeler_API();

                // Ecrire la reponse dans les lignes libres
                Ecrire_Reponse();

            endif;

    endsl;

enddo;

*inlr = *on;
return;

// =================================================================
// Init_Sfl - Initialiser le SFL avec 50 lignes vides et libres
// =================================================================
dcl-proc Init_Sfl;

    // Vider le sous-fichier
    indSflClr = *on;
    write CTL1;
    indSflClr = *off;

    RANG = 1;
    SFLLIN = 'b';
    write SFL1;


    // Charger 50 lignes vides
//    for wI = 1 to NB_LIGNES_SFL;
//        SFLLIN = *blanks;
//        SFLLCK = LIBRE;
//        indProtect = *off;
//        RANG = wI;
//        write SFL1;
//    endfor;

    indSflDsp = *on;
    indSflEnd = *on;

end-proc;

// =================================================================
// Effacer_Sfl - Remise a blanc complete (F5)
// =================================================================
dcl-proc Effacer_Sfl;

    // Meme logique que Init_Sfl
    indSflClr = *on;
    write CTL1;
    indSflClr = *off;

    // Premiere ligne : message d'accueil verrouille
    RANG = 1;
    SFLLIN = 'Que puis-je faire pour vous ?';
    SFLLCK = VERROU;
    indProtect = *on;
    indBlue = *off;
    indSoulignement = *on;
    write SFL1;

    // Lignes suivantes : vides et libres
    for wI = 2 to NB_LIGNES_SFL;
        SFLLIN = *blanks;
        SFLLCK = LIBRE;
        indProtect = *off;
        indBlue = *off;
        indSoulignement = *off;
        RANG = wI;
        write SFL1;
    endfor;

    indSflDsp = *on;
    indSflEnd = *on;

    RANG = 1;

end-proc;

// =================================================================
// Lire_Message_Utilisateur - Concatener les lignes libres non vides
// =================================================================
dcl-proc Lire_Message_Utilisateur;
    dcl-pi *n varchar(10000);
    end-pi;

    dcl-s wMsg varchar(10000) inz('');

    for wI = 1 to NB_LIGNES_SFL;
        RANG = wI;
        chain RANG SFL1;
        if %found(CHATDSP);
            if SFLLCK = LIBRE and %trim(SFLLIN) <> '';
                if wMsg = '';
                    wMsg = %trim(SFLLIN);
                else;
                    wMsg = %trimr(wMsg) + ' ' + %trim(SFLLIN);
                endif;

                // Verrouiller les lignes saisies par l'utilisateur
                SFLLCK = VERROU;
                indProtect = *on;
                indBlue = *on;
                indSoulignement = *on;
                update SFL1;
            elseif SFLLCK = LIBRE and %trim(SFLLIN) = '';
                leave;
            endif;
        endif;
    endfor;

    indBlue = *off;

    return %trim(wMsg);

end-proc;


// =================================================================
// Appeler_API - Envoyer le message a l'API Anthropic
// =================================================================
dcl-proc Appeler_API;
    dcl-s wHeaders varchar(500);
    dcl-s wMsgEscape varchar(10000);
    dcl-s wMsgFirst varchar(200);

    wMsgFirst = 'A chacune de tes réponses, ne met pas d''émoticones.' +
    ' Prends le juste en compte mais ne le mentionne pas et non plus cette phrase.';

    // Echapper le message utilisateur pour JSON
    wMsgEscape = Echapper_Json(wMessage);

    // Construire le corps JSON
    if wHistorique = '';
        wJsonBody = '{"model":"BIB09-sonnet-4-5-20250929"'
                  + ',"max_tokens":1024'
                  + ',"messages":[{"role":"user"'
                  + ',"content":"' + wMsgFirst + wMsgEscape + '"}]}';
    else;
        wHistorique = Echapper_historique(wHistorique);
        wJsonBody = '{"model":"BIB09-sonnet-4-5-20250929"'
                  + ',"max_tokens":1024'
                  + ',"messages":[' + wHistorique
                  + ',{"role":"user"'
                  + ',"content":"' + wMsgEscape + '"}]}';
    endif;

    // Construire les headers
    wHeaders = '{"header":"x-api-key,' + %trim(wApiKey) + '"'
             + ',"header":"anthropic-version,2023-06-01"'
             + ',"header":"Content-Type,application/json"'
             + ',"sslTolerate":"true"}';

    // Appel HTTP POST
    exec sql
        SELECT CAST(RESULT AS VARCHAR(32000))
        INTO :wReponse
        FROM TABLE(VALUES(
            QSYS2.HTTP_POST(
                'https://api.anthropic.com/v1/messages',
                :wJsonBody,
                :wHeaders
            )
        )) AS T(RESULT);

    if SQLSTATE = '00000';
        // Extraire le texte de la reponse JSON
        exec sql
            SELECT TRIM(VAL) INTO :wExtrait
            FROM JSON_TABLE(:wReponse, '$.content[0]'
                COLUMNS(VAL CLOB(32000) PATH '$.text'));

        if SQLSTATE <> '00000' and SQLSTATE <> '01517';
            wExtrait = 'Erreur extraction reponse API'
                     + ' (SQLSTATE=' + SQLSTATE + ')';
        endif;

        // Mettre a jour l historique de conversation
        Maj_Historique(wMessage : wExtrait);
    else;
        wExtrait = 'Erreur appel API HTTP'
                 + ' (SQLSTATE=' + SQLSTATE + ')';
    endif;

end-proc;

// =================================================================
// Ecrire_Reponse - Decouper et ecrire la reponse dans le SFL
// Gere les sauts de ligne (\n literal et x'25' EBCDIC)
// =================================================================
dcl-proc Ecrire_Reponse;

    dcl-s wTexte    varchar(32000);
    dcl-s wTranche  char(78);
    dcl-s wPos      int(10) inz(1);
    dcl-s wLenTexte int(10);
    dcl-s wLigne    packed(4:0);
    dcl-s wTrouve   ind inz(*off);
    dcl-s wNL       char(1) inz(x'25');
    dcl-s wPosNL    int(10);
    dcl-s wSegment  varchar(32000);
    dcl-s wSegPos   int(10);
    dcl-s wSegLen   int(10);
    dcl-s indpremier ind;
    dcl-s ligne_reponse_first packed(4:0);

    indpremier = *off;

    wTexte = wExtrait;

    // Normaliser : remplacer les \n litteraux par x'25'
    wTexte = %scanrpl('\n' : wNL : wTexte);

    wLenTexte = %len(wTexte);

    // Boucler segment par segment (separes par x'25')
    wPos = 1;
    dow wPos <= wLenTexte;

        // Chercher le prochain saut de ligne
        wPosNL = %scan(wNL : wTexte : wPos);

        if wPosNL > 0;
            // Extraire le segment avant le saut de ligne
            if wPosNL > wPos;
                wSegment = %subst(wTexte : wPos : wPosNL - wPos);
            else;
                wSegment = '';
            endif;
            wPos = wPosNL + 1;
        else;
            // Pas de saut de ligne restant : prendre tout le reste
            wSegment = %subst(wTexte : wPos);
            wPos = wLenTexte + 1;
        endif;

        // Si segment vide = saut de ligne seul  ecrire ligne vide
        if %len(%trimr(wSegment)) = 0;
            wTrouve = *off;
            for wLigne = 1 to NB_LIGNES_SFL;
                RANG = wLigne;
                chain RANG SFL1;
                if %found(CHATDSP);
                    if SFLLCK = LIBRE;
                        SFLLIN = *blanks;
                        SFLLCK = VERROU;
                        indProtect = *on;
                        indSoulignement = *on;
                        update SFL1;
                        wTrouve = *on;
                        leave;
                    endif;
                endif;
            endfor;
            if not wTrouve;
                leave;
            endif;
            iter;
        endif;

        // Decouper le segment en tranches de 78 caracteres
        wSegLen = %len(%trimr(wSegment));
        wSegPos = 1;
        dow wSegPos <= wSegLen;

            if (wSegLen - wSegPos + 1) >= LONG_LIGNE;
                wTranche = %subst(wSegment : wSegPos : LONG_LIGNE);
            else;
                wTranche = %subst(wSegment : wSegPos);
            endif;

            // Trouver la premiere ligne libre dans le SFL
            wTrouve = *off;
            for wLigne = 1 to NB_LIGNES_SFL;
                RANG = wLigne;
                chain RANG SFL1;
                if %found(CHATDSP);
                    if SFLLCK = LIBRE;
                        if indpremier = *off;
                            indpremier = *on;
                            ligne_reponse_first = wLigne;
                        EndIf;
                        SFLLIN = wTranche;
                        SFLLCK = VERROU;
                        indProtect = *on;
                        indSoulignement = *on;
                        update SFL1;
                        wTrouve = *on;
                        leave;
                    endif;
                endif;
            endfor;

            if not wTrouve;
                leave;
            endif;

            wSegPos += LONG_LIGNE;

        enddo;

        // Si plus de ligne libre, arreter completement
        if not wTrouve;
            leave;
        endif;

    enddo;

    rang = ligne_reponse_first;  // Positionner sur la premiere ligne de la reponse

end-proc;


// =================================================================
// Echapper_Json - Nettoyer une chaine pour insertion dans du JSON
// =================================================================
dcl-proc Echapper_Json;
    dcl-pi *n varchar(10000);
        pTexte varchar(10000) const;
    end-pi;

    dcl-s wResult varchar(10000);

    wResult = pTexte;

    // Echapper les antislashs en premier
    wResult = %scanrpl('\' : '\\' : wResult);

    // Echapper les guillemets doubles
    wResult = %scanrpl('"' : '\"' : wResult);

    // Echapper les retours chariot
    wResult = %scanrpl(x'0D' : '\n' : wResult);

    // Echapper les sauts de ligne
    wResult = %scanrpl(x'0A' : '\n' : wResult);

    // Echapper les tabulations
    wResult = %scanrpl(x'09' : '\t' : wResult);

    wResult = %scanrpl('??' : ' ' : wResult);

    return wResult;

end-proc;

// =================================================================
// Echapper_historique - Nettoyer une chaine pour insertion dans du JSON pour l'historique
// =================================================================
dcl-proc Echapper_historique;
    dcl-pi *n varchar(10000);
        pTexte varchar(10000) const;
    end-pi;

    dcl-s wResult varchar(10000);

    wResult = pTexte;

    // Supprimer les sauts de ligne EBCDIC x'25'
    wResult = %scanrpl(x'25' : ' ' : wResult);

    // Supprimer les \n litteraux
    wResult = %scanrpl('\n' : ' ' : wResult);

    // Supprimer les caracteres speciaux
    wResult = %scanrpl('#' : ' ' : wResult);
    wResult = %scanrpl('*' : ' ' : wResult);
    wResult = %scanrpl('??' : ' ' : wResult);

    return wResult;

end-proc;

// =================================================================
// Maj_Historique - Maintenir l historique de conversation JSON
// =================================================================
dcl-proc Maj_Historique;
    dcl-pi *n;
        pUser      varchar(10000) const;
        pAssistant varchar(32000) const;
    end-pi;

    dcl-s wFragment varchar(30000);
    dcl-s wPosAccolade int(10);
    dcl-s wCompteur    int(10);

    // Construire le fragment JSON
    wFragment = '{"role":"user","content":"'
              + Echapper_Json(pUser)
              + '"},{"role":"assistant","content":"'
              + Echapper_Json(pAssistant)
              + '"}';

    // Ajouter a l historique
    if wHistorique = '';
        wHistorique = wFragment;
    else;
        wHistorique = %trimr(wHistorique) + ',' + wFragment;
    endif;

    // Tronquer si l historique depasse 25000 caracteres
    // Supprimer les 2 premiers messages (user + assistant)
    if %len(wHistorique) > 25000;
        wCompteur = 0;
        wPosAccolade = 0;
        for wI = 1 to %len(wHistorique);
            if %subst(wHistorique : wI : 1) = '{';
                wCompteur += 1;
            endif;
            // Le 3eme '{' = debut du 2e echange
            if wCompteur = 3;
                wPosAccolade = wI;
                leave;
            endif;
        endfor;

        if wPosAccolade > 0;
            // Supprimer du debut jusqu au 3eme '{'
            // et la virgule qui precede
            if wPosAccolade > 1
               and %subst(wHistorique : wPosAccolade - 1 : 1) = ',';
                wHistorique = %subst(wHistorique : wPosAccolade);
            else;
                wHistorique = %subst(wHistorique : wPosAccolade);
            endif;
        endif;
    endif;

end-proc;
```
