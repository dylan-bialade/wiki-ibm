# TEST_API : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB25 | QWEBSRC | Autres/Web | 53 | 100 % | full free, SQL embarque | [TEST_API.md](../../sources/Autres/Web/BIB25/TEST_API.md) |
| BIB27 | QRPGLESRC | RPG/RPG-ILE | 53 | 90 % | full free, SQL embarque | [TEST_API.md](../../sources/RPG/RPG-ILE/BIB27/TEST_API.md) |

## Differences

- Techniques communes : full free, SQL embarque
- Langages / types differents : Autres/Web, RPG/RPG-ILE

## Codes

### BIB25 (Autres/Web, 53 lignes)

```text
**free

CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*NONE)
       ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
       STGMDL(*INHERIT) THREAD(*SERIALIZE);

//*****************************************************************
// Programme : TEST_API
// BIB27 Léo - Exemple test Utilisation API
// Date      - 22/05/2024
// IMPORTANT !!- CHANGEZ LE OPTIMIZE(*FULL) EN *NONE POUR DEBUG
// Copyright - ORGFORM
//*****************************************************************

//****************************************************************//
// Déclaration Variables                                          //
// ***************************************************************//

DCL-S NAME CHAR(25);
DCL-S ATTAQUE varchar(50);

//****************************************************************//
// Déclaration Url API                                            //
// ***************************************************************//


DCL-C UrlFull CONST('https://pokeapi.co/api/v2/pokemon/pikachu');


//****************************************************************//
// Traitement Principal                                           //
// ***************************************************************//

EXEC SQL
 SET option commit = *none , ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD;

EXEC SQL
        select  NAME , ATTAQUE into :NAME , :ATTAQUE from json_table(systools.HT
            cast(:UrlFull as varchar(255)),
            cast(null as clob(1k))),
          '$'
          COLUMNS(
           NAME   VARCHAR(99) PATH '$.forms.name',
           ATTAQUE VARCHAR(99) PATH '$.stats[1].base_stat'
         )
        );


dsply NAME;
dsply ATTAQUE;


*inlr=*on;
```

### BIB27 (RPG/RPG-ILE, 53 lignes)

```text
**free

CTL-OPT OPTION(*SRCSTMT) DFTACTGRP(*NO) OPTIMIZE(*NONE)
       ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
       STGMDL(*INHERIT) THREAD(*SERIALIZE);

//*****************************************************************
// Programme : TEST_API
// BIB27 Léo - Exemple test Utilisation API
// Date      - 22/05/2024
// IMPORTANT !!- CHANGEZ LE OPTIMIZE(*FULL) EN *NONE POUR DEBUG
// Copyright - ORGFORM
//*****************************************************************

//****************************************************************//
// Déclaration Variables                                          //
// ***************************************************************//

DCL-S NAME CHAR(25);
DCL-S ATTAQUE varchar(50);

//****************************************************************//
// Déclaration Url API                                            //
// ***************************************************************//


DCL-C UrlFull CONST('https://pokeapi.co/api/v2/pokemon/pikachu');


//****************************************************************//
// Traitement Principal                                           //
// ***************************************************************//

EXEC SQL
 SET option commit = *none , ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD;

EXEC SQL
        select  NAME , ATTAQUE into :NAME , :ATTAQUE from json_table(systools.HTTPGETCLOB(
            cast(:UrlFull as varchar(255)),
            cast(null as clob(1k))),
          '$'
          COLUMNS(
           NAME   VARCHAR(99) PATH '$.forms.name',
           ATTAQUE VARCHAR(99) PATH '$.stats[1].base_stat'
         )
        );


dsply NAME;
dsply ATTAQUE;


*inlr=*on;
```
