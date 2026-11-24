---
bibliotheque: BIB02
fichier_source: QSRC
membre: SCHT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 540
modifie: 2026-11-16
---

# BIB02/QSRC/SCHT

```text
      *------------------------------------------------------------------------*
      *   Programme : GETSCHTROU                                               *
      *   Libell   : Procdure stocke GET_SCHTROUMPF                         *
      *------------------------------------------------------------------------*
      *   Projet    : FORMATION                                                *
      *   Auteur    : Xavier MACAREZ                                           *
      *   Date      : 15/11/2022                                               *
      *------------------------------------------------------------------------*
      *
      * Entrées : -/- CURRENT_SERVER, CURRENT_USER, CURRENT CLIENT_APPLNAME
      * Sorties : -/-
      *
      *
       CTL-OPT COPYRIGHT('(C) ORGFORM 2022.')
       OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*FULL)
       ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
       STGMDL(*INHERIT) THREAD(*SERIALIZE) USRPRF(*OWNER)
       PGMINFO(*PCML:*DCLCASE:*MODULE);
      *
      **************************************************************************
      * Déclaration des prototypes                                             *
      **************************************************************************
      *
       DCL-PR QCMDEXC extpgm('QCMDEXC');
         Cmd         CHAR(32702)      CONST OPTIONS(*VARSIZE);
         Len         PACKED(15:5)     CONST;
       END-PR;
      *
      * Gestion des erreurs
     D/Include QRPGLESRC,PSSR_FRE_D
      *
      **************************************************************************
      * Déclaration de data-structures                                         *
      **************************************************************************
      *
     DSCHTROUMPF     E DS                  EXTNAME(SCHTROUMPF) QUALIFIED
     D                                     TEMPLATE
     DARMONPSLOG     E DS                  EXTNAME(ARMONPSLOG) QUALIFIED
      *
      * Variables système
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
      *
     D wk_InJbId             380    395
     D wk_SysNam             396    403
      *
      **************************************************************************
      * Dclaration des variables                                              *
      **************************************************************************
      *
      * Variables paramtres d'entre
     D CALLER          S                   like(ARMONPSLOG.CALLER)
     D USER            S                   like(ARMONPSLOG.USERLOG)
     D FUNCTION        S                   like(ARMONPSLOG.FUNC)
      *
     D SCHBDG          S                   like(SCHTROUMPF.SCHBDG)
      *
     D NullInd         S              4b 0 dim(4)
      *
      * Variables PGM
     DPrm_NIn          ds                  based(Ptr)
     D NIn_001                             like(NullInd)
     D NIn_002                             like(NullInd)
     D NIn_003                             like(NullInd)
     D NIn_004                             like(NullInd)
      *
     D Cmd             S          32702A   varying
      *
     DSTACK_INFO       ds
     D ORDIN00001                     9b 0 inz
     D PROGR00001                    10a
     D PROGR00002                    10a
     D MODUL00001                    10a
      *
     D CURORDPOS       S                   like(ORDIN00001)
      *
      **************************************************************************
      * Paramtres d'entre                                                    *
      **************************************************************************
      *
     C     *Entry        PList
     C                   Parm                    CALLER
     C                   Parm                    USER
     C                   Parm                    FUNCTION
     C                   Parm                    SCHBDG
      *
     C                   Parm                    NullInd
      *
      **************************************************************************
      * Consignes de compilations SQL                                          *
      **************************************************************************
     C                   Do
      * Gestion du contrle de validation, des performances, de la fermeture du
       EXEC SQL
        SET OPTION COMMIT = *CHG , ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD,
        DYNUSRPRF = *OWNER, DATFMT = *ISO, TIMFMT = *ISO;
      *
      **************************************************************************
      *                T R A I T E M E N T    P R I N C I P A L                *
      **************************************************************************
      * Initialisation
       If ARMONPSLOG.ENDDATE<>ARMONPSLOG.STARTDATE or
       ARMONPSLOG.ELAPS00001<>*zero or
       ARMONPSLOG.STATUS<>*blanks;
         Clear CURORDPOS;
         CallP(e) Init_Log();
         *InLr=%error();
         If *InLr;
           Leave;
         EndIf;
       EndIf;

      * Recherche d'un programme applicatif (dans la liste d'appel des progr.) *
       EXEC SQL
        DECLARE STACK_INFO CURSOR FOR (SELECT
        ORDINAL_POSITION, UCASE(PROGRAM_NAME), UCASE(PROGRAM_LIBRARY_NAME),
        CASE WHEN MODULE_NAME IS NULL THEN '*NONE' ELSE UCASE(MODULE_NAME) END
        FROM TABLE(QSYS2.STACK_INFO ('*', 'ALL')) WHERE
        PROGRAM_NAME IS NOT NULL AND PROGRAM_LIBRARY_NAME IS NOT NULL AND (
        STATEMENT_IDENTIFIERS IS NOT NULL OR MI_INSTRUCTION_NUMBER IS NOT NULL)
        ORDER BY ORDINAL_POSITION DESC) WITH NC
        FOR READ ONLY OPTIMIZE FOR ALL ROWS;
       Clear STACK_INFO;
       EXEC SQL
        OPEN STACK_INFO;
       *InLr=(SqlCod<>*zero);
       If *InLr;
         MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
         %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
         MsgDta=SqlErm;
         Leave;
       EndIf;
       EXEC SQL
        FETCH STACK_INFO INTO :ORDIN00001, :PROGR00001, :PROGR00002,
        :MODUL00001;
       *InLr=(SqlCod<>*zero and SqlCod<>100);
       If *InLr;
         MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
         %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
         MsgDta=SqlErm;
         Leave;
       EndIf;
       DoW (SqlCod<>100);
         If %trim(PROGR00001)=%trim(wk_NomPgm) and
            %trim(PROGR00002)=%trim(wk_PgmLib);
           If CURORDPOS=*zero;
             CURORDPOS=ORDIN00001;
           EndIf;
         ElseIf CURORDPOS<>*zero;
           If %scan('Q':%trim(PROGR00001))<>1 or
              %scan('Q':%trim(PROGR00002))<>1;
             leave;
           EndIf;
         Else;
         EndIf;
         EXEC SQL
          FETCH STACK_INFO INTO :ORDIN00001, :PROGR00001, :PROGR00002,
          :MODUL00001;
         *InLr=(SqlCod<>*zero and SqlCod<>100);
         If *InLr;
           MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
           %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
           MsgDta=SqlErm;
           Leave;
         EndIf;
       EndDo;
       If *InLr;
         Leave;
       EndIf;
       EXEC SQL
        CLOSE STACK_INFO;
       *InLr=(SqlCod<>*zero);
       If *InLr;
         MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
         %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
         MsgDta=SqlErm;
         Leave;
       EndIf;
       *InLr=(CURORDPOS=*zero);
       If *InLr;
         MsgId='SQL0952';
         MsgDta=X'00000008';
         Leave;
       EndIf;

      * Controle d'existence des paramtres
       *InLr=(%addr(CALLER)=*null);
       If *InLr;
         MsgId='CPD0071';
         MsgDta=X'0000000A'+'CALLER';
         Leave;
       ElseIf %addr(NullInd)<>*null;
         If NullInd(1)<>*zero;
           Clear CALLER;
         EndIf;
       EndIf;

       *InLr=(%addr(USER)=*null);
       If *InLr;
         MsgId='CPD0071';
         MsgDta=X'0000000A'+'USER';
         Leave;
       ElseIf %addr(NullInd)<>*null;
         If NullInd(2)<>*zero;
           Clear USER;
         EndIf;
       EndIf;

       *InLr=(%addr(FUNCTION)=*null);
       If *InLr;
         MsgId='CPD0071';
         MsgDta=X'0000000A'+'FUNCTION';
         Leave;
       ElseIf %addr(NullInd)<>*null;
         If NullInd(3)<>*zero;
           Clear FUNCTION;
         EndIf;
       EndIf;

       *InLr=(%addr(SCHBDG)=*null);
       If *InLr;
         MsgId='CPD0071';
         MsgDta=X'0000000A'+'SCHBDG';
         Leave;
       ElseIf %addr(NullInd)<>*null;
         If NullInd(4)<>*zero;
           Clear SCHBDG;
         EndIf;
       EndIf;

       *InLr=(%addr(NullInd)=*null);
       If *InLr;
         MsgId='CPD0172';
         MsgDta=X'00000014'+wk_NomPgm+wk_PgmLib;
         Leave;
       Else;
         ptr=%addr(NullInd);
       EndIf;

      * Contrôle de validit des paramètres

      * Le paramètre SCHBDG doit etre supérieur  0 (ou null)
       If NIn_004=*zero;
         *InLr=NOT(SCHBDG>*zero);
         If *InLr;
           MsgId='SQL0301';
           MsgDta=X'0004'+X'0006'+'SCHBDG';
           Leave;
         EndIf;
       EndIf;

      * (Au cas ou le curseur serait resté ouvert lors de l'appel précédent)
       EXEC SQL
        Close GETSCHTROU;
       *InLr=(SqlCod<>*zero and SqlCod<>-501);
       If *InLr;
         MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
         %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
         MsgDta=SqlErm;
         Leave;
       EndIf;

      * Dclaration du curseur (résultat de la requête)
       EXEC SQL
        DECLARE GETSCHTROU CURSOR WITH HOLD FOR (SELECT
        * FROM SCHTROUMPF WHERE (:SCHBDG:NIn_004 IS NULL OR SCHBDG=:SCHBDG)
        ) FOR READ ONLY OPTIMIZE FOR ALL ROWS;

      * Ouverture du curseur
       EXEC SQL
        OPEN GETSCHTROU;

       If SqlCod=*zero;
      * Assignation du curseur  l'ensemble de rsultats renvoyé (par la procédu
         EXEC SQL
          SET RESULT SETS CURSOR GETSCHTROU;

       EndIf;
       *InLr=(SqlCod<>*zero);
       If *InLr;
         MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
         %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
         MsgDta=SqlErm;
         Leave;
       EndIf;

      * Fin du programme.
     C                   EndDo
       If not(*InLr);
         EXEC SQL
          COMMIT;
         If SqlCod=-7007;
           Clear SqlCA;
           SQLSTATE=*zero;
         ElseIf SqlCod<>*zero;
           *InLr=*On;
           MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
           %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
           MsgDta=SqlErm;
         Else;
         EndIf;
       EndIf;
     C   Lr              ExSR      *PsSR
     C                   Eval      *InRt = not(*InLr)
      *
      **************************************************************************
      *           F I N    T R A I T E M E N T    P R I N C I P A L            *
      **************************************************************************
      *
       // Ecriture dans le fichier log (ARMONPSLOG)
       CallP(e) Write_Log('OK');
      *
      **************************************************************************
      * *InzSR : Initialisation.                                               *
      **************************************************************************

       BegSR *InzSR;
      * Initialisation de l'enregistrement de log
         CallP(e) Init_Log();
         *InLr=%error();
         If *InLr;
           ExSR *PsSR;
         EndIf;

       EndSR;

      **************************************************************************
      * *PsSR : Gestion des exceptions.                                        *
      **************************************************************************
      *
       BegSR *PsSR;

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
         EXEC SQL
          ROLLBACK;
         If SqlCod=-7007;
           Clear SqlCA;
           SQLSTATE=*zero;
         EndIf;
         //
      * Ecriture dans le fichier log (ARMONPSLOG)                              *
         CallP(e) Write_Log('KO');
         //
      *                                                                        *
         If CURORDPOS<>*zero and ORDIN00001<CURORDPOS and (%trim(PROGR00001)<>
         %trim(wk_NomPgm) or %trim(PROGR00002)<>%trim(wk_PgmLib));
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
               MsgDta):'*DIAG':'*PGMNAME':X'00000000':
               *blanks:*loval:X'0000000A':MODUL00001+PROGR00001:-1);
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

      **************************************************************************
      * Procédures (internes)                                                  *
      **************************************************************************
     PInit_Log         B
     D                 PI
       Clear ARMONPSLOG;

       ARMONPSLOG.SQLSTR='CALL '+%trim(wk_PgmLib)+'.'+%trim(wk_NomPgm)+' (';

       If %addr(CALLER)<>*null;
         If %addr(NullInd)<>*null
         and NullInd(1)<>*zero;
           ARMONPSLOG.CALLER='-';
           ARMONPSLOG.SQLSTR+='NULL, ';
         Else;
           ARMONPSLOG.CALLER=CALLER;
           ARMONPSLOG.SQLSTR+=''''+CALLER+''', ';
         EndIf;
       EndIf;

       If %addr(USER)<>*null;
         If %addr(NullInd)<>*null
         and NullInd(2)<>*zero;
           ARMONPSLOG.USERLOG='-';
           ARMONPSLOG.SQLSTR+='NULL, ';
         Else;
           ARMONPSLOG.USERLOG=USER;
           ARMONPSLOG.SQLSTR+=''''+USER+''', ';
         EndIf;
       EndIf;

       If %addr(FUNCTION)<>*null;
         If %addr(NullInd)<>*null
         and NullInd(3)<>*zero;
           ARMONPSLOG.FUNC='-';
           ARMONPSLOG.SQLSTR+='NULL, ';
         Else;
           ARMONPSLOG.FUNC=FUNCTION;
           ARMONPSLOG.SQLSTR+=''''+FUNCTION+''', ';
         EndIf;
       EndIf;

       If %addr(SCHBDG)<>*null;
         If %addr(NullInd)<>*null
         and NullInd(4)<>*zero;
           ARMONPSLOG.SQLSTR+='NULL';
         Else;
           ARMONPSLOG.SQLSTR+=%char(SCHBDG);
         EndIf;
       EndIf;

       ARMONPSLOG.SQLSTR+=')';

       EXEC SQL
        Set :ARMONPSLOG.STARTDATE=Now();
       If SqlCod<>*zero;
         ARMONPSLOG.STARTDATE=%timestamp();
       EndIf;

       ARMONPSLOG.ENDDATE=ARMONPSLOG.STARTDATE;

       ARMONPSLOG.ELAPS00001=*zero;

       ARMONPSLOG.STATUS=*blanks;

       ARMONPSLOG.INTJOBID=wk_InJbId;

       Return;
     P                 E

     PWrite_Log        B
     D                 PI
     D Status                              like(ARMONPSLOG.STATUS) value

       ARMONPSLOG.STATUS=Status;
       EXEC SQL
        Set :ARMONPSLOG.ENDDATE=Now();
       If SqlCod<>*zero;
         ARMONPSLOG.ENDDATE=%timestamp();
       EndIf;

       EXEC SQL
        Set :ARMONPSLOG.ELAPS00001=
        (DEC(TIMESTAMPDIFF(1, CHAR(:ARMONPSLOG.ENDDATE-:ARMONPSLOG.STARTDATE)))/
        1000000);
       If SqlCod<>*zero;
         ARMONPSLOG.ELAPS00001=
         (%diff(ARMONPSLOG.ENDDATE:ARMONPSLOG.STARTDATE:*ms)/1000000);
       EndIf;

       If %addr(NullInd)<>*null;
         If ptr<>%addr(NullInd);
           ptr=%addr(NullInd);
         EndIf;
         EXEC SQL
        insert into ARMONPSLOG(CALLER, USERLOG, STARTDATE, ENDDATE, ELAPSEDTIME,
          FUNC, STATUS, SQLSTR, INTJOBID) VALUES(:ARMONPSLOG.CALLER:NIn_001,
        :ARMONPSLOG.USERLOG:NIn_002, :ARMONPSLOG.STARTDATE, :ARMONPSLOG.ENDDATE,
          :ARMONPSLOG.ELAPS00001, :ARMONPSLOG.FUNC:NIn_003, :ARMONPSLOG.STATUS,
          :ARMONPSLOG.SQLSTR, :ARMONPSLOG.INTJOBID) WITH NC;
       Else;
         EXEC SQL
        insert into ARMONPSLOG(CALLER, USERLOG, STARTDATE, ENDDATE, ELAPSEDTIME,
          FUNC, STATUS, SQLSTR, INTJOBID) VALUES(:ARMONPSLOG.CALLER,
        :ARMONPSLOG.USERLOG,         :ARMONPSLOG.STARTDATE, :ARMONPSLOG.ENDDATE,
          :ARMONPSLOG.ELAPS00001, :ARMONPSLOG.FUNC,         :ARMONPSLOG.STATUS,
          :ARMONPSLOG.SQLSTR, :ARMONPSLOG.INTJOBID) WITH NC;
       EndIf;
       Clear SqlCA;
       SQLSTATE=*zeros;
       Return;
     P                 E
```
