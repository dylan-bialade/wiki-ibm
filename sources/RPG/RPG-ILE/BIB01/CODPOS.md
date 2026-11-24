---
bibliotheque: BIB01
fichier_source: QRPGLESRC
membre: CODPOS
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 270
modifie: 2026-11-16
---

# BIB01/QRPGLESRC/CODPOS

```rpg
**FREE
// --------------------------------------------------------------------------//
// Programme : CODPOS.RPGLE                                             //
// Libellé   :                                                               //
// --------------------------------------------------------------------------//
// Projet    :                                                               //
// Auteur    : BIB01 QUILLERE                                               //
// Date      : 24/03/2026                                                    //
// --------------------------------------------------------------------------//
// Date       | Auteur     | Descriptif                                      //
// --------------------------------------------------------------------------//
// 24/01/2025 | BIB01     | Création TOTO                                       //
// --------------------------------------------------------------------------//

CTL-OPT COPYRIGHT('(C) ORGFORM 2026.') USRPRF(*USER) OPTIMIZE(*NONE)
       DFTACTGRP(*NO) ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO)
       ALLOC(*STGMDL) STGMDL(*INHERIT);

// -------------------------------------------------------------------//
// Declaration des fichiers                                           //
// -------------------------------------------------------------------//
DCL-F ECODPOS Workstn(*EXT) sfile(WSFL:SFL_RRN)
                             INDDS(DsInd)
                             INFDS(DsEcran);

Dcl-f CODPOSPF Usage(*input) Keyed;


// **************************************************************************//
// Paramètres en entrée                                                      //
// **************************************************************************//

DCL-PI *N;
  P_CODPOS char(5) const;
END-PI;

// **************************************************************************//
// Déclaration des prototypes                                                //
// **************************************************************************//

// --- QCmdExc : Exécution d'une commande CL --------------------------------//
dcl-pr QCmdExc extpgm('QSYS/QCMDEXC');
  Cmd char(32702) options(*varsize) const;
  Len packed(15:5) const;
end-pr;

// Envoi message programme.
Dcl-PR Qmhsndpm  extpgm('QSYS/QMHSNDPM');
  MsgId          Char(7)    const;
  MsgF           Char(20)   const;
  MsgDta         Char(512)  options(*varsize) const;
  MsgDtaLen      Int(10)    const;
  MsgType        Char(10)   const;
  PgmQ           Char(10)   const;
  Stk            Int(10)    const;
  MsgKey         Char(4)    const;
  ErrorCode      likeds(errorDS);
End-pr;

// Vidage d une file de message
dcl-pr vidMsgQ  extpgm('QSYS/QMHRMVPM');
  MsgQueue       Char(276)   const;
  CallStack      Int(10)     const;
  MsgKey         Char(4)    const;
  MsgRmv         Char(10)   const;
  Error                     like( errorDS );
end-pr;


// **************************************************************************//
// Déclaration des data-structures                                           //
// **************************************************************************//

// Erreur restituee par l API QMHRMVPM.
Dcl-DS errorDS Len(16);
  ByteProv      Int(10)    inz(%size(errorDS));
  ByteAvail     Int(10);
  ExceptionID    Char(7);
End-DS;

Dcl-ds DsInd;
  SflDspCtl  Ind  Pos(60);
  SflDsp     Ind  Pos(61);
end-ds;

Dcl-Ds DsEcran;
  Touche  char(1) pos(369);
  ligne   Int(3) pos(370);
  colonne Int(3) pos(371);
  nbrcd_sfl  Int(5) Pos(380);
End-Ds;

// PSDS : Program Status Data-Structure -------------------------------------//
dcl-ds *N PSDS;
  PgmPrc *PROC;
  PgmSts *STATUS;
  PgmExr *ROUTINE;
  PgmPrm *PARMS;
  PgmEri char(7) pos(40);
  PgmLib char(10) pos(81);
  PgmErm char(80) pos(91);
  PgmDt8 char(8) pos(191);
  PgmJnm char(10) pos(244);
  PgmUsr char(10) pos(254);
  PgmJnb zoned(6:0) pos(264);
end-ds;

// RcvM0200 : Data-Structure de Qmhrcvpm pour la réception des messages -----//
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
  SndDat char(7) pos(98);
  SndTim char(6) pos(105);
  DtaLnr bindec(9:0) pos(153);
  DtaLna bindec(9:0) pos(157);
  MsgLnr bindec(9:0) pos(161);
  MsgLna bindec(9:0) pos(165);
  HlpLnr bindec(9:0) pos(169);
  HlpLna bindec(9:0) pos(173);
  MsgDta varchar(512) pos(177);
end-ds;

// **************************************************************************//
// Déclaration des variables                                                 //
// **************************************************************************//
Dcl-C F03        X'33';
Dcl-s SFL_RRN zoned(4:0);
Dcl-s wrequette Char(512);
DCL-s Cmd varchar(32702);
Dcl-S chemin char(200) inz('/home/data/CodePostauxFr.csv');

// **********************************************************************//
// Consignes de compilation SQL                                          //
// **********************************************************************//
// Gestion du contrôle de validation, des performances, etc ...
EXEC SQL
  SET OPTION COMMIT = *NONE, CLOSQLCSR = *ENDMOD,
  DYNUSRPRF = *USER, DATFMT = *ISO, TIMFMT = *ISO;

// **************************************************************************//
//               T R A I T E M E N T    P R I N C I P A L                    //
// **************************************************************************//
Dow *inlr = *off;
  // Début du programme -----------------------------------------------------//
  Chargement_SFL();
  EXFMT WCTL;

  Select;
    When Touche = F03;
      *inlr = *on;
  Endsl;

  // Fin du programme -------------------------------------------------------//
EndDo;

// **************************************************************************//
//          F I N    T R A I T E M E N T    P R I N C I P A L                //
// **************************************************************************//


// **************************************************************************//
// Sous-programme initial                                                    //
// **************************************************************************//

BegSR *InzSr;

  cmd = 'CPYFRMIMPF FROMSTMF(''' + %trim(CHEMIN)  + ''') TOFILE(FADRIEN3/CODPOSPF) +
 MBROPT(*ADD) FROMCCSID(1252) RCDDLM(*LF) FLDDLM('';'') RPLNULLVAL(*FLDDFT) +
 RMVCOLNAM(*YES)';

  QCmdExc(Cmd:%len(Cmd));

EndSR;

// ************************************************************************
Dcl-Proc Chargement_SFL;
// On vide le sous fichier
  Sfldspctl = *off;
  write WCTL;

  SFL_RRN = *zero;
  WOPT = *Blanks;
  wrequette = *Blanks;

// Requête de sélection
  wrequette = 'SELECT NOMCOM, CODPOS' +
  ' FROM CODPOSPF where 1 = 1';

// Filtres
  If WFLT <> *Blanks;
    wrequette = wrequette + ' AND NOMCOM > ' + WFLT;
  Endif;

// Ordre d'affichage
  wrequette = wrequette + ' ORDER BY NOMCOM';

  EXEC SQL
    Prepare P1 FROM :wrequette;
  gstErrSQL();

  EXEC SQL
    Declare C1 CURSOR FOR P1;
  gstErrSQL();

  EXEC SQL
    Open C1;
  gstErrSQL();

  If (sqlstate = '00000');
    Dou (sqlstate <> '00000') and SFL_RRN < 9999;
      EXEC SQL
      FETCH C1
      INTO :NOMCOM, :CODPOS;

      If (sqlstate = '00000');
        SFL_RRN += 1;
        Write WSFL;
      Endif;
    Enddo;
  Endif;

  EXEC SQL
    CLOSE C1;
  gstErrSQL();

// On active l'affichage du sous fichier
  If SFL_RRN > *zero;
    SflDsp = *on;
  endif;
  SflDspCtl = *on;
End-Proc;

// ------------------------------------------------------------------------------
// ************************************************************************
// Gestion Erreur *                                                       *
// ****************                                                       *
// ************************************************************************
Dcl-Proc gstErrSQL;
  // Pour envoi de messages d'erreur.
  dcl-s msgId char(7) inz('CPF9898');
  dcl-s msgData varchar(32767);
  dcl-s msgText varchar(256);
  dcl-s msgDataLen int(10);

  if sqlCode < 0;
    msgData = 'Erreur SQL ' + %char(sqlcode);
    exec sql get diagnostics condition 1
         :msgText = MESSAGE_TEXT;

    if %len(msgText) > 0;
      msgData = msgData + ' : ' + %trim(msgText);
    endif;

    msgDataLen =  %len(msgData);
    Qmhsndpm( msgId : 'QCPFMSG   QSYS      ' : msgData
              : msgDataLen : '*ESCAPE': PGMPRC : 2 : msgKey
              : errorDS );
  endif;
End-Proc;
```
