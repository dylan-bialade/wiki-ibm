---
bibliotheque: BIB02
fichier_source: QTESTSRC
membre: APILUCAS
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 309
modifie: 2026-11-16
---

# BIB02/QTESTSRC/APILUCAS

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO)
       ALWNULL(*USRCTL);

       DCL-F ECRANAPI WORKSTN SFILE(SFL1:RANG);

       DCL-C SFLPAG CONST(13);   // NOMBRE DE LIGNE à AFFICHER PAR PAGE ...
       DCL-C SUPPRIMER CONST('4');
       DCL-C MODIFIER CONST('2');

       DCL-S LAST_RANG PACKED(4:0) INZ(0);     // DERNIER RRN ÉCRIT AVANT PAGINATION ...
       DCL-S I      PACKED(4:0) INZ(0);
       DCL-S url varchar(255) inz('https://gorest.co.in/public/v2/users/');
       DCL-S token varchar(255);
       DCL-S lien varchar(255);
       DCL-S id varchar(255);
       DCL-S header varchar(255);
       DCL-S headerP varchar(255);
       DCL-S body varchar(255);
       dcl-s aro char(1); // @
       dcl-s acco_o char(1); // {
       dcl-s acco_f char(1); // }
       dcl-s espace char(1); // espace

       //attribution des caractères spéciaux en hexa
       aro = X'44'; // @
       acco_o = X'51'; // {
       acco_f= X'54';  // }
       espace = X'40'; //espace

       //clé d'authentification
       token  = '63c85ea7e12e1aaad421b61c05cd62459c989';
       token += 'fd587d372da3aaa3a94a6ec1ee3';

       //header pour uniquement le get et delete
       header = '<httpHeader>';
       header += '<header name="Authorization" value="Bearer ';
       header += token + '"></header></httpHeader>';
       header = %trim(header);

       //header pour le Post et Put
       headerP  = '<httpHeader>';
       headerP += '<header name="Content-Type"'+ espace;
       headerP += 'value="application/json"></header>';
       headerP += '<header name="Authorization" value="Bearer' + espace;
       headerP += token + '"></header></httpHeader>';
       headerP = %trim(headerP);

       //id + url
       id = '';
       lien = url + %trim(id);


       *INLR = *ON;
       EXEC SQL
         SET OPTION COMMIT = *NONE,
           datfmt = *ISO;
       // A- INITIALISATION DU SOUS-FICHIER
       INITIALISATION_SOUS_FICHIER();
       FABRICATION_SOUS_FICHIER();

       DOW NOT *IN03;
         RANG = 1;
         WRITE FKEY1;
         EXFMT SF1CTL;
         SELECT;
         WHEN *IN39;
           FABRICATION_SOUS_FICHIER();
           EXEC SQL CLOSE C1;
           INITIALISATION_SOUS_FICHIER();
           FABRICATION_SOUS_FICHIER();
         WHEN *IN06;
           CREATION();
         OTHER;
           TRT_READC();
         ENDSL;
       ENDDO;

       EXEC SQL CLOSE C1;

       //************************************************************************
       //  INITIALISATION DU SOUS FICHIER
       //************************************************************************
       DCL-PROC INITIALISATION_SOUS_FICHIER;
         RANG = *ZERO;   // INITIALISAT° DU COMPTEUR D'enregistrement.
         LAST_RANG = *ZERO;
         *IN31 = *ON;    // ACTIVAT° DE L'indic de vidage de SFL  (Associé au mot clé SFLCR)
         WRITE SF1CTL;   // VIDAGE DU SOUS-FICHIER
         *IN31 = *OFF;   // DÉSACTIVAT° DE L'indic de vidage de SFL (Associé au mot clé SFLCLR)
         *IN32 = *OFF;   // DÉSACTIVAT° DE L'indic de vidage de SFL (Associé au mot clé SFLDSP)
         *IN90 = *OFF;   // DÉSACTIVAT° DE L'indic de vidage de SFL (Associé au mot clé SFLEND)
         *IN63 = *OFF;
         I = 1;
       END-PROC;

       //************************************************************************
       // FABRICATION DU SOUS FICHIER
       //************************************************************************
       DCL-PROC FABRICATION_SOUS_FICHIER;
         RANG = LAST_RANG;        // LE "relative record number" REÇOIT LA VALEUR DU DERNIER
         id = '';
         lien = url + %trim(id);
         EXEC SQL
               DECLARE C1 CURSOR FOR
          select  idUser, name, email, gender, status
          from json_table(systools.HTTPGETCLOB (
           cast(:lien as varchar(255)),
           cast(:header as clob(1k)
                  )),
          '$'
               COLUMNS(
                idUser VARCHAR(5) PATH '$.id' ,
                name VARCHAR(15) PATH '$.name',
                email VARCHAR(19) PATH '$.email',
                gender VARCHAR(7) PATH '$.gender',
                status VARCHAR(8) PATH '$.status'
              )
             ) order by idUser desc ;
         EXEC SQL
         OPEN C1;

         FOR I TO SFLPAG;
           DOW SQLCODE = 0;
             EXEC SQL FETCH C1 INTO :E1CODFOR,:E1NM,
               :E1MAIL, :E1GENRE, :E1STATUS;
             IF SQLCODE = 100;
               *IN90=*ON;
               LEAVE;
             ENDIF;
             RANG += 1;  // INCRÉMENTATION DU COMPTEUR DE LIGNE
             WRITE SFL1;
           ENDDO;
         ENDFOR;

         IF RANG = *ZERO;      // SI AUCUN ENREGISTREMENT DÉTECTÉ DANS LE SOUS-FICHIER
           *IN32 = *ON;            //   ACTIVER L'indicateur masquant le sous-fichier
         ENDIF;
         LAST_RANG = RANG;        // SAUVEGARDER LE DERNIER ENREGISTREMENT CHARGÉ
         EXEC SQL CLOSE C1;
       END-PROC;

       //************************************************************************
       // Traitement du READC
       //************************************************************************
       Dcl-Proc TRT_READC;
         Readc Sfl1;
         Dow Not %eof;

           // Tant que toutes les lignes modifiés n'ont pas été traitées
           Select;
           When OPT = Supprimer;  // Option 4 Supprimer
             E4CODFOR = E1CODFOR;
             E4NM     = E1NM;
             E4MAIL   = E1MAIL ;
             E4GENRE  = E1GENRE ;
             E4STATUS = E1STATUS ;
             id = %trim(E4CODFOR);
             lien = url + %trim(id);
             EXFMT FMT4 ;
             OPT = ' ';        // Remise à blanc de l'option saisie
             if *in23; // Si F23 on active le delete
               exec sql
                     declare curseurDelete cursor for
                       select *
                         from TABLE(systools.HTTPDELETECLOBVERBOSE(
                         cast(:lien as varchar(255)),
                         cast(:header as clob(1k)
                            )
                        )
                      );

               //ouverture et fetch du curseur
               exec sql open curseurDelete;
               exec sql fetch curseurDelete  ;
               if  SQLCODE = 0;
                 exec sql close curseurDelete;
                 leave;
               else;
                 //on affiche les codes erreurs
                 dsply 'echec';
                 dsply ('SqlCode : ' + %char(SqlCode) ) ;
                 dsply ('SqlState : ' + %char(SqlState) ) ;
                 exec sql close curseurDelete;
               endif;
             ENDIF;
             Update Sfl1;
           When OPT = Modifier;     // Option 2 saisie
             E2CODFOR = E1CODFOR;
             E2NM     = E1NM;
             E2MAIL   = E1MAIL;
             E2GENRE  = E1GENRE;
             E2STATUS = E1STATUS;
             id = %trim(E2CODFOR);
             lien = url + %trim(id);
             DOW NOT *IN03;
               EXFMT FMT2 ;
               SELECT;
               WHEN *IN12;
                 leave;
               WHEN (*IN23 and
                 ((%trim(E2GENRE) = 'MALE') or (%trim(E2GENRE) = 'FEMALE')) or
                 ((%trim(E2GENRE) = 'male') or (%trim(E2GENRE) = 'female')) and
             ((%trim(E2STATUS) = 'active') or (%trim(E2STATUS) = 'inactive'))or
             ((%trim(E2STATUS) = 'ACTIVE') or (%trim(E2STATUS) = 'INACTIVE'))and
                 (%scan('@':%trim(E2MAIL)) > 0)and
                 (%trim(E2MAIL) <> %trim(E1MAIL)) );
                 //conception du body avec les infos récupérées dans l'écran
                 body  = acco_o + '"name":"'+ %trim(E2NM) +'",';
                 body += '"email":"' + %trim(E2MAIL) +'",';
                 body += '"gender":"'+ %trim(E2GENRE) +'",';
                 body += '"status":"'+ %trim(E2STATUS) +'"' + acco_f;
                 body = %trim(body);
                 EXEC SQL
                   Declare curseurPUT cursor for
                   select  *
                 from json_table( systools.HTTPPUTCLOB (
                   cast(:lien as varchar(255)),
                   cast(:headerP as clob(1k)),
                   cast(:body as clob(1k)
                    )),
                   '$'
                 COLUMNS(
                  status VARCHAR(30) PATH '$.status' DEFAULT '' ON EMPTY,
                  err VARCHAR(1024) PATH '$.err' DEFAULT '' ON EMPTY
                   )
                   );

                 //ouverture et fetch du curseur
                 exec sql  open curseurPUT;
                 EXEC sql fetch curseurPUT;
                 if  SQLCODE = 0;
                   exec sql close curseurPUT;
                   leave;
                 else;
                   //on affiche les codes erreurs
                   dsply 'echec';
                   dsply ('SqlCode : ' + %char(SqlCode) ) ;
                   dsply ('SqlState : ' + %char(SqlState) ) ;
                   exec sql close curseurPUT;
                 endif;

                 leave;
               WHEN OPT = ' ';
                 *IN63 = *ON;
               ENDSL;
             ENDDO;
             OPT = ' ';
             Update Sfl1;
           ENDSL;
           Readc Sfl1;
         enddo;
         Initialisation_sous_fichier();
         Fabrication_sous_fichier();

       End-Proc;

       //************************************************************************
       // Création
       //************************************************************************

       dcl-proc creation;
         E6NM     = '';
         E6MAIL   = '';
         E6GENRE  = '';
         E6STATUS = '';
         id = '';
         lien = url + %trim(id);

         EXFMT FMT6;
         IF *IN23 ;
           //conception du body avec les infos récupérées dans l'écran
           body  = acco_o + '"name":"'+ %trim(E6NM) +'",';
           body += '"email":"' + %trim(E6MAIL) +'",';
           body += '"gender":"'+ %trim(E6GENRE) +'",';
           body += '"status":"'+ %trim(E6STATUS) +'"' + acco_f;
           body = %trim(body);
           EXEC SQL
             Declare curseurPost cursor for
             select  *
             from json_table( systools.HTTPPOSTCLOB (
             cast(:lien as varchar(255)),
             cast(:headerP as clob(1k)),
             cast(:body as clob(1k)
             )),
             '$'
             COLUMNS(
             status VARCHAR(30) PATH '$.status' DEFAULT '' ON EMPTY,
             err VARCHAR(1024) PATH '$.err' DEFAULT '' ON EMPTY
             )
             );
           //ouverture et fetch du curseur
           Exec Sql Open  curseurPost ;
           EXEC sql fetch curseurPost;
           if sqlcode >= 0 ;
             Exec Sql Close curseurPost;
             INITIALISATION_SOUS_FICHIER();
             FABRICATION_SOUS_FICHIER();
             return;
           else;
             //on affiche les codes erreurs
             dsply ('echec');
             dsply ('SqlCode : ' + %char(SqlCode) ) ;
             dsply ('SqlState : ' + %char(SqlState) ) ;
             Exec Sql Close curseurPost;
           endif ;
         ENDIF;
         if *in12; //si on appuie sur f12 on retourne en arriere
           return;
         ENDIF;
       END-PROC;
```
