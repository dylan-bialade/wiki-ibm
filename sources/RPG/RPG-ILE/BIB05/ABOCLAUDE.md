---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: ABOCLAUDE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 313
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/ABOCLAUDE

```rpg
**free
// **********************************************************************//
// Programme: ABOCLAUDE
// Description: Gestion des abonnés par sous-fichier
// Auteur: NOTOS/ARMONIE (généré par Agent RPG v3.1)
// Date: 2026-01-05
// **********************************************************************//
ctl-opt copyright('(C) ARMONIE 2026.') dftactgrp(*no) actgrp(*caller)
option(*nodebugio:*srcstmt) datfmt(*iso) timfmt(*iso) bnddir('BNDOUTILS');

// **********************************************************************//
// Déclaration des fichiers                                              //
// **********************************************************************//
dcl-f ABODSPCL WORKSTN SFILE(SFLAB:RANG) INFDS(INFDS);

// **********************************************************************//
// Déclaration des prototypes                                            //
// **********************************************************************//
/copy QF_RPG/QRPGLESRC,GESTION_ER

// **********************************************************************//
// Déclaration des variables                                             //
// **********************************************************************//
dcl-s RANG zoned(4:0) inz(*zero);
dcl-s datejour date(*iso) inz(*job);
dcl-s dernierNUMABO packed(5:0) inz(*zero);

dcl-ds INFDS;
  touche char(1) pos(369);
end-ds;

//**********************************************************************//
// Déclaration des constantes                                           //
//**********************************************************************//
dcl-c AFFICHER  const('5');
dcl-c SUPPRIMER const('4');
dcl-c MODIFIER  const('2');

// Compilateur SQL
EXEC SQL
  SET option commit = *none, alwcpydta = *optimize, closqlcsr = *endmod,
  Datfmt = *iso, Timfmt = *iso;

// **********************************************************************//
// Traitement principal                                                  //
// **********************************************************************//

init_sous_fichier();
fab_sous_fichier();
SNUMABO = *zero;

Dou *IN03;
  write MSGSFLH;
  write FKEY1;
  Exfmt SFLABCTL;
  vidMsgQ(PGMPRC: *zero: *blanks: '*ALL': errorDS);

  select;

  when SNUMABO <> *zero;
    exec sql close c1;
    init_sous_fichier();
    fab_sous_fichier();
    clear SNUMABO;

  when *in05;
    exec sql close c1;
    init_sous_fichier();
    fab_sous_fichier();

  when *in06;
    creation();
    exec sql close c1;
    init_sous_fichier();
    fab_sous_fichier();

  other;
    exec sql
      SELECT NUMABO INTO :e1numabo FROM ABO;

    if sqlcode <> 100;
      trt_readc();
    endif;

    exec sql close c1;
    init_sous_fichier();
    fab_sous_fichier();

  endsl;

enddo;

exec sql close c1;
*Inlr = *On;

// **********************************************************************//
// PROCÉDURES                                                            //
// **********************************************************************//

dcl-proc init_sous_fichier;
  RANG = *Zero;
  *In31 = *On;
  Write SFLABCTL;
  *In31 = *Off;
  *In32 = *Off;
  *In61 = *Off;
  *In90 = *Off;

  EXEC SQL
    Declare C1 CURSOR FOR
    (select NUMABO, NOMABO, PREABO, ISBN
     from ABO
     where NUMABO >= :SNUMABO
     order by NUMABO)
    FOR READ ONLY OPTIMIZE FOR 12 ROWS;

  EXEC SQL open C1;
end-proc;

dcl-proc fab_sous_fichier;
  Dow sqlcode = 0;
    EXEC SQL Fetch C1 into :e1numabo, :e1nomabo, :e1preabo, :e1isbn;

    if sqlcode = 100;
      *IN90 = *ON;
      leave;
    endif;

    RANG += 1;
    clear OPT;
    Write SFLAB;

    if sqlcode = 100 or rang >= 12;
      *in32 = *on;
      leave;
    endif;
  enddo;

  if RANG = *Zero;
    *In32 = *On;
  else;
    rang = 1;
  endif;
end-proc;

dcl-proc TRT_READC;
  Readc SFLAB;
  dow not %eof;
    select;
    when opt = AFFICHER;
      affiche();
    when opt = SUPPRIMER;
      suppression();
    when opt = MODIFIER;
      modification();
    endsl;
    Readc SFLAB;
  enddo;
end-proc;

dcl-proc creation;
  clear e6numabo;
  clear e6nomabo;
  clear e6preabo;
  clear e6isbn;

  dou *in03 or *in12;
    exfmt FMT6;
    vidMsgQ(PGMPRC: *zero: *blanks: '*ALL': errorDS);

    select;
    when *in03 or *in12;
      leave;

    when *in23;
      // Validation
      if e6numabo = 0;
        *in70 = *on;
        iter;
      endif;

      exec sql
        INSERT INTO ABO (NUMABO, NOMABO, PREABO, ISBN)
        VALUES (:e6numabo, :e6nomabo, :e6preabo, :e6isbn);

      if sqlcode = 0;
        SndPgmMsg('Abonné créé avec succès');
        leave;
      else;
        gstErrSQL();
      endif;

    endsl;
  enddo;
end-proc;

dcl-proc affiche;
  exec sql
    SELECT NUMABO, NOMABO, PREABO, ISBN
    INTO :e5numabo, :e5nomabo, :e5preabo, :e5isbn
    FROM ABO
    WHERE NUMABO = :e1numabo;

  if sqlcode = 0;
    exfmt FMT5;
  else;
    gstErrSQL();
  endif;
end-proc;

dcl-proc modification;
  exec sql
    SELECT NUMABO, NOMABO, PREABO, ISBN
    INTO :e2numabo, :e2nomabo, :e2preabo, :e2isbn
    FROM ABO
    WHERE NUMABO = :e1numabo;

  if sqlcode <> 0;
    gstErrSQL();
    return;
  endif;

  dou *in03 or *in12;
    exfmt FMT2;
    vidMsgQ(PGMPRC: *zero: *blanks: '*ALL': errorDS);

    select;
    when *in03 or *in12;
      leave;

    when *in23;
      exec sql
        UPDATE ABO
        SET NOMABO = :e2nomabo,
            PREABO = :e2preabo,
            ISBN = :e2isbn
        WHERE NUMABO = :e2numabo;

      if sqlcode = 0;
        SndPgmMsg('Abonné modifié avec succès');
        // Mise à jour du sous-fichier
        e1nomabo = e2nomabo;
        e1preabo = e2preabo;
        e1isbn = e2isbn;
        leave;
      else;
        gstErrSQL();
      endif;

    endsl;
  enddo;
end-proc;

dcl-proc suppression;
  exec sql
    SELECT NUMABO, NOMABO, PREABO, ISBN
    INTO :e4numabo, :e4nomabo, :e4preabo, :e4isbn
    FROM ABO
    WHERE NUMABO = :e1numabo;

  if sqlcode <> 0;
    gstErrSQL();
    return;
  endif;

  exfmt FMT4;
  vidMsgQ(PGMPRC: *zero: *blanks: '*ALL': errorDS);

  if *in23;
    exec sql
      DELETE FROM ABO WHERE NUMABO = :e4numabo;

    if sqlcode = 0;
      SndPgmMsg('Abonné supprimé avec succès');
    else;
      gstErrSQL();
    endif;
  endif;
end-proc;

Dcl-Proc gstErrSQL;
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

    msgDataLen = %len(msgData);
    Qmhsndpm(msgId : 'QCPFMSG   QSYS      ' : msgData
              : msgDataLen : '*ESCAPE': PGMPRC : 2 : msgKey : Errcode);
  endif;
End-Proc;

dcl-proc SndPgmMsg;
  dcl-pi *n extproc(*dclcase);
    PMsgDta Char(512) options(*varsize) const;
  end-pi;
  dcl-s msgkey char(4);
  dcl-s STACK_OFFSET int(10) inz(0);

  Qmhsndpm('CPF9897':'QCPFMSG   QSYS':
          PMsgDta:
          %LEN(PMsgDta):'*DIAG':
          PGMPRC:STACK_OFFSET:msgkey:Errcode);
end-proc;
```
