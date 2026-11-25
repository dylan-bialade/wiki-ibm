# POKEAPI : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QTESTSRC | RPG/RPG-ILE | 34 | 100 % | SQL embarque | [POKEAPI.md](../../sources/RPG/RPG-ILE/BIB02/POKEAPI.md) |
| BIB27 | QRPGLESRC | RPG/RPG-ILE | 36 | 18 % | full free, SQL embarque | [POKEAPI.md](../../sources/RPG/RPG-ILE/BIB27/POKEAPI.md) |

## Differences

- Techniques communes : SQL embarque
- **BIB27** en propre : full free

## Codes

### BIB02 (RPG/RPG-ILE, 34 lignes)

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

### BIB27 (RPG/RPG-ILE, 36 lignes)

```text
**free
CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO) ACTGRP(*CALLER) OPTIMIZE(*NONE);



DCL-S url varchar(255) inz('https://pokeapi.co/api/v2/pokemon/pikachu');
DCL-S nom varchar(50);      // Nom du pokemon
DCL-S attaque varchar(50);  // La puissance d'attaque du Pokémon


// Initialisation du commit en sql
Exec SQL
SET option commit = *none, ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD;

// Méthode Get  HTTPGETCLOB
exec sql
select  * into :nom , :attaque from  json_table( systools.HTTPGETCLOB (
             cast( :url as varchar(255)),
             cast(null as clob(1k)
                    )),
            '$'
                 COLUMNS(
                  nom VARCHAR(20) PATH '$.forms.name' ,
                  attaque   VARCHAR(20) PATH '$.stats[1].base_stat'
                )
               );



//**Coder ici **


DSPLY  nom ;
DSPLY  attaque;

*inlr = *on;
```
