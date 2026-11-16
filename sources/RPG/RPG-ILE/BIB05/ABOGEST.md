---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: ABOGEST
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 280
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/ABOGEST

```rpg
**free
// **********************************************************************//
// Programme: ABOGEST
// Description: Gestion de ABO par sous-fichier
// Auteur: NOTOS/ARMONIE (généré par Agent RPG v3.0)
// Date: 2026-01-02
// **********************************************************************//
ctl-opt copyright('(C) ARMONIE 2026.') dftactgrp(*no) actgrp(*caller)
option(*nodebugio:*srcstmt) datfmt(*iso) timfmt(*iso) bnddir('BNDOUTILS');

// **********************************************************************//
// Déclaration des fichiers                                              //
// **********************************************************************//
dcl-f ABODSPF WORKSTN SFILE(ABOSFL:RANG);

// **********************************************************************//
// Déclaration des prototypes                                            //
// **********************************************************************//

/copy QF_RPG/QRPGLESRC,GESTION_ER

// **********************************************************************//
// Déclaration des variables                                             //
// **********************************************************************//
dcl-s rang zoned(4:0) inz(*zero);
dcl-s datejour date(*iso) inz(*job);

//**********************************************************************//
// Déclaration des constantes                                           //
//**********************************************************************//
dcl-c AFFICHER  const('5');
dcl-c SUPPRIMER const('4');
dcl-c MODIFIER  const('2');
dcl-c SFLMAX 9999;

// Compilateur SQL
EXEC SQL
  SET option commit = *none, alwcpydta = *optimize, closqlcsr = *endmod,
  Datfmt = *iso, Timfmt = *iso;

// **********************************************************************//
// Traitement principal                                                  //
// **********************************************************************//

init_sous_fichier();
fab_sous_fichier();
snumabo = *zero;

Dou *IN03;
  write MSGSFLH;
  write fkey1;
  Exfmt ABOSFLctl;
  vidMsgQ(PGMPRC: *zero: *blanks: '*ALL': errorDS);

  select;
  when snumabo <> *zero;
    exec sql close c1;
    init_sous_fichier();
    fab_sous_fichier();
    clear snumabo;

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
  Write ABOSFLctl;
  *In31 = *Off;
  *In32 = *Off;
  *In90 = *Off;

  EXEC SQL
    Declare C1 CURSOR FOR
    (select NUMABO, NOMABO, PREABO, ISBN
     from ABO
     order by NUMABO)
    FOR READ ONLY OPTIMIZE FOR 12 ROWS;

  EXEC SQL open C1;
end-proc;

dcl-proc fab_sous_fichier;
  Dow (Not (sqlcode = 100)) And (RANG <= SFLMAX);
    EXEC SQL Fetch C1 into :e1numabo, :e1nomabo, :e1preabo, :e1isbn;

    if sqlcode = 100;
      *IN90=*ON;
      leave;
    endif;

    if e1numabo >= snumabo;
      RANG += 1;
      Write ABOSFL;
    endif;

    if sqlcode = 100 or rang = sflmax;
      *in32 = *on;
      LEAVE;
    endif;
  enddo;

  if RANG = *Zero;
    *In32 = *On;
  else;
    rang = 1;
  endif;
end-proc;

dcl-proc TRT_READC;
  Readc ABOSFL;
  dow not %eof;
    select;
    when opt = AFFICHER;
      affiche();
    when opt = SUPPRIMER;
      suppression();
    when opt = MODIFIER;
      modification();
    endsl;
    Readc ABOSFL;
  enddo;
end-proc;

dcl-proc creation;
  clear e6numabo;
  clear e6nomabo;
  clear e6preabo;
  clear e6isbn;

  dou *in03;
    exfmt FMT6;
    vidMsgQ(PGMPRC: *zero: *blanks: '*ALL': errorDS);

    select;
    when *in03;
      iter;
    when *in12;
      leave;
    when *in23;
      exec sql
        INSERT INTO ABO (NUMABO, NOMABO, PREABO, ISBN)
        VALUES (:e6numabo, :e6nomabo, :e6preabo, :e6isbn);
      gstErrSQL();
      SndPgmMsg('Ajout réussi');
      leave;
    endsl;
  enddo;

  clear opt;
end-proc;

dcl-proc affiche;
  exec sql
    SELECT NUMABO, NOMABO, PREABO, ISBN
    INTO :e5numabo, :e5nomabo, :e5preabo, :e5isbn
    FROM ABO
    WHERE NUMABO = :e1numabo;

  exfmt FMT5;
  clear opt;
end-proc;

dcl-proc modification;
  exec sql
    SELECT NUMABO, NOMABO, PREABO, ISBN
    INTO :e2numabo, :e2nomabo, :e2preabo, :e2isbn
    FROM ABO
    WHERE NUMABO = :e1numabo;

  dou *in03;
    exfmt FMT2;

    select;
    when *in03;
      iter;
    when *in12;
      leave;
    when *in23;
      exec sql
        UPDATE ABO
        SET NUMABO = :e2numabo,
            NOMABO = :e2nomabo,
            PREABO = :e2preabo,
            ISBN = :e2isbn
        WHERE NUMABO = :e2numabo;
      gstErrSQL();
      SndPgmMsg('Modification réussie');
      leave;
    endsl;
  enddo;

  clear opt;
  update ABOSFL;
end-proc;

dcl-proc suppression;
  exec sql
    SELECT NUMABO, NOMABO, PREABO, ISBN
    INTO :e4numabo, :e4nomabo, :e4preabo, :e4isbn
    FROM ABO
    WHERE NUMABO = :e1numabo;

  exfmt FMT4;
  clear opt;

  if *in23;
    exec sql
      DELETE FROM ABO WHERE NUMABO = :e4numabo;
    gstErrSQL();
    SndPgmMsg('Suppression réussie');
  endif;

  update ABOSFL;
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
