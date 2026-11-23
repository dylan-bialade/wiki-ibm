---
bibliotheque: BIB01
fichier_source: QRPGLESRC
membre: CHK_WEBSRV
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 738
modifie: 2026-11-16
---

# BIB01/QRPGLESRC/CHK_WEBSRV

```text

       CTL-OPT COPYRIGHT('(C) ORGFORM 2022.') USRPRF(*OWNER) OPTIMIZE(*NONE)
       DFTACTGRP(*NO) ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO)
       ALLOC(*STGMDL) STGMDL(*INHERIT) BNDDIR('BNDCRA');

      //**********************************************************************//
      //Déclaration des prototypes                                            //
      //**********************************************************************//

        dcl-pr GET_CRAADRIEN extproc('GET_CRAADRIEN');
          schbdg zoned(10:0);
          cradat zoned(8:0);
          http_code int(5);
          http_text char(64);
          p_JSON like(JSON_DATA);
        end-pr;

        dcl-pr DELETE_CRAADRIEN extproc('DELETE_CRAADRIEN');
          schbdg zoned(10:0);
           cradat zoned(8:0);
          http_code int(5);
          http_text char(64);
        end-pr;

        dcl-pr POST_CRAADRIEN extproc('POST_CRAADRIEN');
          p_JSON like(JSON_DATA);
          http_code int(5);
          http_text char(64);
        end-pr;

        dcl-pr PUT_CRAORGFORM extproc('PUT_CRAORGFORM');
          schbdg zoned(10:0);
          cradat zoned(8:0);
          p_JSON like(JSON_DATA);
          http_code int(5);
          http_text char(64);
        end-pr;

        dcl-pr PATCH_CRAADRIEN extproc('PATCH_CRAADRIEN');
          schbdg zoned(10:0);
          cradat zoned(8:0);
          p_JSON like(JSON_DATA);
          http_code int(5);
          http_text char(64);
        end-pr;

        dcl-pr QCmdExc extpgm('QSYS/QCMDEXC');
          Cmd char(32702) options(*varsize) const;
          Len packed(15:5) const;
        end-pr;

        dcl-pr QUsrJobI extpgm('QSYS/QUSRJOBI');
          RcvVar like(JOBI0400) options(*varsize) const;
          VarLen bindec(9:0) const;
          FmtNam char(8) const;
          JobNam char(26) const;
          IntJbI char(16) const;
          ErrCod char(4) const;
        end-pr;

      //Gestion des erreurs                                                   //
     DQmhsndpm         pr                  extpgm('QSYS/QMHSNDPM')
     D MsgId                          7A   const
     D MsgF                          20A   const
     D MsgDta                       512A   options(*varsize) const
     D MsgDtaLen                      9B 0 const
     D MsgType                       10A   const
     D PgmQ                          10A   const
     D Stk                            4A   const
     D MsgKey                         4A   const
     D ApiErr                         4    const
     D CSEntLn                        4    options(*nopass) const
     D CSEntQual                     20A   options(*nopass) const
     D DPMSWT                         9B 0 options(*nopass) const
      //
     DQmhrcvpm         pr                  extpgm('QSYS/QMHRCVPM')
     D RcvM0200                     688    options(*varsize) const
     D FmtLen                         9B 0 const
     D FmtNam                         8A   const
     D PgmQ                          10A   const
     D Stk                            4A   const
     D MsgType                       10A   const
     D MsgKey                         4A   const
     D Wait                           4A   const
     D Act                           10A   const
     D ApiErr                         4    const
      //
     DRcvM0200         ds                  inz
     D BytRtn                  1      4B 0
     D BytAvl                  5      8B 0
     D MsgSev                  9     12B 0
     D MsgId                  13     19A
     D MsgTyp                 20     21A
     D MsgKey                 22     25A
     D MsgFNM                 26     35A
     D MsgFLS                 36     45A
     D MsgFLU                 46     55A
     D SndJob                 56     65A
     D SndUsr                 66     75A
     D SndNbr                 76     81A
     D SndPgm                 82     93A
      //
     D SndDat                 98    104A
     D SndTim                105    110A
      //
     D DtaLnr                153    156B 0
     D DtaLna                157    160B 0
     D MsgLnr                161    164B 0
     D MsgLna                165    168B 0
     D HlpLnr                169    172B 0
     D HlpLna                173    176B 0
     D MsgDta                       512A   Varying

      //**********************************************************************//
      //Déclaration des data-structures                                       //
      //**********************************************************************//

     D                SDS
     D wk_NomPgm               1     10
      *
     D wk_PgmErI              40     46
     D wk_PgmLib              81     90
     D wk_PgmErM              91    170
     D wk_PgmDt8             191    198
      *
     D wk_NomJob             244    253
     D wk_NomUser            254    263
     D wk_NomNbr             264    269
      //
     D wk_CurUsr             358    367

       dcl-ds JOBI0400;
        RtnByt bindec(9:0) pos(1);
        AvlByt bindec(9:0) pos(5);
        CCSID  bindec(9:0) pos(301);
        ASPGIE like(FmtGie) DIM(1) pos(575);
       end-ds;

       dcl-ds FmtGie;
        ASPGrp char(10);
        Reserved char(6);
       end-ds;

      //**********************************************************************//
      //Déclaration des variables                                             //
      //**********************************************************************//

       DCL-S RPLY sqltype(CLOB:16773100);
       DCL-S NullInd bindec(4:0);

       DCL-S JSON sqltype(CLOB:32768);
      //
       DCL-S schbdg zoned(10:0);

       DCL-S schpr1 varchar(20);
       DCL-S schpr2 varchar(20);
       DCL-S schpr3 varchar(20);
       DCL-S schpr4 varchar(20);
       DCL-S schnom varchar(30);

       Dcl-s cradat zoned(8:0);
       DCL-S crajf zoned(1:0);
       DCL-S craam varchar(7);
       DCL-S crapm varchar(7);
       Dcl-S wcradat date;
      //
       DCL-S http_code int(5);
       DCL-S http_text char(64);
      //
       DCL-S p_JSON like(JSON_DATA);
      //
       DCL-S url varchar(2048) CCSID(1208);
      //
       DCL-s CurPwd char(10);
      //
       DCL-s Cmd varchar(32702);

      //**********************************************************************//
      //                                                                      //
      //**********************************************************************//

     C     *Entry        PList
     C                   Parm                    METHOD            6
     C                   Parm                    MODE              7

      //**********************************************************************//
      //Consignes de compilation SQL                                          //
      //**********************************************************************//
     C                   Do
      //Gestion du contrôle de validation, des performances, etc ...
       EXEC SQL
        SET OPTION COMMIT = *NONE, ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD,
        DYNUSRPRF = *OWNER, DATFMT = *ISO, TIMFMT = *ISO;

      //**********************************************************************//
      //               T R A I T E M E N T    P R I N C I P A L               //
      //**********************************************************************//

      //Contrôle des paramétres (en entrée) ...                               //
       If %addr(METHOD)=*NULL;
       *InLr=*On;
       MsgId='CPD0172';
       MsgDta=X'00000014'+wk_NomPgm+wk_PgmLib;
       ElseIf METHOD=*BLANKS;
       *InLr=*On;
       MsgId='CPD0071';
       MsgDta=X'0000000A'+'METHOD';
       Else;
       EndIf;
       If *InLr;
       Leave;
       EndIf;

       If %addr(MODE)=*NULL;
       *InLr=*On;
       MsgId='CPD0172';
       MsgDta=X'00000014'+wk_NomPgm+wk_PgmLib;
       ElseIf MODE=*BLANKS;
       *InLr=*On;
       MsgId='CPD0071';
       MsgDta=X'0000000A'+'MODE';
       Else;
       EndIf;
       If *InLr;
       Leave;
       EndIf;

       If %parms()<>2;
       *InLr=*On;
       MsgId='CPD0172';
       MsgDta=X'00000014'+wk_NomPgm+wk_PgmLib;
       Else;
       EndIf;
       If *InLr;
       Leave;
       EndIf;

      //Sélection du traitement en fonction de la méthode (à tester)          //
       select;
       When %xlate('acdeghlopstu':'ACDEGHLOPSTU':%trim(METHOD))='GET';
       ExSr GET;
       When %xlate('acdeghlopstu':'ACDEGHLOPSTU':%trim(METHOD))='DELETE';
       ExSr DELETE;
       When %xlate('acdeghlopstu':'ACDEGHLOPSTU':%trim(METHOD))='POST';
       ExSr POST;
       When %xlate('acdeghlopstu':'ACDEGHLOPSTU':%trim(METHOD))='PUT';
       ExSr PUT;
       When %xlate('acdeghlopstu':'ACDEGHLOPSTU':%trim(METHOD))='PATCH';
       ExSr PATCH;
       Other;
       *InLr=*On;
       MsgId='CPD0084';
       MsgDta=X'00000014'+'METHOD    '+METHOD;
       EndSl;
       If *InLr;
       Leave;
       EndIf;

      //Fin du programme.                                                     //
     C                   EndDo
     C  nLr              If        CCSID=65535
     C                   Eval      Cmd='CHGJOB JOB(*) CCSID(65535)'
     C                   CallP(e)  QCmdExc(Cmd:%len(Cmd))
     C                   Eval      *InLr=%error()
     C                   EndIf
     C   Lr              ExSR      *PsSR
     C  nLr              Eval      *InLr = *On

      //**********************************************************************//
      //          F I N    T R A I T E M E N T    P R I N C I P A L           //
      //**********************************************************************//
      //                                                                      //
      //                                                                      //
      //**********************************************************************//
      //Sous-programme intitial                                               //
      //**********************************************************************//

       BegSR *InzSr;

       Clear JOBI0400;
       CallP(e) QUsrJobI(JOBI0400:%size(JOBI0400):'JOBI0400':'*':*blank:*loval);
       If  %error();
       *InLr=*On;
       ElseIf CCSID=65535;
       Cmd='CHGJOB JOB(*) CCSID(297)';
       CallP(e) QCmdExc(Cmd:%len(Cmd));
       *InLr=%error();
       Else;
       EndIf;
       If *InLr;
       ExSR *PsSR;
       EndIf;

       EndSR;

      //**********************************************************************//
      //                                                                      //
      //**********************************************************************//

       BegSR GET;
      //                                                                      //
       schbdg = 2897527978;
       cradat = 20230123;
      //
       select;
       When %xlate('begmprsvw':'BEGMPRSVW':MODE)='*WEBSRV';
      //
       Url='http://localhost:10013/CRADRIEN2/'+
       %trim(%char(schbdg)) + '/' + %trim(%char(cradat)) ;
      //
       clear curpwd;
       DoU %error() or CurPwd<>*blanks;
       Dsply(e) 'Veuillez saisir votre mot de passe :' '*EXT' CurPwd;
       EndDo;
       *InLr=%error();
       If *InLr;
       LeaveSr;
       EndIf;
      //
       Clear RPLY;
       exec sql
        SET :RPLY:NullInd=QSYS2.HTTP_GET(:Url, JSON_OBJECT(
        'header' VALUE CONCAT('Authorization,Basic ',
        QSYS2.BASE64_ENCODE(CAST(RTRIM(:wk_CurUsr) CONCAT ':' CONCAT
        RTRIM(:CurPwd) as varchar(21) CCSID 1208)))
        RETURNING CLOB(10K) CCSID 1208));
       If (SqlCod=-204 and %scan('QSYS2':SqlErm)<>*zero);
       exec sql
        SET :RPLY:NullInd=SYSTOOLS.HTTPGETCLOB(:Url, CAST(
        '<httpHeader><header name="Authorization" value="Basic ' CONCAT
        SYSTOOLS.BASE64ENCODE(CAST(RTRIM(:wk_CurUsr) CONCAT ':' CONCAT
        RTRIM(:CurPwd) as varchar(21) CCSID 1208)) CONCAT '"/></httpHeader>'
        AS CLOB(10K) CCSID 1208));
       EndIf;
       *InLr=(SqlCod<>*zero);
       If *InLr;
       MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
       %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
       MsgDta=SqlErm;
       LeaveSr;
       ElseIf NullInd<>*zero;
       Clear RPLY;
       Else;
       EndIf;
      //
       When %xlate('begmprsvw':'BEGMPRSVW':MODE)='*SRVPGM';
      //
       Clear http_code;
       Clear http_text;
       Clear p_JSON;
      //
       CallP(e) GET_CRAADRIEN(schbdg:cradat:http_code:http_text:p_JSON);
       *InLr=%error();
       If *InLr;
       LeaveSr;
       EndIf;

       Other;
       *InLr=*On;
       MsgId='CPD0084';
       MsgDta=X'00000014'+'MODE      '+MODE;
       EndSl;
      //                                                                      //
       EndSR;

      //**********************************************************************//
      //                                                                      //
      //**********************************************************************//

       BegSR DELETE;
      //                                                                      //
       schbdg = 2626347178;
       cradat = 20230103;
       wcradat = %date(cradat);
      //
       select;
       When %xlate('begmprsvw':'BEGMPRSVW':MODE)='*WEBSRV';
      //
       Url='http://localhost:10013/CRADRIEN2/'+
       %trim(%char(schbdg))+'/'+%trim(%char(cradat));
      //
       clear curpwd;
       DoU %error() or CurPwd<>*blanks;
       Dsply(e) 'Veuillez saisir votre mot de passe :' '*EXT' CurPwd;
       EndDo;
       *InLr=%error();
       If *InLr;
       LeaveSr;
       EndIf;
      //
       Clear RPLY;
       exec sql
        SET :RPLY:NullInd=QSYS2.HTTP_DELETE(:Url, JSON_OBJECT(
        'header' VALUE CONCAT('Authorization,Basic ',
        QSYS2.BASE64_ENCODE(CAST(RTRIM(:wk_CurUsr) CONCAT ':' CONCAT
        RTRIM(:CurPwd) as varchar(21) CCSID 1208)))
        ));
       If (SqlCod=-204 and %scan('QSYS2':SqlErm)<>*zero);
       exec sql
        SET :RPLY:NullInd=SYSTOOLS.HTTPDELETECLOB(:Url, CAST(
        '<httpHeader><header name="Authorization" value="Basic ' CONCAT
        SYSTOOLS.BASE64ENCODE(CAST(RTRIM(:wk_CurUsr) CONCAT ':' CONCAT
        RTRIM(:CurPwd) as varchar(21) CCSID 1208)) CONCAT '"/></httpHeader>'
        AS CLOB(10K) CCSID 1208));
       EndIf;
       *InLr=(SqlCod<>*zero);
       If *InLr;
       MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
       %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
       MsgDta=SqlErm;
       LeaveSr;
       ElseIf NullInd<>*zero;
       Clear RPLY;
       Else;
       EndIf;
      //
       When %xlate('begmprsvw':'BEGMPRSVW':MODE)='*SRVPGM';
      //
       Clear http_code;
       Clear http_text;
      //
       CallP(e) DELETE_CRAADRIEN(schbdg:cradat:http_code:http_text);
       *InLr=%error();
       If *InLr;
       LeaveSr;
       EndIf;

       Other;
       *InLr=*On;
       MsgId='CPD0084';
       MsgDta=X'00000014'+'MODE      '+MODE;
       EndSl;
      //                                                                      //
       EndSR;

      //**********************************************************************//
      //                                                                      //
      //**********************************************************************//

       BegSR POST;
      //                                                                      //
       schbdg = 2897527978;
       cradat = 20230103;
       wcradat = %date(cradat);
       crajf = 0;
       craam = 'TEST';
       crapm = 'POST';
      //                                                                      //
       EXEC SQL
        SET :JSON=JSON_OBJECT(
        KEY 'BADGE' VALUE :schbdg,
        KEY 'DATE' VALUE :wcradat,
        KEY 'JourFerie' VALUE :crajf,
        KEY 'MATIN' VALUE :craam,
        KEY 'SOIR' VALUE :crapm
        ABSENT ON NULL RETURNING CLOB(32K) FORMAT JSON);
       *InLr=(SqlCod<>*zero);
       If *InLr;
       MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
       %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
       MsgDta=SqlErm;
       LeaveSr;
       EndIf;
      //
       select;
       When %xlate('begmprsvw':'BEGMPRSVW':MODE)='*WEBSRV';
      //
       Url='http://localhost:10013/CRADRIEN2';
      //
       clear curpwd;
       DoU %error() or CurPwd<>*blanks;
       Dsply(e) 'Veuillez saisir votre mot de passe :' '*EXT' CurPwd;
       EndDo;
       *InLr=%error();
       If *InLr;
       LeaveSr;
       EndIf;
      //
       Clear RPLY;
       exec sql
        SET :RPLY:NullInd=QSYS2.HTTP_POST(:Url,
        CAST(:JSON AS CLOB(2G) CCSID 1208),
        JSON_OBJECT('header' VALUE CONCAT('Authorization,Basic ',
        QSYS2.BASE64_ENCODE(CAST(RTRIM(:wk_CurUsr) CONCAT ':' CONCAT
        RTRIM(:CurPwd) as varchar(21) CCSID 1208)))
        RETURNING CLOB(10K) CCSID 1208));
       If (SqlCod=-204 and %scan('QSYS2':SqlErm)<>*zero);
       exec sql
        SET :RPLY:NullInd=SYSTOOLS.HTTPPOSTCLOB(:Url, CAST(
        '<httpHeader><header name="Authorization" value="Basic ' CONCAT
        SYSTOOLS.BASE64ENCODE(CAST(RTRIM(:wk_CurUsr) CONCAT ':' CONCAT
        RTRIM(:CurPwd) as varchar(21) CCSID 1208)) CONCAT '"/></httpHeader>'
        AS CLOB(10K) CCSID 1208),
        CAST(:JSON AS CLOB(2G) CCSID 1208));
       EndIf;
       *InLr=(SqlCod<>*zero);
       If *InLr;
       MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
       %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
       MsgDta=SqlErm;
       LeaveSr;
       ElseIf NullInd<>*zero;
       Clear RPLY;
       Else;
       EndIf;
      //
       When %xlate('begmprsvw':'BEGMPRSVW':MODE)='*SRVPGM';
      //
       Clear http_code;
       Clear http_text;
      //
       CallP(e) POST_CRAADRIEN(JSON_DATA:http_code:http_text);
       *InLr=%error();
       If *InLr;
       LeaveSr;
       EndIf;

       Other;
       *InLr=*On;
       MsgId='CPD0084';
       MsgDta=X'00000014'+'MODE      '+MODE;
       EndSl;
      //                                                                      //
       EndSR;

      //**********************************************************************//
      //                                                                      //
      //**********************************************************************//

       BegSR PUT;

       schbdg = 2897527978;
       CRAJF = 0;
       CRAAM = '*OFF  ';
       CRAPM = '*OFF  ';
       cradat = 20230123;
       wcradat = %date(cradat);
      //                                                                      //
       EXEC SQL
        SET :JSON=JSON_OBJECT(
        KEY 'BADGE' VALUE :schbdg,
        KEY 'DATE' VALUE :wcradat,
        KEY 'JourFerie' VALUE NULLIF(TRIM(:CRAJF), ''),
        KEY 'MATIN' VALUE NULLIF(TRIM(:CRAAM), ''),
        KEY 'APRESMIDI' VALUE NULLIF(TRIM(:CRAPM), '')
        ABSENT ON NULL RETURNING CLOB(32K) FORMAT JSON);
       *InLr=(SqlCod<>*zero);
       If *InLr;
       MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
       %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
       MsgDta=SqlErm;
       LeaveSr;
       EndIf;
      //                                                                      //
       select;
       When %xlate('begmprsvw':'BEGMPRSVW':MODE)='*WEBSRV';
      //
       Url='http://localhost:10013/CRADRIEN2/'+
       %trim(%char(schbdg))+'/'+%trim(%char(cradat));
      //
       clear curpwd;
       DoU %error() or CurPwd<>*blanks;
       Dsply(e) 'Veuillez saisir votre mot de passe :' '*EXT' CurPwd;
       EndDo;
       *InLr=%error();
       If *InLr;
       LeaveSr;
       EndIf;
      //
       Clear RPLY;
       exec sql
        SET :RPLY:NullInd=QSYS2.HTTP_PUT(:Url,
        CAST(:JSON AS CLOB(2G) CCSID 1208),
        JSON_OBJECT('header' VALUE CONCAT('Authorization,Basic ',
        QSYS2.BASE64_ENCODE(CAST(RTRIM(:wk_CurUsr) CONCAT ':' CONCAT
        RTRIM(:CurPwd) as varchar(21) CCSID 1208)))
        RETURNING CLOB(10K) CCSID 1208));
       If (SqlCod=-204 and %scan('QSYS2':SqlErm)<>*zero);
       exec sql
        SET :RPLY:NullInd=SYSTOOLS.HTTPPUTCLOB(:Url, CAST(
        '<httpHeader><header name="Authorization" value="Basic ' CONCAT
        SYSTOOLS.BASE64ENCODE(CAST(RTRIM(:wk_CurUsr) CONCAT ':' CONCAT
        RTRIM(:CurPwd) as varchar(21) CCSID 1208)) CONCAT '"/></httpHeader>'
        AS CLOB(10K) CCSID 1208),
        CAST(:JSON AS CLOB(2G) CCSID 1208));
       EndIf;
       *InLr=(SqlCod<>*zero);
       If *InLr;
       MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
       %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
       MsgDta=SqlErm;
       LeaveSr;
       ElseIf NullInd<>*zero;
       Clear RPLY;
       Else;
       EndIf;
      //
       When %xlate('begmprsvw':'BEGMPRSVW':MODE)='*SRVPGM';
      //
       Clear http_code;
       Clear http_text;
      //
       CallP(e) PUT_CRAORGFORM(schbdg:cradat:JSON_DATA:http_code:http_text);
       *InLr=%error();
       If *InLr;
       LeaveSr;
       EndIf;

       Other;
       *InLr=*On;
       MsgId='CPD0084';
       MsgDta=X'00000014'+'MODE      '+MODE;
       EndSl;
      //                                                                      //
       EndSR;

      //**********************************************************************//
      //                                                                      //
      //**********************************************************************//

       BegSR PATCH;

       Clear schbdg;
       Clear crajf;
       Clear craam;
       crapm = 'OFF';
       cradat = 20230105;
       wcradat = %date(cradat);

                                                                              //
       EXEC SQL
        SET :JSON=JSON_OBJECT(
        KEY 'BADGE' VALUE NULLIF(:schbdg, 0),
        KEY 'DATE' VALUE :wcradat,
        KEY 'JourFerie' VALUE NULLIF(TRIM(:crajf), ''),
        KEY 'MATIN' VALUE NULLIF(TRIM(:craam), ''),
        KEY 'SOIR' VALUE NULLIF(TRIM(:crapm), '')
        ABSENT ON NULL RETURNING CLOB(32K) FORMAT JSON);
       *InLr=(SqlCod<>*zero);
       If *InLr;
       MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
       %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
       MsgDta=SqlErm;
       LeaveSr;
       EndIf;
                                                                              //
       select;
       When %xlate('begmprsvw':'BEGMPRSVW':MODE)='*SRVPGM';

       schbdg=2897527978;

       Clear http_code;
       Clear http_text;

       CallP(e) PATCH_CRAADRIEN(schbdg:cradat:JSON_DATA:http_code:http_text);
       *InLr=%error();
       If *InLr;
       LeaveSr;
       EndIf;

       Other;
       *InLr=*On;
       MsgId='CPD0084';
       MsgDta=X'00000014'+'MODE      '+MODE;
       EndSl;
                                                                              //
       EndSR;

      //**********************************************************************//
      //*PsSr : Gestion des execeptions.                                      //
      //**********************************************************************//

       BegSr *PsSr;

       If MsgId=*blanks;
         If %len(MsgDta)>*zero;
           MsgId='CPF9897';
           MsgFNM='QCPFMSG';
           MsgFLU='QSYS';
         Else;
           CallP(e) Qmhrcvpm(RcvM0200:%size(RcvM0200)-2:
               'RCVM0200':'*':*loval:'*LAST':*blanks:
               *loval:'*REMOVE':*loval);
           If %error();
             MsgId='CAE0031';
             MsgDta='QMHRCVPM';
             MsgFNM='QCPFMSG';
             MsgFLU='QSYS';
           ElseIf MsgId<>*blanks;
             MsgDta=%subst(RcvM0200:1+%size(RcvM0200)-
                 %size(MsgDta):DtaLnr);
           EndIf;
           If MsgId=*blanks;
             MsgId='CPF2551';
             Clear MsgDta;
             MsgFNM='QCPFMSG';
             MsgFLU='QSYS';
           EndIf;
         EndIf;
       EndIf;
       //
       If CCSID=65535;
       Cmd='CHGJOB JOB(*) CCSID(65535)';
       CallP(e) QCmdExc(Cmd:%len(Cmd));
       If not(%error());
       Clear Cmd;
       EndIf;
       EndIf;
       //
       DoU MsgId=*blanks;
         If MsgFNM=*blanks;
           If %subst(MsgId:1:3)='SQL' or
                 %subst(MsgId:1:3)='JVA' or
                 %subst(MsgId:1:3)='RNX';
             MsgFNM='Q'+%subst(MsgId:1:3)+'MSG';
           Else;
             MsgFNM='QCPFMSG';
           EndIf;
         EndIf;
         If MsgFLU=*blanks;
           MsgFLU='*LIBL';
         EndIf;
         CallP(e) Qmhsndpm(MsgId:MsgFNM+MsgFLU:MsgDta:%len(
             MsgDta):'*ESCAPE':'*PGMBDY':X'00000001':
             *blanks:*loval);
         If %error() and
               (MsgId<>'CAE0031' or MsgDta<>'QMHSNDPM' or
               MsgFNM+MsgFLU<>'QCPFMSG   QSYS');
           MsgId='CAE0031';
           MsgDta='QMHSNDPM';
           MsgFNM='QCPFMSG';
           MsgFLU='QSYS';
           Iter;
         EndIf;
         Clear RcvM0200;
       EndDo;

       EndSR '*CANCL';
```
