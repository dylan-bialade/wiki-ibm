---
bibliotheque: BIB02
fichier_source: QSRC
membre: APID
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 24
modifie: 2026-11-16
---

# BIB02/QSRC/APID

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*NONE)
       ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
       STGMDL(*INHERIT) THREAD(*SERIALIZE);


       DCL-S url varchar(99) inz('https://pokeapi.co/api/v2/pokemon/');
       DCL-S nompkmn varchar(50);
       DCL-S atkspe varchar(50);
       DCL-S REPONSE char(1);

       // initialisation du commit en sql
       Exec SQL
       SET option commit = *none, ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD;

       // Methode Get
       EXEC SQL
       // *** ON CODE ICI ** //




       DSPLY nompkmn  '' reponse;
       DSPLY atkspe '' reponse;
       *inlr = *on;
```
