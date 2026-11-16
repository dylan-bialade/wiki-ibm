---
bibliotheque: BIB02
fichier_source: QTESTSRC
membre: POKEAPI
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 34
modifie: 2026-11-16
---

# BIB02/QTESTSRC/POKEAPI

```text
       CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*FULL)
       ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
       STGMDL(*INHERIT) THREAD(*SERIALIZE);


       DCL-S url varchar(99) inz('https://pokeapi.co/api/v2/pokemon/+
       charizard');
       DCL-S nompkmn varchar(50);
       DCL-S atkspe varchar(50);
       DCL-S REPONSE char(1);

       // initialisation du commit en sql
       Exec SQL
       SET option commit = *none, ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD;

       // Méthode Get
       EXEC SQL
        select name, basestat into :nompkmn, :atkspe
           from json_table( systools.HTTPGETCLOB (
            cast(:url as varchar(255)),
            cast(null as clob(1k)
                   )),
           '$'
                COLUMNS(
                 name VARCHAR(99) PATH '$.forms.name',
                 basestat VARCHAR(99) PATH '$.stats[3].base_stat'
               )) ;




       DSPLY nompkmn  '' reponse;
       DSPLY atkspe '' reponse;
       *inlr = *on;
```
