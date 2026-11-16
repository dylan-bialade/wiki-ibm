---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: GESTION_ER
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 55
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/GESTION_ER

```rpg
**free
// **********************************************************************//
// Déclaration des prototypes                                            //
// **********************************************************************//
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
  ErrorCode      likeds(Errcode);
End-pr;

// Vidage d une file de message
dcl-pr vidMsgQ  extpgm('QSYS/QMHRMVPM');
  MsgQueue       Char(276)   const;
  CallStack      Int(10)     const;
  MsgKey         Char(4)    const;
  MsgRmv         Char(10)   const;
  Error                     like( errorDS );
end-pr;

// **********************************************************************//
// Déclaration des DS                                                    //
// **********************************************************************//
dcl-ds *N PSDS;
  PgmPrc *PROC;
  PgmSts *STATUS;
  PgmExr *ROUTINE;
  PgmPrm *PARMS;
  PgmEri char(7)    pos(40);
  PgmLib char(10)   pos(81);
  PgmErm char(80)   pos(91);
  PgmDt8 char(8)    pos(191);
  PgmJnm char(10)   pos(244);
  PgmUsr char(10)   pos(254);
  PgmJnb zoned(6:0) pos(264);
end-ds;

Dcl-ds Errcode;
  BytesProv       Int(10) Inz(*zero);
  BytesAvail      Int(10) Inz(*zero);
End-ds;


// Erreur restituee par l API QMHRMVPM.
Dcl-DS errorDS Len(16);
  ByteProv      Int(10)    inz(%size(errorDS));
  ByteAvail     Int(10);
  ExceptionID   Char(7);
End-DS;
```
