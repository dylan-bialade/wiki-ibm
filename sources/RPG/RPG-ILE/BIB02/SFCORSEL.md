---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: SFCORSEL
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 52
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/SFCORSEL

```rpg
**free
ctl-opt dftactgrp(*no) optimize(*none) actgrp(*caller) datfmt(*iso) timfmt(*iso) alloc(*stgmdl)
option(*srcstmt);

// Inclusion des définitions externes du fichier d'affichage et du fichier de données
dcl-f ECSFCORSEL workstn SFILE(SFL1:rang);
dcl-f ETUDIANTPF keyed usage(*input) prefix(pf_);

// Déclarations des variables
dcl-s eof ind inz(*off);
dcl-s rrn int(5) inz(0);

// Programme principal
exsr LoadSubfile;


// Boucle principale du programme
dou *in03 or eof;
  exfmt SF1CTL;
  if *in05;
    exsr LoadSubfile;
  endif;
enddo;



*inlr = *on;

// Sous-routine pour charger le sous-fichier
begsr LoadSubfile;
  setll *loval ETUDIANTPF;
  rang = 0;
  eof = *off;

  dou eof;
    read ETUDIANTPF;
    if %eof;
      eof = *on;
      leave;
    endif;
    rang += 1;
    clear SFL1;
    ID_ETU = pf_ID_ETUD;
    NOM = pf_NOM;
    PRENOM = pf_PRENOM;
    write SFL1;
  enddo;
  if rang > 0;
    write SF1CTL;
    exfmt SF1CTL;
  endif;
endsr;
```
