---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: TE
type: DDS
longueur_enregistrement: 100
lignes: 29
modifie: 2026-11-16
---

# BIB02/QDDSRC/TE

```text
**FREE
ctl-opt copyright('(C) ORGFORM 2023.') usrprf(*owner)
option(*srcstmt) dftactgrp(*no) optimize(*none)
actgrp(*caller) datfmt(*iso) timfmt(*iso) alloc(*stgmdl)
stgmdl(*inherit) thread(*serialize) DECEDIT('0.');

// *****************************************************************
// Programme : FFSFR
// BIB02 SYLVAIN - JE TEST LE %CHAR
// date      - 23/08/2023
// Copyright - ORGFORM sqd
// *****************************************************************


// **********************************************************************//
// Déclaration des variables                                            //
// **********************************************************************//
dcl-s a char(4)    inz(*blank);
dcl-s b zoned(4:0) inz(0111);

dcl-s stop char(4) inz('');

// **********************************************************************//
// Traitement pricipale                                                 //
// **********************************************************************//
*inlr = *on;

a = %editc(b:'X');
stop = 'stop';
```
