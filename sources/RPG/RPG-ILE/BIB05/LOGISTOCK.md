---
bibliotheque: BIB05
fichier_source: QFREERPGLE
membre: LOGISTOCK
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 305
modifie: 2026-11-16
---

# BIB05/QFREERPGLE/LOGISTOCK

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
**free
// SI TU VOIS SA TU A COPIER BIB05
//---------------------------------------------------------------
// LOGISTOCKR : GESTION DES ARTICLES LOGISTOCK
//   F6 creer / 2 modifier (F23) / 4 supprimer (F23) / 5 afficher
//   filtre sur le code produit, ordre de la base (cle CHAR)
//---------------------------------------------------------------
ctl-opt dftactgrp(*no) actgrp(*new);

// Ecran : sous-fichier SFL1, numero de ligne dans RRN
dcl-f LOGISTOCKD workstn sfile(SFL1 : RRN);

// LF LOGISTOCKL : cle CODPRO, lecture/maj/ajout/suppr
dcl-f LOGISTOCKL usage(*update : *delete : *output) keyed;

// Variables globales (visibles dans toutes les procedures)
dcl-s RRN zoned(4:0);
dcl-s EOFFLG ind;
dcl-s QUITTER ind;
dcl-s RECHRG ind;
dcl-s PREVPOS like(POSCOD);
dcl-s DERNCODE like(CODPRO);
dcl-s CLE like(CODPRO);

// Prototypes des procedures (obligatoires : appelees avant leur definition)
dcl-pr DEBSFL end-pr;
dcl-pr CHGPAGE end-pr;
dcl-pr CHGPLUS end-pr;
dcl-pr TRTOPT end-pr;
dcl-pr AFFICH end-pr;
dcl-pr MODIF end-pr;
dcl-pr SUPPR end-pr;
dcl-pr CREER end-pr;

//---------------------------------------------------------------
// PROGRAMME PRINCIPAL
//---------------------------------------------------------------
POSCOD = *blanks;
PREVPOS = *blanks;

// Premier chargement du sous-fichier
DEBSFL();

dow not QUITTER;
  // 31=SFLDSP 32=SFLDSPCTL 34=SFLEND(*MORE) : etat du sous-fichier
  *in31 = (RRN > 0);
  *in32 = *on;
  *in34 = EOFFLG;

  // On ecrit le pied de page (efface l ecran) puis CTL1 en OVERLAY
  write FOOTER;
  exfmt CTL1;
  MSG = *blanks;

  select;
    // F3 : quitter
    when *in03;
      QUITTER = *on;
    // F6 : creer un article
    when *in06;
      CREER();
    // Page suivante : charge 11 lignes de plus
    when *in25;
      CHGPLUS();
    // ENTREE : options 2, 4, 5 saisies dans le sous-fichier
    other;
      if RRN > 0;
        TRTOPT();
      endif;
  endsl;

  // Recharge si filtre change ou donnees modifiees
  if not QUITTER;
    if RECHRG or POSCOD <> PREVPOS;
      PREVPOS = POSCOD;
      RECHRG = *off;
      DEBSFL();
    endif;
  endif;
enddo;

*inlr = *on;
return;

//---------------------------------------------------------------
// DEBSFL : vide le sous-fichier et charge la 1re page
//   a partir du code saisi (ordre de la base, cle en caracteres)
//---------------------------------------------------------------
dcl-proc DEBSFL;
  // Vider le sous-fichier (SFLCLR)
  *in31 = *off;
  *in32 = *off;
  *in33 = *on;
  write CTL1;
  *in33 = *off;
  RRN = 0;
  EOFFLG = *off;
  SFLPOS = 1;

  // Positionnement : debut du fichier ou a partir de POSCOD
  if POSCOD = *blanks;
    setll *loval LOGISTOCKL;
  else;
    setll POSCOD LOGISTOCKL;
  endif;

  CHGPAGE();
  if RRN = 0;
    MSG = 'Aucun article trouve';
  endif;
end-proc;

//---------------------------------------------------------------
// CHGPAGE : lit 11 enregistrements dans le sous-fichier
//---------------------------------------------------------------
dcl-proc CHGPAGE;
  dcl-s PREMIER like(RRN);
  dcl-s I int(5);

  PREMIER = RRN + 1;
  for I = 1 to 11;
    if RRN >= 9999;
      leave;
    endif;
    read LOGISTOCKL;
    // Fin de fichier : SFLEND(*MORE) passe a Fin
    if %eof(LOGISTOCKL);
      EOFFLG = *on;
      leave;
    endif;
    OPT = *blanks;
    DERNCODE = CODPRO;
    RRN = RRN + 1;
    write SFL1;
  endfor;
  // La nouvelle page s affiche en haut
  if RRN >= PREMIER;
    SFLPOS = PREMIER;
  endif;
