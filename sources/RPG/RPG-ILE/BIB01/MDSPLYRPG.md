---
bibliotheque: BIB01
fichier_source: QRPGLESRC
membre: MDSPLYRPG
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 209
modifie: 2026-11-16
---

# BIB01/QRPGLESRC/MDSPLYRPG

```rpg
**FREE
// --------------------------------------------------------------------------//
// Programme : MDSPLYRPG.RPGLE                                             //
// Libellé   :                                                               //
// --------------------------------------------------------------------------//
// Projet    :                                                               //
// Auteur    : BIB01 QUILLERE                                               //
// Date      : 01/04/2026                                                    //
// --------------------------------------------------------------------------//
// Date       | Auteur     | Descriptif                                      //
// --------------------------------------------------------------------------//
// 24/01/2025 | BIB01     | Création TOTO                                   //
// --------------------------------------------------------------------------//

CTL-OPT COPYRIGHT('(C) ARMONIE 2026.') USRPRF(*USER) OPTIMIZE(*NONE)
       DFTACTGRP(*NO) ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO)
       ALLOC(*STGMDL) STGMDL(*INHERIT) bnddir('BNDADRIEN');

// **************************************************************************//
// Paramètres en entrée                                                      //
// **************************************************************************//

DCL-PI *N;
  // XXXXX
END-PI;

// **************************************************************************//
// Déclaration des prototypes                                                //
// **************************************************************************//

dcl-pr mdsplycl ;
  txt char(250) const;
end-pr;

// --- QCmdExc : Exécution d'une commande CL --------------------------------//
dcl-pr QCmdExc extpgm('QSYS/QCMDEXC');
  Cmd char(32702) options(*varsize) const;
  Len packed(15:5) const;
end-pr;

// --- Qmhsndpm : Envoi un message à une PGMQ -------------------------------//
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

// --- Qmhrcvpm : Récupération des messages à partir d'une PGMQ -------------//
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


// **************************************************************************//
// Déclaration des data-structures                                           //
// **************************************************************************//

// PSDS : Program Status Data-Structure -------------------------------------//
dcl-ds *N PSDS;
  wk_NomPgm char(10) pos(1);
  wk_PgmErI char(7) pos(40);
  wk_PgmLib char(10) pos(81);
  wk_PgmErM char(80) pos(91);
  wk_PgmDt8 char(8) pos(191);
  wk_NomJob char(10) pos(244);
  wk_NomUser char(10) pos(254);
  wk_NomNbr char(6) pos(264);
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

DCL-s Cmd varchar(32702);
Dcl-s txt150 char(250);
// **************************************************************************//
//               T R A I T E M E N T    P R I N C I P A L                    //
// **************************************************************************//
DoU (1=1);
  // Début du programme -----------------------------------------------------//

txt150 = 'test de message de 150 caractères pour la fonction mdsplycl';

  Callp(e) mdsplycl(txt150);

  // Fin du programme -------------------------------------------------------//
EndDo;
*inlr = *on;

// **************************************************************************//
//          F I N    T R A I T E M E N T    P R I N C I P A L                //
// **************************************************************************//


// **************************************************************************//
// Sous-programme initial                                                    //
// **************************************************************************//

BegSR *InzSr;
EndSR;

// **************************************************************************//
// *PsSr : Gestion des exceptions.                                           //
// **************************************************************************//

BegSr *PsSr;
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
// **************************************************************************//
```
