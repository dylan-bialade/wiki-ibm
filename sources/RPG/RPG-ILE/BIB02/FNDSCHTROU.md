---
bibliotheque: BIB02
fichier_source: QSRC
membre: FNDSCHTROU
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 860
modifie: 2026-11-16
---

# BIB02/QSRC/FNDSCHTROU

```rpg
**free
//------------------------------------------------------------------------*
//   Programme : FNDSCHTROU                                               *
//   Libellé   : Procédure stockée FIND_SCHTROUMPF                        *
//------------------------------------------------------------------------*
//   Projet    : FORMATION                                                *
//*   Auteur    : Xavier MACAREZ                                           *
//*   Date      : 15/02/2023                                               *
//*------------------------------------------------------------------------*
//*
//* Entrées : -/- CURRENT_SERVER, CURRENT_USER, CURRENT CLIENT_APPLNAME
//* Sorties : -/-
//*
Ctl-Opt COPYRIGHT('(C) ORGFORM 2025.')  OPTIMIZE(*FULL);
Ctl-Opt DFTACTGRP(*NO) ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO);
Ctl-Opt ALLOC(*STGMDL) STGMDL(*INHERIT) THREAD(*SERIALIZE);
Ctl-Opt PGMINFO(*PCML:*DCLCASE:*MODULE);

//**************************************************************************
//* Paramétres en entrée                                                   *
//**************************************************************************
Dcl-PI *N;
  CALLER                    like(ARMONPSLOG.CALLER);
  USER                      like(ARMONPSLOG.USERLOG);
  FUNCTION                  like(ARMONPSLOG.FUNC);
  NOM                       like(SCHTROUMPF.SCHNOM);
  NullInd        Bindec(4)  dim(4);
End-PI;

//**************************************************************************
//* Déclaration des prototypes                                             *
//**************************************************************************

Dcl-PR Qcmdexc  extpgm('QSYS/QCMDEXC');
  Cmd            Char(32702) options(*varsize) const;
  Len            Packed(15:5) const;
End-PR;

// Gestion des erreurs
//
dcl-pr Qmhsndpm extpgm('QSYS/QMHSNDPM');
  MsgId char(7) const;
  MsgF char(20) const;
  MsgDta char(512) options(*varsize) const;
  MsgDtaLen bindec(9:0) const;
  MsgType char(10) const;
  PgmQ char(10) const;
  Stk char(4) const;
  MsgKey char(4) const;
  ApiErr char(4) const;
  CSEntLn char(4) options(*nopass) const;
  CSEntQual char(20) options(*nopass) const;
  DPMSWT bindec(9:0) options(*nopass) const;
end-pr;
//
dcl-pr Qmhrcvpm extpgm('QSYS/QMHRCVPM');
  RcvM0200 char(688) options(*varsize) const;
  FmtLen bindec(9:0) const;
  FmtNam char(8) const;
  PgmQ char(10) const;
  Stk char(4) const;
  MsgType char(10) const;
  MsgKey char(4) const;
  Wait char(4) const;
  Act char(10) const;
  ApiErr char(4) const;
end-pr;
//
dcl-ds RcvM0200 inz;
  BytRtn bindec(9:0) pos(1);
  BytAvl bindec(9:0) pos(5);
  MsgSev bindec(9:0) pos(9);
  MsgId char(7) pos(13);
  MsgTyp char(2) pos(20);
  MsgKey char(4) pos(22);
  MsgFNM char(10) pos(26);
  MsgFLS char(10) pos(36);
  MsgFLU char(10) pos(46);
  SndJob char(10) pos(56);
  SndUsr char(10) pos(66);
  SndNbr char(6) pos(76);
  SndPgm char(10) pos(82);
  //
  SndDat char(7) pos(98);
  SndTim char(6) pos(105);
  //
  DtaLnr bindec(9:0) pos(153);
  DtaLna bindec(9:0) pos(157);
  MsgLnr bindec(9:0) pos(161);
  MsgLna bindec(9:0) pos(165);
  HlpLnr bindec(9:0) pos(169);
  HlpLna bindec(9:0) pos(173);
  MsgDta varchar(512) pos(177);
end-ds;
//

//**************************************************************************
// Déclaration de data-structures                                         *
//************************************************************************

Dcl-DS SCHTROUMPF  EXTNAME('BIB02/SCHTROUMPF') QUALIFIED;
  Dcl-DS ARMONPSLOG  EXTNAME('BIB02/ARMONPSLOG') QUALIFIED;

    //Variables système
    //Program Status Data-Structure
    dcl-ds *N PSDS;
      wk_NomPgm char(10) pos(1);
      wk_PgmErI char(7) pos(40);
      wk_PgmLib char(10) pos(81);
      wk_PgmErM char(80) pos(91);
      wk_PgmDt8 char(8) pos(191);
      wk_NomJob char(10) pos(244);
      wk_NomUser char(10) pos(254);
      wk_NomNbr char(6) pos(264);
      wk_CurUsr char(10) pos(358);
      wk_InJbId char(16) pos(380);
    end-ds;
    //
    //*************************************************************************
    //Déclaration des variables                                              *
    //************************************************************************

    // Variables PGM
    Dcl-DS Prm_NIn  based(Ptr);
      NIn_001                   like(NullInd);
      NIn_002                   like(NullInd);
      NIn_003                   like(NullInd);
      NIn_004                   like(NullInd);
    End-DS;

Dcl-S Cmd          Varchar(32702);
Dcl-DS Rcd_NIn;
  NIn_xxx        Bindec(4)  dim(9);
End-DS;
dcl-DS SCHTBL  LIKEDS(SCHTROUMPF) DIM(*AUTO:93183);
Dcl-DS TBL_NIn  QUALIFIED DIM(*AUTO:93183);
  NIn_001                   like(NIn_xxx);
  NIn_002                   like(NIn_xxx);
  NIn_003                   like(NIn_xxx);
  NIn_004                   like(NIn_xxx);
  NIn_005                   like(NIn_xxx);
  NIn_006                   like(NIn_xxx);
  NIn_007                   like(NIn_xxx);
  NIn_008                   like(NIn_xxx);
  NIn_009                   like(NIn_xxx);
End-DS;
Dcl-S i            Packed(7:0);
Dcl-S P                       like(i);

Dcl-S Inf                     like(i);
Dcl-S Sup                     like(i);

Dcl-DS STACK_INFO  inz;
  ORDIN00001     Bindec(9);
  PROGR00001     Char(10);
  PROGR00002     Char(10);
  MODUL00001     Char(10);
  PROCE00001     Varchar(4096);
End-DS;

Dcl-S CURORDPOS               like(ORDIN00001);



//**********************************************************************//
//Consignes de compilations SQL                                         //
//**********************************************************************//

//Gestion du contrôle de validation, des performances, de la fermeture du
EXEC SQL
SET OPTION COMMIT = *NONE, ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD,
 DATFMT = *ISO, TIMFMT = *ISO;

//**********************************************************************//
//               T R A I T E M E N T    P R I N C I P A L               //
//**********************************************************************//

DoU (1=1);
  //Initialisation
  If ARMONPSLOG.ENDDATE<>ARMONPSLOG.STARTDATE or
  ARMONPSLOG.ELAPS00001<>*zero or
  ARMONPSLOG.STATUS<>*blanks;
    CallP(e) Init_Log();
    *InLr=%error();
    If *InLr;
      Leave;
    EndIf;
  EndIf;

  //* Recherche d'un programme applicatif (dans la liste d'appel des progr.) *
  EXEC SQL
  DECLARE STACK_INFO CURSOR FOR (SELECT
  ORDINAL_POSITION, UCASE(PROGRAM_NAME), UCASE(PROGRAM_LIBRARY_NAME),
  CASE WHEN MODULE_NAME IS NULL THEN '*NONE' ELSE UCASE(MODULE_NAME) END,
  IFNULL(PROCEDURE_NAME, '')
    FROM TABLE(QSYS2.STACK_INFO ('*', 'ALL')) WHERE
    PROGRAM_NAME IS NOT NULL AND PROGRAM_LIBRARY_NAME IS NOT NULL AND (
      STATEMENT_IDENTIFIERS IS NOT NULL OR MI_INSTRUCTION_NUMBER IS NOT NULL)
      ORDER BY ORDINAL_POSITION DESC) WITH NC
        FOR READ ONLY OPTIMIZE FOR ALL ROWS;
  Clear CURORDPOS;
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
  FETCH STACK_INFO INTO :STACK_INFO;
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
    FETCH STACK_INFO INTO :STACK_INFO;
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

  // Contrôle d'existence des paramétres
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

  *InLr=(%addr(NOM)=*null);
  If *InLr;
    MsgId='CPD0071';
    MsgDta=X'0000000A'+'NOM';
    Leave;
  ElseIf %addr(NullInd)<>*null;
    If NullInd(4)<>*zero;
      Clear NOM;
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

  //Contrôle de validité des paramétres

  //Le paramètre NOM doit être non null
  If NIn_004<>*zero;
    Clear SQLCA;
    SQLSTATE='23502';
    SqlCod=-407;
    SqlErm=X'0000'+X'0000'+X'0002'+'*N'+X'0002'+'*N'+X'0003'+'NOM'+
      X'0004'+X'0003'+'NOM';
    *InLr=*On;
    MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
      %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
    MsgDta=SqlErm;
    Leave;
  EndIf;

  //(Au cas ou le curseur serait resté ouvert lors de l'appel précédent)
  EXEC SQL
    Close FNDSCHTROU;
  *InLr=(SqlCod<>*zero and SqlCod<>-501);
  If *InLr;
    MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
      %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
    MsgDta=SqlErm;
    Leave;
  EndIf;

  //Création du fichier temporaire FNDSCHTROU (vide en remplacement)
  EXEC SQL
  DECLARE GLOBAL TEMPORARY TABLE FNDSCHTROU LIKE SCHTROUMPF
    INCLUDING IMPLICITLY HIDDEN WITH REPLACE;
  *InLr=(SqlCod<>*zero);
  If *InLr;
    MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
    %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
    MsgDta=SqlErm;
    Leave;
  EndIf;

  //Chargement des enregistrements (et des variables indicateur) en tableaux
  If %elem(SCHTBL)<>*zero;
    Clear SCHTBL;
    %elem(SCHTBL)=*zero;
  EndIf;
  If %elem(TBL_NIn)<>*zero;
    Clear TBL_NIn;
    %elem(TBL_NIn)=*zero;
  EndIf;
  EXEC SQL
  DECLARE SCHTROUMPF CURSOR FOR (SELECT
  S.*, CRTPRF, CRTHDT, UPDPRF, UPDHDT FROM SCHTROUMPF S
  ) FOR READ ONLY OPTIMIZE FOR ALL ROWS;
  Clear SCHTROUMPF;
  Clear NIn_xxx;
  EXEC SQL
  OPEN SCHTROUMPF;
  *InLr=(SqlCod<>*zero);
  If *InLr;
    MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
    %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
    MsgDta=SqlErm;
    Leave;
  EndIf;
  EXEC SQL
  FETCH SCHTROUMPF INTO :SCHTROUMPF:NIn_xxx;
  *InLr=(SqlCod<>*zero and SqlCod<>100);
  If *InLr;
    MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
    %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
    MsgDta=SqlErm;
    Leave;
  EndIf;
  DoW (SqlCod<>100);
    %elem(SCHTBL)+=1;
    %elem(TBL_NIn)=%elem(SCHTBL);
    SCHTBL(%elem(SCHTBL))=SCHTROUMPF;
    TBL_NIn(%elem(TBL_NIn))=Rcd_NIn;
    EXEC SQL
    FETCH SCHTROUMPF INTO :SCHTROUMPF:NIn_xxx;
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
  CLOSE SCHTROUMPF;
  *InLr=(SqlCod<>*zero);
  If *InLr;
    MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
    %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
    MsgDta=SqlErm;
    Leave;
  EndIf;

  //Tri (à bulle) du tableau SCHTBL sur le nom (SCHNOM)
  If %elem(SCHTBL)>1;
    DoU P=*zero;
      Clear P;
      For i=1 to (%elem(SCHTBL)-1);
        If COMPARE(SCHTBL(i+1).SCHNOM:SCHTBL(i).SCHNOM)='>';
          SCHTROUMPF=SCHTBL(i);
          SCHTBL(i)=SCHTBL(i+1);
          SCHTBL(i+1)=SCHTROUMPF;
          P+=1;
          Rcd_NIn=TBL_NIn(i);
          TBL_NIn(i)=TBL_NIn(i+1);
          TBL_NIn(i+1)=Rcd_NIn;
        EndIf;
      EndFor;
    EndDo;
  EndIf;

  //Recherche dichotomique de l'argument NOM dans le tableau SCHTBL
  If %elem(SCHTBL)>*zero;
    Inf=1;
    Sup=%elem(SCHTBL);
    DoW Inf<>Sup and Sup<>Inf+1;
      Eval(h) i=(Inf+Sup)/2;
      Select;
      When COMPARE(SCHTBL(i).SCHNOM:NOM)='>';
        Inf=i;
      When COMPARE(SCHTBL(i).SCHNOM:NOM)='<';
        Sup=i;
      Other;
        Leave;
      EndSl;
    EndDo;

    //Insertion dans le fichier temporaire FNDSCHTROU du résultat de la recherche
    Select;
    When Inf=Sup;
      If COMPARE(SCHTBL(%div(Inf+Sup:2)).SCHNOM:NOM)='=';
        SCHTROUMPF=SCHTBL(%div(Inf+Sup:2));
        Rcd_NIn=TBL_NIn(%div(Inf+Sup:2));
        EXEC SQL
        INSERT INTO QTEMP.FNDSCHTROU (SCHBDG, SCHPR1, SCHPR2, SCHPR3,
        SCHNOM, CRTPRF, CRTHDT, UPDPRF, UPDHDT)
          VALUES(:SCHTROUMPF:NIn_xxx);
        *InLr=(SqlCod<>*zero);
        If *InLr;
          MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
            %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
          MsgDta=SqlErm;
          Leave;
        EndIf;
      EndIf;
    When Sup=Inf+1;
      If COMPARE(SCHTBL(Inf).SCHNOM:NOM)='=';
        SCHTROUMPF=SCHTBL(Inf);
        Rcd_NIn=TBL_NIn(Inf);
        EXEC SQL
        INSERT INTO QTEMP.FNDSCHTROU (SCHBDG, SCHPR1, SCHPR2, SCHPR3,
          SCHNOM, CRTPRF, CRTHDT, UPDPRF, UPDHDT)
            VALUES(:SCHTROUMPF:NIn_xxx);
        *InLr=(SqlCod<>*zero);
        If *InLr;
          MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
          %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
          MsgDta=SqlErm;
          Leave;
        EndIf;
      EndIf;
      If COMPARE(SCHTBL(Sup).SCHNOM:NOM)='=';
        SCHTROUMPF=SCHTBL(Sup);
        Rcd_NIn=TBL_NIn(Sup);
        EXEC SQL
          INSERT INTO QTEMP.FNDSCHTROU (SCHBDG, SCHPR1, SCHPR2, SCHPR3,
          SCHNOM, CRTPRF, CRTHDT, UPDPRF, UPDHDT)
          VALUES(:SCHTROUMPF:NIn_xxx);
        *InLr=(SqlCod<>*zero);
        If *InLr;
          MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
          %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
          MsgDta=SqlErm;
          Leave;
        EndIf;
      EndIf;
    Other;

      If i>1;
        For Inf=(i-1) downTo 1;
          If COMPARE(SCHTBL(Inf).SCHNOM:NOM)='=';
            SCHTROUMPF=SCHTBL(Inf);
            Rcd_NIn=TBL_NIn(Inf);
            EXEC SQL
            INSERT INTO QTEMP.FNDSCHTROU (SCHBDG, SCHPR1, SCHPR2, SCHPR3,
            SCHNOM, CRTPRF, CRTHDT, UPDPRF, UPDHDT)
              VALUES(:SCHTROUMPF:NIn_xxx);
            *InLr=(SqlCod<>*zero);
            If *InLr;
              MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
              %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
              MsgDta=SqlErm;
              Leave;
            EndIf;
          Else;
            Leave;
          EndIf;
        EndFor;
        If *InLr;
          Leave;
        EndIf;
      EndIf;

      SCHTROUMPF=SCHTBL(i);
      Rcd_NIn=TBL_NIn(i);
      EXEC SQL
        INSERT INTO QTEMP.FNDSCHTROU (SCHBDG, SCHPR1, SCHPR2, SCHPR3,
      SCHNOM, CRTPRF, CRTHDT, UPDPRF, UPDHDT)
      VALUES(:SCHTROUMPF:NIn_xxx);
      *InLr=(SqlCod<>*zero);
      If *InLr;
        MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
          %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
        MsgDta=SqlErm;
        Leave;
      EndIf;

      If i<%elem(SCHTBL);
        For Sup=(i+1) To %elem(SCHTBL);
          If COMPARE(SCHTBL(Sup).SCHNOM:NOM)='=';
            SCHTROUMPF=SCHTBL(Sup);
            Rcd_NIn=TBL_NIn(Sup);
            EXEC SQL
              INSERT INTO QTEMP.FNDSCHTROU (SCHBDG, SCHPR1, SCHPR2, SCHPR3,
              SCHNOM, CRTPRF, CRTHDT, UPDPRF, UPDHDT)
              VALUES(:SCHTROUMPF:NIn_xxx);
            *InLr=(SqlCod<>*zero);
            If *InLr;
              MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
              %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
              MsgDta=SqlErm;
              Leave;
            EndIf;
          Else;
            Leave;
          EndIf;
        EndFor;
        If *InLr;
          Leave;
        EndIf;
      EndIf;

    EndSl;
  EndIf;

  //Déclaration du curseur (résultat de la requête)
  EXEC SQL
  DECLARE FNDSCHTROU CURSOR WITH HOLD FOR (SELECT
    * FROM QTEMP.FNDSCHTROU ORDER BY SCHBDG
      ) FOR READ ONLY OPTIMIZE FOR ALL ROWS;

  //Ouverture du curseur
  EXEC SQL
    OPEN FNDSCHTROU;

  If SqlCod=*zero;
    //Assignation du curseur à l'ensemble de résultats renvoyé (par la procédu
    EXEC SQL
    SET RESULT SETS CURSOR FNDSCHTROU;

  EndIf;
  *InLr=(SqlCod<>*zero);
  If *InLr;
    MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
      %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
    MsgDta=SqlErm;
    Leave;
  EndIf;

//Fin du programme.
EndDo;
If *InLr;
  ExSr *PsSR;
EndIf;
*InRt = not(*InLr);

//**********************************************************************//
//          F I N    T R A I T E M E N T    P R I N C I P A L           //
//**********************************************************************//

//Ecriture dans le fichier log (ARMONPSLOG)
CallP(e) Write_Log('OK');

//**************************************************************************
//* *InzSR : Initialisation.                                               *
//**************************************************************************

BegSR *InzSR;
  //Initialisation de l'enregistrement de log
  CallP(e) Init_Log();
  *InLr=%error();
  If *InLr;
    ExSR *PsSR;
  EndIf;

EndSR;

//**********************************************************************//
//*PsSR : Gestion des exceptions.                                       //
//**********************************************************************//

BegSR *PsSR;
  //
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
        MsgId='CPF3CF2';
        MsgDta='QMHRCVPM';
        MsgFNM='QCPFMSG';
        MsgFLU='QSYS';
      ElseIf MsgId<>*blanks;
        MsgDta=%subst(RcvM0200:1+%size(RcvM0200)-
             %size(MsgDta):DtaLnr);
      Else;
        MsgId='CAE0031';
        MsgDta='QMHRCVPM';
        MsgFNM='QCPFMSG';
        MsgFLU='QSYS';
      EndIf;
    EndIf;
  EndIf;
  //

  EXEC SQL
  Close SCHTROUMPF;
  If SqlCod=-501;
    Clear SqlCA;
    SQLSTATE=*zeros;
  EndIf;
  //
  //Ecriture dans le fichier log (ARMONPSLOG)                              *
  CallP(e) Write_Log('KO');
  //                                                                       *
  If CURORDPOS<>*zero and ORDIN00001<CURORDPOS and (%trim(PROGR00001)<>
  %trim(wk_NomPgm) or %trim(PROGR00002)<>%trim(wk_PgmLib));
    If MsgFNM=*blanks;
      If %subst(MsgId:1:3)='CPF' or
        %subst(MsgId:1:3)='SQL' or
      %subst(MsgId:1:3)='JVA' or
        %subst(MsgId:1:3)='RNX' or
        %subst(MsgId:1:3)='TCP';
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
      If %subst(MsgId:1:3)='CEE' or
         %subst(MsgId:1:3)='SQL' or
         %subst(MsgId:1:3)='JVA' or
         %subst(MsgId:1:3)='RNX' or
         %subst(MsgId:1:3)='TCP';
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
       (MsgId<>'CPF3CF2' or MsgDta<>'QMHSNDPM' or
        MsgFNM+MsgFLU<>'QCPFMSG   QSYS');
      MsgId='CPF3CF2';
      MsgDta='QMHSNDPM';
      MsgFNM='QCPFMSG';
      MsgFLU='QSYS';
      Iter;
    EndIf;
    Clear RcvM0200;
  EndDo;
//
EndSR '*CANCL';

//**************************************************************************
// Procédures (internes)                                                  *
//************************************************************************

DCL-PROC COMPARE;
  DCL-PI *N char(1);
    Str1 varchar(32740) value;
    Str2 varchar(32740) value;
  END-PI;

  DCL-S Ope char(1);

  EXEC SQL
    SET :Ope=CASE
    WHEN UCASE(TRIM(:Str1))>UCASE(TRIM(:Str2)) THEN '>'
    WHEN UCASE(TRIM(:Str1))<UCASE(TRIM(:Str2)) THEN '<'
    ELSE '=' END;
  *InLr=(SqlCod<>*zero);
  If *InLr;
    MsgId='SQL'+%subst(%editC(%abs(SqlCod):'X'):
    %len(SqlCod)-%size(MsgId)+%len('SQL')+1);
    MsgDta=SqlErm;
    Clear Ope;
  Else;
    Return Ope;
  EndIf;

END-PROC;

DCL-PROC Init_Log;
  DCL-PI *N;
  END-PI;

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

  If %addr(NOM)<>*null;
    If %addr(NullInd)<>*null
    and NullInd(4)<>*zero;
      ARMONPSLOG.SQLSTR+='NULL';
    Else;
      ARMONPSLOG.SQLSTR+=''''+NOM+'''';
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

END-PROC;

DCL-PROC Write_Log;
  DCL-PI *N;
    Status like(ARMONPSLOG.STATUS) value;
  END-PI;

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

END-PROC;
```
