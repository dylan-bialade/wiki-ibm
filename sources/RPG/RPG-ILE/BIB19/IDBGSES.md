---
bibliotheque: BIB19
fichier_source: QRPGLESRC
membre: IDBGSES
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 43
modifie: 2026-11-16
---

# BIB19/QRPGLESRC/IDBGSES

```rpg
**free
// ---------------------------------------------------------------------------
// IDBGSES - gestionnaire de session de debogage (STRDBG SRCDBGPGM)
// *START   : enregistre le programme d'arret IDBGSTP (QteStartSourceDebug)
// *STOP    : sortie du debogueur source (QteEndSourceDebug)
// *DISPLAY : rien, l'affichage est celui de BIB19
// Licence MIT
// ---------------------------------------------------------------------------
ctl-opt main(main) option(*srcstmt: *nodebugio);

dcl-ds errc qualified;
  prov int(10) inz(%size(errc));
  avail int(10) inz(0);
  msgid char(7);
  rsv char(1);
  data char(256);
end-ds;

dcl-ds pgmSds psds;
  sdsLib char(10) pos(81);
end-ds;

dcl-pr QteStartSourceDebug extproc('QteStartSourceDebug');
  stphdlr char(20) const;
  err likeds(errc);
end-pr;
dcl-pr QteEndSourceDebug extproc('QteEndSourceDebug');
  err likeds(errc);
end-pr;

dcl-proc main;
  dcl-pi *n;
    reason char(10);
    pgmlist char(30);
    count int(10);
  end-pi;
  select;
    when reason = '*START';
      QteStartSourceDebug('IDBGSTP   ' + sdsLib: errc);
    when reason = '*STOP';
      QteEndSourceDebug(errc);
  endsl;
end-proc;
```
