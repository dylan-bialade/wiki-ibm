---
bibliotheque: BIB25
fichier_source: QTEST
membre: ERR
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 55
modifie: 2026-11-25
---

# BIB25/QTEST/ERR

```rpg
**free
ctl-opt dftactgrp(*no);

dcl-pr QMHSNDPM extpgm('QMHSNDPM');
  msgID char(7) const;
  qlfMsgF char(20) const;
  msgData char(256) const;
  msgDataLen int(10) const;
  msgType char(10) const;
  callStkEnt char(10) const;
  callStkCnt int(10) const;
  msgKey char(4);
  error char(1024) options(*varsize) noopt;
end-pr;

exec sql
set option commit = *none;

exec sql
delete from fichier where zone = 1;


getErrSQL();

*inlr = *on;
Dcl-Proc getErrSQL;
  // Pour envoi de messages d'erreur.
  // Pour l'envoi de messages d'erreur
  dcl-s msgId      char(7) inz('CPF9898');
  dcl-s msgData    char(256);
  dcl-s msgText    char(256);
  dcl-s msgKey     char(4);
  dcl-s CallStack  char(10) inz('*');
  dcl-s ErrorCode  char(1024);

  if sqlCode < 0;
    msgData = 'Erreur SQL ' + %char(sqlcode);
    exec sql get diagnostics condition 1
         :msgText = MESSAGE_TEXT;

    if %len(msgText) > 0;
      msgData = msgData + ' : ' + %trim(msgText);
    endif;

    QMHSNDPM(msgId :
           'QCPFMSG   *LIBL' :
           %trimr(msgData) :
           %len(%trimr(msgData)) :
           '*ESCAPE':
           CallStack:
           *zero :
           msgKey :
           ErrorCode);
  endif;
End-Proc;
```
