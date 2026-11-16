---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: PDFSEND
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 159
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/PDFSEND

```rpg
**FREE
//------------------------------------------------------------
//  PGM    : PDFSEND
//  Role   : Lire un PDF sur IFS, l'encoder Base64,
//           l'envoyer en JSON via HTTP POST
//  Auteur : Sylvain BIB02 - NOTOS
//------------------------------------------------------------
ctl-opt dftactgrp(*no) actgrp(*caller)
        option(*nodebugio:*srcstmt)
        decedit('0,');

// --- Parametres d'appel ----------------------------------
// CHAR fixe pour compatibilite appels CL et SQL CALL
dcl-pi *n;
   pIfsPath  char(512) const;
   pUrl      char(512) const;
   pToken    char(256) const;
end-pi;

// --- Variables locales -----------------------------------
dcl-s wIfsPath       varchar(512);
dcl-s wUrl           varchar(512) ccsid(*utf8);
dcl-s wToken         varchar(256) ccsid(*utf8);
dcl-s wFilename      varchar(256);
dcl-s wHeaders       varchar(1024);
dcl-s wHttpCode      zoned(3:0);
dcl-s wRespMessage   sqltype(clob:65000);

// --- Variables pour gestion erreur SQL -------------------
dcl-s sqlcod_err     int(10);
dcl-s errorMsg       varchar(1024) ccsid(*utf8);

// --- Initialisation --------------------------------------
exec sql set option commit  = *none,
                    datfmt  = *iso;

// Conversion CHAR -> VARCHAR pour le SQL embarque
wIfsPath = %trim(pIfsPath);
wUrl     = %trim(pUrl);
wToken   = %trim(pToken);

//============================================================
//  CORPS DU PROGRAMME
//============================================================

// On extrait le nom de fichier du chemin complet
exec sql
   set :wFilename =
       substr(:wIfsPath,
              locate_in_string(:wIfsPath, '/', -1) + 1);

if chkSql('Extract filename' : *on);
   return;
endif;

// --- Construction des headers HTTP -----------------------
if wToken <> '';
   wHeaders = '{"header":"Authorization,Bearer ' + %trim(wToken)
            + ';Content-Type,application/json;charset=utf-8"}';
else;
   wHeaders = '{"header":"Content-Type,application/json;charset=utf-8"}';
endif;

// --- L'appel HTTP : tout se passe ici --------------------
exec sql
   with body as (
        select json_object(
                  'filename'   value :wFilename,
                  'mimeType'   value 'application/pdf',
                  'sizeBytes'  value length(b.line),
                  'content'    value qsys2.base64_encode(b.line)
                  returning clob(100M)
               ) as payload
        from   table(qsys2.ifs_read_binary(
                        path_name           => :wIfsPath,
                        maximum_line_length => 104857600))
               as b
   ),
   reponse as (
        select r.response_message     as msg,
               r.response_http_header as hdr
        from   body
               cross join table(
   qsys2.http_post_verbose(
      url             => :wUrl,
      request_message => body.payload,
      options         => :wHeaders
   )
) as r
   )
   select h.http_status_code,
          coalesce(r.msg, '')
   into   :wHttpCode,
          :wRespMessage
   from   reponse r
          cross join json_table(r.hdr, 'lax $'
                       columns (http_status_code dec(3)
                                path '$.HTTP_STATUS_CODE')) as h;

if chkSql('IFS->Base64->HTTP' : *on);
   return;
endif;

// --- Verification du code HTTP ---------------------------
select;
   when wHttpCode >= 200 and wHttpCode < 300;
      snd-msg 'PDF envoye OK - HTTP ' + %char(wHttpCode)
            + ' (' + %trim(wFilename) + ')';

   when wHttpCode >= 400 and wHttpCode < 500;
      snd-msg *escape 'Erreur client distante - HTTP '
                    + %char(wHttpCode);

   when wHttpCode >= 500;
      snd-msg *escape 'Erreur serveur distant - HTTP '
                    + %char(wHttpCode);

   other;
      snd-msg *escape 'Code HTTP inattendu : ' + %char(wHttpCode);
endsl;

*inlr = *on;
return;

// --- Subprocedure de gestion erreur SQL ------------------
dcl-proc chkSql;
   dcl-pi *n ind;
      pContexte varchar(50) const;
      pEscape   ind         const options(*nopass);
   end-pi;

   dcl-s vEsc ind inz(*off);

   if %parms() >= 2;
      vEsc = pEscape;
   endif;

   if sqlcode = 0;
      return *off;
   endif;

   sqlcod_err = sqlcode;

   exec sql
      get diagnostics condition 1
          :errorMsg = MESSAGE_TEXT;

   if vEsc;
      snd-msg *escape '[' + %trim(pContexte) + '] SQLCODE='
                    + %char(sqlcod_err) + ' - '
                    + %trim(errorMsg);
   else;
      snd-msg '[' + %trim(pContexte) + '] SQLCODE='
            + %char(sqlcod_err) + ' - '
            + %trim(errorMsg);
   endif;

   return *on;
end-proc;
```
