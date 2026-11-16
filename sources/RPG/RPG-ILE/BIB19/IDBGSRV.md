---
bibliotheque: BIB19
fichier_source: QRPGLESRC
membre: IDBGSRV
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 888
modifie: 2026-11-16
---

# BIB19/QRPGLESRC/IDBGSRV

```rpg
**free
// ---------------------------------------------------------------------------
// IDBGSRV - agent ILE de BIB19 (service program)
//
// Execute, pour le processus Python de BIB19, ce qui doit tourner dans le
// travail interactif debogue : API du debogueur source (QTEDBGS), entrees-
// sorties du fichier ecran IDBGFM, sauvegarde/restauration de l'ecran du
// programme (DSM), commandes systeme et impression.
// Dialogue par deux files de donnees a cle (IDBGREQ : Python -> agent,
// IDBGRSP : agent -> Python), cle = identifiant de session (16 caracteres).
//
// Licence MIT
// ---------------------------------------------------------------------------
ctl-opt nomain option(*srcstmt: *nodebugio) ccsid(*char: *jobrun);

dcl-f IDBGFM workstn usropn infds(fmInfds) extfile(gFmName) extdesc('IDBGFM');
// Meme ecrans en 27x132 (DSPSIZ *DS4) : utilise si le terminal l'accepte
dcl-f IDBGFMW workstn usropn qualified infds(fmInfdsW) extfile(gFmNameW)
      extdesc('IDBGFMW');
dcl-f QSYSPRT printer(132) usropn;

// ------------------------------------------------------------- constantes --
dcl-c MAXBUF 64512;
dcl-c HDRLEN 276;          // 'RESULT  ' + msgid(7) + rsv(1) + lg(4) + donnees(256)

// ---------------------------------------------------------------- globales --
dcl-s gFmName char(21) inz('BIB19/IDBGFM');
dcl-s gFmNameW char(21) inz('BIB19/IDBGFMW');
dcl-s gWide ind inz(*off);          // ecrans en 27x132
dcl-s gSizeDone ind inz(*off);      // taille deja determinee
dcl-s gKey char(16);
dcl-s gLib char(10);
dcl-s gPyJob char(26);
dcl-s gIn char(MAXBUF);
dcl-s gInLen int(10);
dcl-s gOut char(MAXBUF);
dcl-s gOutLen int(10);
dcl-s gScr int(10) inz(0);
dcl-s gFileOpen ind inz(*off);
dcl-s gPrtOpen ind inz(*off);
dcl-s gHello ind inz(*off);
dcl-s gWork char(60000);
dcl-s gRetCmd char(3000);

dcl-ds fmInfds;
  fmAid char(1) pos(369);
  fmRow uns(3) pos(370);
  fmCol uns(3) pos(371);
end-ds;

dcl-ds fmInfdsW;
  fmAidW char(1) pos(369);
  fmRowW uns(3) pos(370);
  fmColW uns(3) pos(371);
end-ds;

dcl-ds pgmSds psds;
  sdsCurUser char(10) pos(358);
  sdsPgm char(10) pos(1);
  sdsExcp char(7) pos(40);
  sdsExcpDta char(80) pos(91);
  sdsLib char(10) pos(81);
  sdsJob char(26) pos(244);
end-ds;

dcl-ds errc_t qualified template;
  prov int(10);
  avail int(10);
  msgid char(7);
  rsv char(1);
  data char(512);
end-ds;
dcl-ds gErr likeds(errc_t);

dcl-ds prtLine len(132) end-ds;

// ------------------------------------------------------------ prototypes --
dcl-pr memcpy pointer extproc('memcpy');
  dst pointer value;
  src pointer value;
  len uns(10) value;
end-pr;

dcl-pr QSNDDTAQ extpgm('QSNDDTAQ');
  dtaq char(10) const;
  lib char(10) const;
  len packed(5: 0) const;
  data char(MAXBUF) const options(*varsize);
  keylen packed(3: 0) const;
  key char(16) const;
end-pr;

dcl-pr QRCVDTAQ extpgm('QRCVDTAQ');
  dtaq char(10) const;
  lib char(10) const;
  len packed(5: 0);
  data char(MAXBUF) options(*varsize);
  wait packed(5: 0) const;
  keyorder char(2) const;
  keylen packed(3: 0) const;
  key char(16);
  sndlen packed(3: 0) const;
  sndinf char(44) options(*varsize);
end-pr;

dcl-pr QUSRJOBI extpgm('QUSRJOBI');
  rcv char(200) options(*varsize);
  rcvlen int(10) const;
  fmt char(8) const;
  qjob char(26) const;
  intid char(16) const;
  err likeds(errc_t);
end-pr;

dcl-pr QCMDEXC extpgm('QCMDEXC');
  cmd char(3000) const options(*varsize);
  len packed(15: 5) const;
end-pr;

dcl-pr QUSCMDLN extpgm('QUSCMDLN');
end-pr;

dcl-pr QMHRTVM extpgm('QMHRTVM');
  rcv char(4096) options(*varsize);
  rcvlen int(10) const;
  fmt char(8) const;
  msgid char(7) const;
  qmsgf char(20) const;
  data char(1024) const options(*varsize);
  datalen int(10) const;
  repl char(10) const;
  fmtctl char(10) const;
  err likeds(errc_t);
end-pr;

dcl-pr QteStartSourceDebug extproc('QteStartSourceDebug');
  stphdlr char(20) const;
  err likeds(errc_t);
end-pr;
dcl-pr QteEndSourceDebug extproc('QteEndSourceDebug');
  err likeds(errc_t);
end-pr;
dcl-pr QteSetDebugAttribute extproc('QteSetDebugAttribute');
  attr char(10) const;
  val char(10) const;
  err likeds(errc_t);
end-pr;
dcl-pr QteRetrieveModuleViews extproc('QteRetrieveModuleViews');
  rcv char(60000) options(*varsize);
  rcvlen int(10) const;
  fmt char(8) const;
  qpgm char(20) const;
  pgmtype char(10) const;
  module char(10) const;
  retlib char(10);
  err likeds(errc_t);
end-pr;
dcl-pr QteRegisterDebugView extproc('QteRegisterDebugView');
  viewid int(10);
  lines int(10);
  retlib char(10);
  tstamp char(13);
  qpgm char(20) const;
  pgmtype char(10) const;
  module char(10) const;
  viewnbr int(10) const;
  err likeds(errc_t);
end-pr;
dcl-pr QteRemoveDebugView extproc('QteRemoveDebugView');
  viewid int(10) const;
  err likeds(errc_t);
end-pr;
dcl-pr QteRetrieveViewText extproc('QteRetrieveViewText');
  rcv char(60000) options(*varsize);
  rcvlen int(10) const;
  viewid int(10) const;
  start int(10) const;
  nlines int(10) const;
  linelen int(10) const;
  err likeds(errc_t);
end-pr;
dcl-pr QteMapViewPosition extproc('QteMapViewPosition');
  rcv char(60000) options(*varsize);
  rcvlen int(10) const;
  fromview int(10) const;
  fromline int(10) const;
  fromcol int(10) const;
  toview int(10) const;
  err likeds(errc_t);
end-pr;
dcl-pr QteSubmitDebugCommand extproc('QteSubmitDebugCommand');
  rcv char(60000) options(*varsize);
  rcvlen int(10) const;
  viewid int(10) const;
  inbuf char(4096) const options(*varsize);
  inlen int(10) const;
  compid char(20) const;
  err likeds(errc_t);
end-pr;

dcl-pr QsnSavScr int(10) extproc('QsnSavScr');
  inbuf int(10) options(*omit);
  cmdbuf int(10) const options(*omit);
  env int(10) const options(*omit);
  err likeds(errc_t) options(*omit);
end-pr;
dcl-pr QsnPutBuf int(10) extproc('QsnPutBuf');
  cmdbuf int(10) const;
  env int(10) const options(*omit);
  err likeds(errc_t) options(*omit);
end-pr;
dcl-pr QsnDltBuf int(10) extproc('QsnDltBuf');
  buf int(10) const;
  err likeds(errc_t) options(*omit);
end-pr;
dcl-pr QsnGetAID char(1) extproc('QsnGetAID');
  aid char(1) options(*omit);
  env int(10) const options(*omit);
  err likeds(errc_t) options(*omit);
end-pr;

/copy IDBGFMIO

// ===================================================== outils de tampon ==
dcl-proc newErr;
  clear gErr;
  gErr.prov = %size(gErr);
end-proc;

dcl-proc i4c;
  dcl-pi *n char(4);
    n int(10) value;
  end-pi;
  dcl-ds d;
    i int(10) pos(1);
    c char(4) pos(1);
  end-ds;
  i = n;
  return c;
end-proc;

dcl-proc ci4;
  dcl-pi *n int(10);
    c char(4) value;
  end-pi;
  dcl-ds d;
    i int(10) pos(1);
    cc char(4) pos(1);
  end-ds;
  cc = c;
  return i;
end-proc;

// entier (4 octets) a la position pos (1 = debut) de la requete
dcl-proc inInt;
  dcl-pi *n int(10);
    pos int(10) value;
  end-pi;
  return ci4(%subst(gIn: pos: 4));
end-proc;

dcl-proc outStart;
  dcl-pi *n;
    kind char(8) const;
  end-pi;
  gOut = *blanks;
  %subst(gOut: 1: 8) = kind;
  gOutLen = 8;
end-proc;

dcl-proc outResult;
  // en-tete de reponse : msgid + donnees du message d'erreur eventuel
  outStart('RESULT');
  %subst(gOut: 9: 7) = gErr.msgid;
  if gErr.msgid <> *blanks and gErr.avail > 16;
    %subst(gOut: 17: 4) = i4c(gErr.avail - 16);
    if gErr.avail - 16 > 256;
      %subst(gOut: 21: 256) = %subst(gErr.data: 1: 256);
    else;
      %subst(gOut: 21: gErr.avail - 16) = %subst(gErr.data: 1: gErr.avail - 16);
    endif;
  else;
    %subst(gOut: 17: 4) = i4c(0);
  endif;
  gOutLen = HDRLEN;
end-proc;

dcl-proc outChar;
  dcl-pi *n;
    s char(MAXBUF) const options(*varsize);
    len int(10) value;
  end-pi;
  if len <= 0;
    return;
  endif;
  if gOutLen + len > MAXBUF;
    len = MAXBUF - gOutLen;
  endif;
  %subst(gOut: gOutLen + 1: len) = %subst(s: 1: len);
  gOutLen += len;
end-proc;

dcl-proc outInt;
  dcl-pi *n;
    n int(10) value;
  end-pi;
  outChar(i4c(n): 4);
end-proc;

dcl-proc outMem;
  dcl-pi *n;
    p pointer value;
    len int(10) value;
  end-pi;
  if len <= 0;
    return;
  endif;
  if gOutLen + len > MAXBUF;
    len = MAXBUF - gOutLen;
  endif;
  memcpy(%addr(gOut) + gOutLen: p: len);
  gOutLen += len;
end-proc;

dcl-proc sendOut;
  QSNDDTAQ('IDBGRSP': gLib: gOutLen: gOut: 16: gKey);
end-proc;

// ============================================================ session ==
dcl-proc idbgInit export;
  dcl-pi *n;
    key char(16) const;
  end-pi;
  gKey = key;
  gLib = sdsLib;
  if gLib = *blanks;
    gLib = 'BIB19';
  endif;
  gFmName = %trim(gLib) + '/IDBGFM';
  gFmNameW = %trim(gLib) + '/IDBGFMW';
end-proc;

dcl-proc idbgEvent export;
  dcl-pi *n;
    kind char(8) const;
    data char(8192) const options(*varsize);
    len int(10) value;
  end-pi;
  outStart(kind);
  if len > 0;
    outChar(data: len);
  endif;
  sendOut();
end-proc;

// Le processus Python est-il encore actif ?
dcl-proc pyAlive;
  dcl-pi *n ind;
  end-pi;
  dcl-s rcv char(200);
  if gPyJob = *blanks;
    return *on;
  endif;
  newErr();
  QUSRJOBI(rcv: %size(rcv): 'JOBI0100': gPyJob: ' ': gErr);
  if gErr.msgid <> *blanks;
    return *off;
  endif;
  return %subst(rcv: 51: 7) = '*ACTIVE';
end-proc;

// Attente d'une requete ; *off si le processus Python a disparu
// Attente d'une requete ; *off si le processus Python a disparu.
// Securite : la file IDBGREQ est creee avec SENDERID(*YES) ; seules les requetes
// envoyees sous le meme profil utilisateur courant que ce travail sont acceptees.
dcl-proc receiveReq;
  dcl-pi *n ind;
  end-pi;
  dcl-s len packed(5: 0);
  dcl-s k char(16);
  dcl-ds snd len(44);
    sndRet packed(7: 0) pos(1);
    sndCurUser char(10) pos(35);
  end-ds;
  dcl-s waited int(10) inz(0);
  dow '1';
    k = gKey;
    snd = *blanks;
    QRCVDTAQ('IDBGREQ': gLib: len: gIn: 10: 'EQ': 16: k: 44: snd);
    if len > 0;
      if sndCurUser <> sdsCurUser;
        // requete d'un autre profil : ignoree
        iter;
      endif;
      gInLen = len;
      return *on;
    endif;
    waited += 10;
    if not gHello;
      if waited >= 120;
        return *off;
      endif;
    elseif not pyAlive();
      return *off;
    endif;
  enddo;
end-proc;

// =========================================================== aiguillage ==
dcl-proc idbgServe export;
  dcl-pi *n char(10);
  end-pi;
  dcl-s verb char(8);
  dcl-s act char(10);
  dow '1';
    if not receiveReq();
      return '*PYEND';
    endif;
    verb = %subst(gIn: 1: 8);
    newErr();
    outResult();
    monitor;
      select;
        when verb = 'HELLO';
          doHello();
        when verb = 'RETURN';
          act = %subst(gIn: 9: 10);
          gRetCmd = *blanks;
          if inInt(19) > 0;
            gRetCmd = %subst(gIn: 23: inInt(19));
          endif;
          outResult();
          sendOut();
          if act = 'END' or act = 'ERROR' or act = 'RETURN';
            closeFiles();
          endif;
          return act;
        when verb = 'DBGSTART';
          // mode debogage + gestionnaire de session IDBGSES (*START enregistre IDBGSTP)
          runCmd('STRDBG PGM(' + %trim(%subst(gIn: 23: 10)) + '/' +
                 %trim(%subst(gIn: 13: 10)) + ') UPDPROD(' + %trim(%subst(gIn: 9: 4)) +
                 ') OPMSRC(*NO) SRCDBGPGM(' + %trim(gLib) + '/IDBGSES) DSPMODSRC(*NO)');
          outResult();
        when verb = 'DBGEND';
          runCmd('ENDDBG');
          outResult();
        when verb = 'SETATTR';
          QteSetDebugAttribute(%subst(gIn: 9: 10): %subst(gIn: 19: 10): gErr);
          outResult();
        when verb = 'RTVMODV';
          doRtvModv();
        when verb = 'REGVIEW';
          doRegView();
        when verb = 'RMVVIEW';
          QteRemoveDebugView(inInt(9): gErr);
          outResult();
        when verb = 'VIEWTEXT';
          doViewText();
        when verb = 'MAPPOS';
          doMapPos();
        when verb = 'SUBMIT';
          doSubmit();
        when verb = 'SCREEN';
          saveScreen();
          doScreen();
        when verb = 'SAVESCR';
          saveScreen();
          outResult();
        when verb = 'RESTSCR';
          restoreScreen(*off);
          outResult();
        when verb = 'USERSCR';
          doUserScr();
        when verb = 'RTVMSG';
          doRtvMsg();
        when verb = 'CMDLINE';
          saveScreen();
          QUSCMDLN();
          outResult();
        when verb = 'QCMDEXC';
          saveScreen();
          doCmd();
        when verb = 'PRTOPEN';
          doPrtOpen();
        when verb = 'PRTLINE';
          doPrtLine();
        when verb = 'PRTCLOSE';
          if gPrtOpen;
            close QSYSPRT;
            gPrtOpen = *off;
          endif;
          outResult();
        other;
          gErr.msgid = 'IDB0001';
          outResult();
      endsl;
    on-error;
      gErr.msgid = sdsExcp;
      gErr.avail = 16 + 80;
      gErr.data = sdsExcpDta;
      outResult();
    endmon;
    sendOut();
  enddo;
end-proc;

// Session de service complete : ecran du programme sauve puis restaure
dcl-proc idbgSession export;
  dcl-pi *n char(10);
  end-pi;
  dcl-s act char(10);
  // ecran du programme sauve a la 1re ecriture (SCREEN, CMDLINE, QCMDEXC) : une reprise
  // sans affichage (trace, SKIP, pas supplementaire) evite deux echanges avec le terminal
  act = idbgServe();
  restoreScreen(*on);
  return act;
end-proc;

// ============================================================ verbes ==
dcl-proc doHello;
  dcl-s buf char(1000);
  dcl-s n int(10);
  gPyJob = %subst(gIn: 9: 26);
  gHello = *on;
  outResult();
  outChar(sdsJob: 26);
  probeWide();
  if gWide;
    n = fmtSizesW(%addr(buf));
  else;
    n = fmtSizes(%addr(buf));
  endif;
  outInt(n);
  outChar(buf: n * 18);
  // taille d'ecran retenue (lignes, colonnes)
  if gWide;
    outInt(27);
    outInt(132);
  else;
    outInt(24);
    outInt(80);
  endif;
end-proc;

// 27x132 si le terminal l'accepte : l'ouverture d'un fichier ecran DSPSIZ(*DS4)
// echoue sur un terminal 24x80 seulement. Determine une fois par session.
dcl-proc probeWide;
  if gSizeDone;
    return;
  endif;
  gSizeDone = *on;
  gWide = *off;
  if gFileOpen;
    return;
  endif;
  monitor;
    open IDBGFMW;
    gWide = *on;
    close IDBGFMW;
  on-error;
    gWide = *off;
  endmon;
end-proc;

dcl-proc doRtvModv;
  dcl-s retlib char(10);
  dcl-s rcvlen int(10);
  QteRetrieveModuleViews(gWork: %size(gWork): 'VEWL0100': %subst(gIn: 9: 20):
                         %subst(gIn: 29: 10): %subst(gIn: 39: 10): retlib: gErr);
  outResult();
  outChar(retlib: 10);
  if gErr.msgid = *blanks;
    rcvlen = ci4(%subst(gWork: 1: 4));
    outInt(rcvlen);
    outChar(gWork: rcvlen);
  else;
    outInt(0);
  endif;
end-proc;

dcl-proc doRegView;
  dcl-s viewid int(10);
  dcl-s nlines int(10);
  dcl-s retlib char(10);
  dcl-s ts char(13);
  QteRegisterDebugView(viewid: nlines: retlib: ts: %subst(gIn: 9: 20):
                       %subst(gIn: 29: 10): %subst(gIn: 39: 10): inInt(49): gErr);
  outResult();
  outInt(viewid);
  outInt(nlines);
  outChar(retlib: 10);
  outChar(ts: 13);
end-proc;

dcl-proc doViewText;
  dcl-s n int(10);
  dcl-s ll int(10);
  dcl-s rlen int(10);
  n = inInt(17);
  ll = inInt(21);
  rlen = 16 + n * ll;
  if rlen > %size(gWork);
    rlen = %size(gWork);
  endif;
  QteRetrieveViewText(gWork: rlen: inInt(9): inInt(13): n: ll: gErr);
  outResult();
  if gErr.msgid = *blanks or ci4(%subst(gWork: 1: 4)) > 0;
    n = ci4(%subst(gWork: 1: 4));
    if n > rlen;
      n = rlen;
    endif;
    outInt(n);
    outChar(gWork: n);
  else;
    outInt(0);
  endif;
end-proc;

dcl-proc doMapPos;
  dcl-s n int(10);
  QteMapViewPosition(gWork: 4096: inInt(9): inInt(13): inInt(17): inInt(21): gErr);
  outResult();
  if gErr.msgid = *blanks;
    n = ci4(%subst(gWork: 1: 4));
    outInt(n);
    outChar(gWork: n);
  else;
    outInt(0);
  endif;
end-proc;

dcl-proc doSubmit;
  dcl-s n int(10);
  dcl-s clen int(10);
  clen = inInt(33);
  QteSubmitDebugCommand(gWork: %size(gWork): inInt(9): %subst(gIn: 37: clen):
                        clen: %subst(gIn: 13: 20): gErr);
  outResult();
  if gErr.msgid = *blanks;
    n = ci4(%subst(gWork: 1: 4));
    outInt(n);
    outChar(gWork: n);
  else;
    outInt(0);
  endif;
end-proc;

dcl-proc doScreen;
  dcl-s fmt char(10);
  dcl-s mode char(1);
  dcl-s olen int(10);
  dcl-s ilen int(10);
  fmt = %subst(gIn: 9: 10);
  mode = %subst(gIn: 19: 1);
  olen = inInt(20);
  if gWide;
    if not gFileOpen;
      open IDBGFMW;
      gFileOpen = *on;
    endif;
    if not fmtIOW(fmt: mode: %addr(gIn) + 23: olen: %addr(gWork): ilen);
      gErr.msgid = 'IDB0002';
      outResult();
      return;
    endif;
    outResult();
    outChar(fmAidW: 1);
    outInt(fmRowW);
    outInt(fmColW);
  else;
    if not gFileOpen;
      open IDBGFM;
      gFileOpen = *on;
    endif;
    if not fmtIO(fmt: mode: %addr(gIn) + 23: olen: %addr(gWork): ilen);
      gErr.msgid = 'IDB0002';
      outResult();
      return;
    endif;
    outResult();
    outChar(fmAid: 1);
    outInt(fmRow);
    outInt(fmCol);
  endif;
  outInt(ilen);
  outChar(gWork: ilen);
end-proc;

dcl-proc closeFiles;
  if gFileOpen;
    if gWide;
      close IDBGFMW;
    else;
      close IDBGFM;
    endif;
    gFileOpen = *off;
  endif;
  if gPrtOpen;
    close QSYSPRT;
    gPrtOpen = *off;
  endif;
end-proc;

// Sauvegarde directe : QsnSavScr renvoie un tampon de commandes qui contient
// la restauration (a rejouer par QsnPutBuf), cf. manuel DSM.
dcl-proc saveScreen;
  dcl-s h int(10);
  if gScr = 0;
    newErr();
    h = QsnSavScr(*omit: *omit: *omit: gErr);
    if gErr.msgid = *blanks and h > 0;
      gScr = h;
    endif;
    newErr();
  endif;
end-proc;

dcl-proc restoreScreen;
  dcl-pi *n;
    release ind const;
  end-pi;
  dcl-ds e likeds(errc_t);
  if gScr <> 0;
    clear e;
    e.prov = %size(e);
    QsnPutBuf(gScr: *omit: e);
    if release;
      QsnDltBuf(gScr: e);
      gScr = 0;
    endif;
  endif;
end-proc;

dcl-proc doUserScr;
  dcl-s aid char(1);
  dcl-ds e likeds(errc_t);
  restoreScreen(*off);
  clear e;
  e.prov = %size(e);
  QsnGetAID(aid: *omit: e);
  outResult();
  outChar(aid: 1);
end-proc;

dcl-proc runCmd;
  dcl-pi *n;
    cmd varchar(3000) const;
  end-pi;
  monitor;
    QCMDEXC(cmd: %len(cmd));
  on-error;
    gErr.msgid = sdsExcp;
    gErr.avail = 16 + 80;
    gErr.data = sdsExcpDta;
  endmon;
end-proc;

// Texte de premier niveau d'un message, variables substituees
dcl-proc doRtvMsg;
  dcl-s rcv char(4096);
  dcl-s dlen int(10);
  dcl-s tlen int(10);
  dlen = inInt(36);
  if dlen > 0;
    QMHRTVM(rcv: %size(rcv): 'RTVM0100': %subst(gIn: 9: 7): %subst(gIn: 16: 20):
            %subst(gIn: 40: dlen): dlen: '*YES': '*NO': gErr);
  else;
    QMHRTVM(rcv: %size(rcv): 'RTVM0100': %subst(gIn: 9: 7): %subst(gIn: 16: 20):
            ' ': 0: '*NO': '*NO': gErr);
  endif;
  outResult();
  if gErr.msgid = *blanks;
    tlen = ci4(%subst(rcv: 9: 4));
    if tlen > 1000;
      tlen = 1000;
    endif;
    outInt(tlen);
    outChar(%subst(rcv: 25: tlen): tlen);
  else;
    outInt(0);
  endif;
end-proc;

dcl-proc doCmd;
  dcl-s len int(10);
  len = inInt(9);
  monitor;
    QCMDEXC(%subst(gIn: 13: len): len);
  on-error;
    gErr.msgid = sdsExcp;
    gErr.avail = 16 + 80;
    gErr.data = sdsExcpDta;
  endmon;
  outResult();
end-proc;

dcl-proc doPrtOpen;
  if not gPrtOpen;
    open QSYSPRT;
    gPrtOpen = *on;
  endif;
  outResult();
end-proc;

dcl-proc doPrtLine;
  dcl-s n int(10);
  dcl-s k int(10);
  if not gPrtOpen;
    open QSYSPRT;
    gPrtOpen = *on;
  endif;
  n = inInt(9);
  for k = 0 to n - 1;
    prtLine = %subst(gIn: 13 + k * 132: 132);
    write QSYSPRT prtLine;
  endfor;
  outResult();
end-proc;

// ============================================== gestionnaire d'arret ==
dcl-proc idbgStop export;
  dcl-pi *n char(10);
    qpgm char(20) const;
    ptype char(10) const;
    module char(10) const;
    reason char(10) const;
    rcv pointer value;
    nent int(10) value;
    msg pointer value;
  end-pi;
  dcl-s n int(10);
  dcl-s mlen int(10);
  dcl-s act char(10);
  outStart('STOP');
  outChar(qpgm: 20);
  outChar(ptype: 10);
  outChar(module: 10);
  outChar(reason: 10);
  if %subst(reason: 5: 1) = '1' or %subst(reason: 6: 1) = '1';
    n = 512;
  elseif %subst(reason: 7: 1) = '1';
    n = 0;
  else;
    n = nent * 4 + 8;
  endif;
  outInt(nent);
  outInt(n);
  if n > 0 and rcv <> *null;
    outMem(rcv: n);
  endif;
  mlen = 0;
  if %subst(reason: 1: 1) = '1' and msg <> *null;
    memcpy(%addr(mlen): msg: 4);
    mlen += 32;
    if mlen > 544;
      mlen = 544;
    endif;
  endif;
  outInt(mlen);
  if mlen > 0;
    outMem(msg: mlen);
  endif;
  sendOut();
  act = idbgSession();
  return act;
end-proc;

// Commande transmise par Python avec la derniere action (CALL du programme)
dcl-proc idbgLastCmd export;
  dcl-pi *n char(3000);
  end-pi;
  return gRetCmd;
end-proc;

// Fin forcee (processus Python disparu) : sortie du mode debogage
dcl-proc idbgKill export;
  newErr();
  runCmd('ENDDBG');
  restoreScreen(*on);
  if gFileOpen;
    if gWide;
      close IDBGFMW;
    else;
      close IDBGFM;
    endif;
    gFileOpen = *off;
  endif;
end-proc;
```
