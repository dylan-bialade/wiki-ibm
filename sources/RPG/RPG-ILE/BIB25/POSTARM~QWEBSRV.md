---
bibliotheque: BIB25
fichier_source: QWEBSRV
membre: POSTARM
type: RPG/RPG-ILE
longueur_enregistrement: 114
lignes: 104
modifie: 2026-11-25
---

# BIB25/QWEBSRV/POSTARM

```rpg
**free                                                                                                  //========
=====================================================================                         // Programme : POSTA
RM                                                                                  // Objet     : Consommation du
 webservice REST IWS POST_ORGFORM (WEBSRVFLG)                             //             saisie par DSPLY, envoi e
n POST, affichage du résultat.                                  // Auteur    : L. BIB27 - ORGFORM Group
                                                      //----------------------------------------------------------
-------------------                         // Principe :
                                  //   1. DSPLY demande ID, NOM, PRENOM et SPORT (SPORT à blanc = aucun).
                        //   2. JSON_OBJECT fabrique le corps {"ID":..,"NOM":"..","PRENOM":"..",..}
              //      (SPORT vide -> NULL -> clé absente grâce à ABSENT ON NULL).
    //   3. QSYS2.HTTP_POST_VERBOSE envoie le POST et renvoie :                                             //
    RESPONSE_HTTP_HEADER : en-têtes JSON, dont HTTP_STATUS_CODE                                   //        RESPON
SE_MESSAGE     : corps (vide si 201, erreur JSON sinon)                                 //   4. DSPLY affiche le c
ode HTTP et le message éventuel.                                              //
                                                                    // URL     : http://localhost:10057/web/servic
es/POST_ORGFORM                                           // En-tête : Content-Type: application/json (obligatoire
 pour un POST JSON)                             //
                                      // Compilation :
                            //   CRTSQLRPGI OBJ(BIB25/POSTARM) SRCFILE(BIB25/QRPGLESRC)
                  //              SRCMBR(POSTARM) OBJTYPE(*PGM) COMMIT(*NONE)
        //              DBGVIEW(*SOURCE) REPLACE(*YES)                                                          //
 Appel (session 5250 interactive) : CALL BIB25/POSTARM                                             //==========
===================================================================                         ctl-opt dftactgrp(*no)
 actgrp(*new)                                                                             main(main);

                                                              exec sql set option commit = *none,
                                                                        naming = *sys;


                      dcl-proc main;

     // Webservice appelé                                                                                    dcl-s
 url      varchar(256)
inz('http://localhost:10057/web/services/POST_ORGFORM');                                 dcl-s entetes  varchar(25
6)                                                                                            inz('{"header":"Cont
ent-Type,application/json"}');
                                                           // Saisies DSPLY
                                                 dcl-s saisie   char(20);
                                       dcl-s id       packed(5:0);
                             dcl-s nom      varchar(20);
                   dcl-s prenom   varchar(20);
         dcl-s sport    varchar(20);
                                                                                                       // Requête
et réponse HTTP                                                                              dcl-s corps    varcha
r(1000);                                                                           dcl-s statut   int(10);
                                                                         dcl-s reponse  varchar(1000);
                                                               dcl-s indRep   int(5);         // corps de réponse
NULL (cas du 201)                                    dcl-s texte    char(52);       // DSPLY : 52 caractères au ma
ximum
                                 // 1. Saisie des zones
                       dsply 'ID (numerique > 0) ?' '' saisie;
             monitor;
      id = %dec(%trim(saisie) : 5 : 0);                                                                    on-erro
r;                                                                                                  dsply 'ID non
numerique : abandon';                                                                     return;
                                                                             endmon;

                                                         dsply 'NOM ?' '' saisie;
                                               nom = %trim(saisie);

                           dsply 'PRENOM ?' '' saisie;
                 prenom = %trim(saisie);
                                                                                                               dsp
ly 'SPORT ? (blanc = aucun)' '' saisie;                                                              sport = %trim
(saisie);
                                                                                 // 2. Corps JSON construit par DB
2                                                                      exec sql
                                                                SET :corps = JSON_OBJECT(KEY 'ID'     VALUE :id,
                                                                               KEY 'NOM'    VALUE :nom,
                                                                     KEY 'PRENOM' VALUE :prenom,
                                                           KEY 'SPORT'  VALUE NULLIF(:sport, '')
                                                 ABSENT ON NULL);

 // 3. Appel du webservice                                                                               exec sql
                                                                                                  SELECT JSON_VALU
E(RESPONSE_HTTP_HEADER, '$.HTTP_STATUS_CODE'                                                              RETURNIN
G INTEGER),                                                                          CAST(RESPONSE_MESSAGE AS VARC
HAR(1000))                                                            INTO :statut, :reponse :indRep
                                                            FROM TABLE(QSYS2.HTTP_POST_VERBOSE(:url, :corps, :ente
tes));
                                   if sqlcode < 0;
                            texte = 'Erreur SQL ' + %char(sqlcode) + ' SQLSTATE ' + sqlstate;
                  dsply texte;
        return;                                                                                              endif
;
                                                                                         // 4. Résultat
                                                                               if statut = 201;
                                                                        texte = 'HTTP 201 : ID ' + %char(id) + ' c
ree';                                                         dsply texte;
                                                 else;
                                          texte = 'HTTP ' + %char(statut) + ' : echec';
                                dsply texte;
                      // ex. {"error":"CONFLICT","detail":"ID 5 deja existant"}
            // affiché en 2 DSPLY s'il dépasse 52 caractères
  if indRep >= 0 and reponse <> '';                                                                          texte
 = reponse;                                                                                        dsply texte;
                                                                                         if %len(reponse) > 52;
                                                                                  texte = %subst(reponse : 53);
                                                                        dsply texte;
                                                           endif;
                                              endif;
                                 endif;

          end-proc;
```
