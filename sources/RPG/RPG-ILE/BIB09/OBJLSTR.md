---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: OBJLSTR
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 352
modifie: 2026-11-16
---

# BIB09/QSOURCES/OBJLSTR

```rpg
**free
// ================================================================
// Programme : OBJLSTR
// Objectif  : Lister les objets d'une bibliotheque saisie a
//             l'ecran, dans un sous-fichier avec options de
//             gestion (suppr, copie, droits, rename, desc...)
// ================================================================
ctl-opt option(*srcstmt) dftactgrp(*no) bnddir('OBJLSTBD':'QC2LE');

// ----- Fichier ecran avec sous-fichier -----
dcl-f OBJLSTD workstn sfile(SFLOBJ:wRrn) infds(dsInfo);

// ----- Fichier DSPOBJD dans QTEMP (ouverture manuelle) -----
dcl-f OBJLSTP disk usage(*input) rename(QLIDOBJD:OBJFMT)
               usropn;

// ----- Prototype du programme CL d'extraction -----
dcl-pr OBJLSTC extpgm('OBJLSTC');
  pBiblio char(10);
  pExiste char(1);
end-pr;

// ----- Prototype de QCMDEXC -----
dcl-pr QCMDEXC extpgm;
  *n char(1000) const options(*varsize);
  *n packed(15:5) const;
end-pr;

// ----- Prototype system() C pour commandes interactives -----
dcl-pr system int(10) extproc('system');
  *n pointer value options(*string);
end-pr;

// ----- Prototype du module couleur -----
dcl-ds dsCouleur qualified template;
  indRouge ind;
  indRose  ind;
end-ds;

dcl-pr getCouleurObjet likeds(dsCouleur);
  pAttribut char(10) const;
end-pr;

// ----- Constantes -----
dcl-c SFL_PAGE 14;

// ----- Variables de travail -----
dcl-s wRrn        packed(4:0) inz(0);
dcl-s wLstRrn     packed(4:0) inz(0);
dcl-s wPageStart  packed(4:0) inz(1);
dcl-s wNbObjets   packed(7:0) inz(0);
dcl-s wBiblio     char(10)    inz(*blanks);
dcl-s wExiste     char(1)     inz('0');
dcl-s wCommande   char(1000)  inz(*blanks);
dcl-s wObjEnCours packed(7:0) inz(0);
dcl-s i           packed(4:0) inz(0);

// ----- DS pour retour couleur -----
dcl-ds wCouleur likeds(dsCouleur);

// ----- Renommage des indicateurs -----
dcl-s pInd pointer inz(%addr(*in));
dcl-ds dsInd based(pInd);
  indSortie     ind pos(3);    // F3
  indRetour     ind pos(12);   // F12
  indCmdLine    ind pos(21);   // F21
  indSflClr     ind pos(31);   // SFLCLR
  indSflDsp     ind pos(32);   // SFLDSP
  indRoll       ind pos(39);   // ROLLUP
  indErrBib     ind pos(61);   // Erreur bibliotheque
  indSflNxtChg  ind pos(67);   // SFLNXTCHG
  indColorRouge ind pos(70);   // Couleur rouge (PF)
  indColorRose  ind pos(71);   // Couleur rose (LF)
  indSflEnd     ind pos(90);   // SFLEND
end-ds;

// ----- INFDS pour touche fonction -----
dcl-ds dsInfo;
  wCfKey char(1) pos(369);
end-ds;

// ================================================================
// Programme principal
// ================================================================

dou indSortie;

  indErrBib = *off;
  exfmt FMT1;

  if indSortie;
    leave;
  endif;

  if %trim(WBIB) = *blanks;
    iter;
  endif;

  wBiblio = %upper(WBIB);
  WBIB = wBiblio;
  OBJLSTC(wBiblio : wExiste);

  if wExiste = '0';
    indErrBib = *on;
    iter;
  endif;

  wCommande = 'OVRDBF FILE(OBJLSTP) TOFILE(QTEMP/OBJLSTP)';
  callp QCMDEXC(wCommande : %len(%trim(wCommande)));

  if not %open(OBJLSTP);
    open OBJLSTP;
  endif;

  compterObjets();
  afficherSousfichier();

  if %open(OBJLSTP);
    close OBJLSTP;
  endif;
  wCommande = 'DLTOVR FILE(OBJLSTP)';
  monitor;
    callp QCMDEXC(wCommande : %len(%trim(wCommande)));
  on-error *all;
  endmon;

enddo;

*inlr = *on;
return;

// ================================================================
// Procedure : repositionnerFichier
// ================================================================
dcl-proc repositionnerFichier;
  if %open(OBJLSTP);
    close OBJLSTP;
  endif;
  open OBJLSTP;
end-proc;

// ================================================================
// Procedure : compterObjets
// ================================================================
dcl-proc compterObjets;
  wNbObjets = *zero;
  repositionnerFichier();
  read OBJFMT;
  dow not %eof(OBJLSTP);
    wNbObjets += 1;
    read OBJFMT;
  enddo;
end-proc;

// ================================================================
// Procedure : afficherSousfichier
// ================================================================
dcl-proc afficherSousfichier;

  clearSfl();
  repositionnerFichier();
  wObjEnCours = 0;
  wPageStart = 1;
  chargerPage();

  HBIB = wBiblio;

  dou indSortie or indRetour;

    // Positionner l'affichage sur la page courante
    SRRN = wPageStart;
    write FMTBAS;
    exfmt CTLOBJ;

    select;
      when indSortie;
        leave;

      when indRetour;
        leave;

      when indCmdLine;
        wCommande = 'CALL PGM(QCMD)';
        monitor;
          callp QCMDEXC(wCommande : %len(%trim(wCommande)));
        on-error *all;
        endmon;

      when indRoll;
        // Charger la page suivante seulement si pas deja a la fin
        if not indSflEnd;
          wPageStart = wLstRrn + 1;
          chargerPage();
        endif;

      other;
        traiterOptions();
        clearSfl();
        repositionnerFichier();
        wObjEnCours = 0;
        wPageStart = 1;
        chargerPage();
    endsl;

  enddo;

end-proc;

// ================================================================
// Procedure : clearSfl
// ================================================================
dcl-proc clearSfl;
  wRrn = *zero;
  wLstRrn = *zero;
  indSflClr = *on;
  write CTLOBJ;
  indSflClr = *off;
  indSflDsp = *off;
  indSflEnd = *off;
end-proc;

// ================================================================
// Procedure : chargerPage
// ================================================================
dcl-proc chargerPage;

  wRrn = wLstRrn;

  for i = 1 to SFL_PAGE;
    read OBJFMT;
    if %eof(OBJLSTP);
      indSflEnd = *on;
      leave;
    endif;

    wRrn += 1;
    wObjEnCours += 1;

    SOPT   = *blanks;
    SOBJNM = ODOBNM;
    SOBJTP = ODOBTP;
    SOBJBI = ODLBNM;
    SOBJAT = ODOBAT;
    SOBJTX = ODOBTX;

    wCouleur = getCouleurObjet(ODOBAT);
    indColorRouge = wCouleur.indRouge;
    indColorRose  = wCouleur.indRose;

    write SFLOBJ;
  endfor;

  HNBOBJ = %char(wObjEnCours) + '/' + %char(wNbObjets);

  if wRrn > *zero;
    indSflDsp = *on;
  endif;

  wLstRrn = wRrn;

end-proc;

// ================================================================
// Procedure : traiterOptions
// ================================================================
dcl-proc traiterOptions;

  readc SFLOBJ;
  dow not %eof();

    select;

      when SOPT = '2';
        wCommande = 'EDTOBJAUT OBJ(' +
                     %trim(SOBJBI) + '/' +
                     %trim(SOBJNM) + ') ' +
                     'OBJTYPE(' + %trim(SOBJTP) + ')';
        monitor;
          callp QCMDEXC(wCommande : %len(%trim(wCommande)));
        on-error *all;
        endmon;

      when SOPT = '3';
        wCommande = '?CRTDUPOBJ OBJ(' +
                     %trim(SOBJNM) + ') ' +
                     'FROMLIB(' + %trim(SOBJBI) + ') ' +
                     'OBJTYPE(' + %trim(SOBJTP) + ')';
        monitor;
          system(%trim(wCommande));
        on-error *all;
        endmon;

      when SOPT = '4';
        wCommande = 'DLTOBJ OBJ(' +
                     %trim(SOBJBI) + '/' +
                     %trim(SOBJNM) + ') ' +
                     'OBJTYPE(' + %trim(SOBJTP) + ')';
        monitor;
          callp QCMDEXC(wCommande : %len(%trim(wCommande)));
        on-error *all;
        endmon;

      when SOPT = '5';
        wCommande = 'DSPOBJAUT OBJ(' +
                     %trim(SOBJBI) + '/' +
                     %trim(SOBJNM) + ') ' +
                     'OBJTYPE(' + %trim(SOBJTP) + ')';
        monitor;
          callp QCMDEXC(wCommande : %len(%trim(wCommande)));
        on-error *all;
        endmon;

      when SOPT = '7';
        wCommande = '?RNMOBJ OBJ(' +
                     %trim(SOBJBI) + '/' +
                     %trim(SOBJNM) + ') ' +
                     'OBJTYPE(' + %trim(SOBJTP) + ')';
        monitor;
          system(%trim(wCommande));
        on-error *all;
        endmon;

      when SOPT = '8';
        wCommande = 'DSPOBJD OBJ(' +
                     %trim(SOBJBI) + '/' +
                     %trim(SOBJNM) + ') ' +
                     'OBJTYPE(' + %trim(SOBJTP) + ') ' +
                     'DETAIL(*FULL)';
        monitor;
          callp QCMDEXC(wCommande : %len(%trim(wCommande)));
        on-error *all;
        endmon;

      when SOPT = '13';
        wCommande = '?CHGOBJD OBJ(' +
                     %trim(SOBJBI) + '/' +
                     %trim(SOBJNM) + ') ' +
                     'OBJTYPE(' + %trim(SOBJTP) + ')';
        monitor;
          system(%trim(wCommande));
        on-error *all;
        endmon;

    endsl;

    SOPT = *blanks;
    update SFLOBJ;

    readc SFLOBJ;
  enddo;

end-proc;
```
