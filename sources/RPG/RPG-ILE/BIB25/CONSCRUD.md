---
bibliotheque: BIB25
fichier_source: QWEBSRV
membre: CONSCRUD
type: RPG/RPG-ILE
longueur_enregistrement: 112
lignes: 117
modifie: 2026-11-25
---

# BIB25/QWEBSRV/CONSCRUD

```rpg
**free                                                                                                  //======
============================================================================================    // Programme   :
 CONSCRUD                                                                               // Objet       : Consomm
ation du webservice REST IWS GET_ORGFORM (serveur WEBSRVFLG)                    //               et affichage pa
r DSPLY de chaque ligne récupérée.                                      // Auteur      : L. BIB27 - ORGFORM Gr
oup                                                             //----------------------------------------------
----------------------------------------------------    // Principe (cf. doc « Consommer un webservice sur l'IBM
 i ») :                                         //   - QSYS2.HTTP_GET appelle le service et renvoie le corps JSO
N :                                     //       [{"ID":1,"NOM":"...","PRENOM":"...","SPORT":"..."}, ...]
                                //   - JSON_TABLE découpe ce tableau en lignes ('$[*]' = chaque élément du table
au)                     //     et chaque colonne est extraite par son PATH ('$.ID', '$.NOM'...).
                //   - Colonnes en DECIMAL / CHAR (et non INT / VARCHAR) pour un affichage 5250 direct.
        //   - Un curseur parcourt les lignes et chacune est affichée par DSPLY (52 caractères max).
//                                                                                                      // URL a
ppelée : http://localhost:10057/web/services/GET_ORGFORM                                        //   (appel depu
is l'IBM i lui-même : localhost = AGRION ; port 10057 = Listen de WEBSRVFLG)            //
                                                                                // Compilation :
                                                                        //   CRTSQLRPGI OBJ(BIB25/CONSCRUD) S
RCFILE(BIB25/QWEBSRV) SRCMBR(CONSCRUD)                       //              OBJTYPE(*PGM) COMMIT(*NONE) DBGV
IEW(*SOURCE) REPLACE(*YES)                              // Appel (session 5250 interactive) :
                                                //   CALL BIB25/CONSCRUD
                                        //======================================================================
============================    ctl-opt dftactgrp(*no) actgrp(*new)
                                main(main)
                        datfmt(*iso) timfmt(*iso);

exec sql set option commit = *none,
            naming = *sys,
    closqlcsr = *endmod;
                                                                                // URL du webservice et en-tête
HTTP demandant une réponse JSON                                         // (variables et non constantes : une co
nstante RPG ne peut pas servir de variable hôte SQL)            dcl-s urlService varchar(256) inz('https://agrio
n.ORGFORM.fr/web/services/GET_ORGFORM');                  dcl-s entetes    varchar(256) inz('{"header":"Accept,app
lication/json", +                               "basicAuth":"WSCRUD,WSCRU26websrv!%"}');

                                // Une ligne du JSON, au format affichable
                        dcl-ds ORGFORM_t qualified template;
                   id      packed(5:0);
           nom     char(20);
   prenom  char(20);                                                                                       sport
   char(20);                                                                                    end-ds;


                                                                        //======================================
============================================================    // Procédure principale
                                                        //======================================================
============================================    dcl-proc main;

                                   dcl-ds ligne   likeds(ORGFORM_t);
                           dcl-s  indSpr  int(5);                 // SPORT peut être null dans le JSON
                   dcl-s  texte   char(52);               // DSPLY affiche 52 caractères au maximum
           dcl-s  nbLig   int(10) inz(0);
                                                                                                           // Ap
pel du webservice + découpage du tableau JSON en lignes                                            exec sql
                                                                                              DECLARE C_ORGFORM
CURSOR FOR                                                                               SELECT J.ID, J.NOM, J.P
RENOM, J.SPORT                                                                     FROM JSON_TABLE(
                                                                                   QSYS2.HTTP_GET(:urlService, :
entetes),                                                                  '$[*]'
                                                                   COLUMNS(ID      DECIMAL(5, 0) PATH '$.ID',
                                                                   NOM     CHAR(20)      PATH '$.NOM',
                                                           PRENOM  CHAR(20)      PATH '$.PRENOM',
                                                   SPORT   CHAR(20)      PATH '$.SPORT')
                                ) AS J;

   exec sql OPEN C_ORGFORM;                                                                                if sq
lcode < 0;                                                                                            afficherEr
reur('OPEN');                                                                                 return;
                                                                                   endif;

                                                                   dsply 'ID    NOM        PRENOM     SPORT';

                                                   dow 1 = 1;
                                              exec sql
                                         FETCH C_ORGFORM INTO :ligne.id, :ligne.nom, :ligne.prenom, :ligne.sport
 :indSpr;
                      if sqlcode = 100;
                 leave;
      endif;
                                                                                                      if sqlcode
 < 0;                                                                                            afficherErreur(
'FETCH');                                                                                leave;
                                                                              endif;

                                                              if indSpr < 0;
                                                         ligne.sport = '-';
                                              endif;

                              // Mise en forme : ID sur 5 + NOM, PRENOM, SPORT séparés par un blanc
                      texte = %editc(ligne.id : 'X') + ' '
                    + %trim(ligne.nom) + ' '
            + %trim(ligne.prenom) + ' '
    + %trim(ligne.sport);                                                                             dsply text
e;                                                                                            nbLig += 1;
                                                                                   enddo;

                                                                   exec sql CLOSE C_ORGFORM;

                                                   texte = %char(nbLig) + ' ligne(s) recue(s) de GET_ORGFORM';
                                           dsply texte;

                        end-proc;


//==================================================================================================    // Affic
he le SQLCODE / SQLSTATE d'une erreur SQL (service arrêté, URL erronée, JSON invalide...)       //==============
====================================================================================    dcl-proc afficherErreur;
                                                                                   dcl-pi *n;
                                                                              etape  varchar(10) const;
                                                                   end-pi;

                                                   dcl-s texte char(52);

                                   texte = 'Erreur ' + etape + ' SQLCODE ' + %char(sqlcode)
                                 + ' SQLSTATE ' + sqlstate;
                   dsply texte;
        end-proc;
```