end-proc;

//---------------------------------------------------------------
// CHGPLUS : page suivante, reprend apres le dernier code lu
//---------------------------------------------------------------
dcl-proc CHGPLUS;
  if EOFFLG;
    return;
  endif;
  setgt DERNCODE LOGISTOCKL;
  CHGPAGE();
end-proc;

//---------------------------------------------------------------
// TRTOPT : traite les options saisies (2, 4, 5)
//---------------------------------------------------------------
dcl-proc TRTOPT;
  readc SFL1;
  dow not %eof(LOGISTOCKD) and not QUITTER;
    // On garde le code de la ligne choisie
    CLE = CODPRO;
    select;
      when OPT = ' ';
      when OPT = '2';
        MODIF();
      when OPT = '4';
        SUPPR();
      when OPT = '5';
        AFFICH();
      other;
        MSG = 'Option invalide (2, 4 ou 5)';
    endsl;
    // On efface l option dans le sous-fichier (sauf si rechargement)
    if not RECHRG and not QUITTER;
      OPT = *blanks;
      update SFL1;
    endif;
    readc SFL1;
  enddo;
end-proc;

//---------------------------------------------------------------
// AFFICH : option 5, fenetre pop-up (lecture sans verrou)
//---------------------------------------------------------------
dcl-proc AFFICH;
  chain(n) CLE LOGISTOCKL;
  if not %found(LOGISTOCKL);
    MSG = 'Article introuvable';
    return;
  endif;
  exfmt FMTAFF;
  if *in03;
    QUITTER = *on;
  endif;
end-proc;

//---------------------------------------------------------------
// MODIF : option 2, F23 pour confirmer (ENTREE sans effet)
//---------------------------------------------------------------
dcl-proc MODIF;
  chain CLE LOGISTOCKL;
  if not %found(LOGISTOCKL);
    MSG = 'Introuvable ou verrouille';
    return;
  endif;
  dow *on;
    exfmt FMTMOD;
    MSG = *blanks;
    select;
      // F3 : quitter le programme
      when *in03;
        unlock LOGISTOCKL;
        QUITTER = *on;
        leave;
      // F12 : annuler, on relit la valeur d origine (sans verrou)
      when *in12;
        unlock LOGISTOCKL;
        chain(n) CLE LOGISTOCKL;
        leave;
      // F23 : confirmer la modification
      when *in23;
        if NOMPRO = *blanks;
          MSG = 'Nom produit obligatoire';
        else;
          update ENTREPOTF;
          MSG = 'Article modifie';
          leave;
        endif;
      // ENTREE : rien, on rappelle F23
      other;
        MSG = 'F23 = confirmer la modif.';
    endsl;
  enddo;
end-proc;

//---------------------------------------------------------------
// SUPPR : option 4, F23 pour confirmer (ENTREE sans effet)
//---------------------------------------------------------------
dcl-proc SUPPR;
  chain CLE LOGISTOCKL;
  if not %found(LOGISTOCKL);
    MSG = 'Introuvable ou verrouille';
    return;
  endif;
  dow *on;
    exfmt FMTSUP;
    MSG = *blanks;
    select;
      when *in03;
        unlock LOGISTOCKL;
        QUITTER = *on;
        leave;
      when *in12;
        unlock LOGISTOCKL;
        leave;
      // F23 : supprime l enregistrement verrouille, puis recharge
      when *in23;
        delete LOGISTOCKL;
        MSG = 'Article supprime';
        RECHRG = *on;
        leave;
      other;
        MSG = 'F23 = confirmer la suppr.';
    endsl;
  enddo;
end-proc;

//---------------------------------------------------------------
// CREER : F6, ENTREE valide la creation
//---------------------------------------------------------------
dcl-proc CREER;
  clear ENTREPOTF;
  QTPRO = 0;
  DTDINV = %date();
  dow *on;
    exfmt FMTCRE;
    MSG = *blanks;
    if *in03;
      QUITTER = *on;
      leave;
    endif;
    if *in12;
      leave;
    endif;
    // Controles : code et nom obligatoires, code unique
    select;
      when CODPRO = *blanks;
        MSG = 'Code produit obligatoire';
      when NOMPRO = *blanks;
        MSG = 'Nom produit obligatoire';
      other;
        setll CODPRO LOGISTOCKL;
        if %equal(LOGISTOCKL);
          MSG = 'Ce code produit existe deja';
        else;
          write ENTREPOTF;
          MSG = 'Article cree';
          RECHRG = *on;
          leave;
        endif;
    endsl;
  enddo;
end-proc;
```
