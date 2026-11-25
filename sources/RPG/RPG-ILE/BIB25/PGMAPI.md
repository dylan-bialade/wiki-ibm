---
bibliotheque: BIB25
fichier_source: QMODSRC
membre: PGMAPI
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 39
modifie: 2026-11-25
---

# BIB25/QMODSRC/PGMAPI

```rpg
**free

CTL-OPT copyright('(C) ORGFORM 2025.') DATFMT(*ISO);

dcl-pr DescriptionFile;
    file char(10);
    bib char(10);
    msg char(40);
end-pr;

dcl-pr DisplayPFM;
    file char(10);
    bib char(10);
    msg char(40);
end-pr;

dcl-pi *n;
    file char(10);
    bib char(10);
end-pi;

dcl-s msg char(40) INZ('');

DescriptionFile(file:bib:msg);

// sortie dans QTEMP
// Fichier DSPFD
// Traitement du fichier

if msg <> *blanks;
    dsply msg;
else;
    dsply 'Fichier dispo dans QTEMP';
endif;

msg = *blanks;
DisplayPFM(file:bib:msg);

*INLR = *ON;
```
