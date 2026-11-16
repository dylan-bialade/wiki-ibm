---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: POKEPHL
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 80
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/POKEPHL

```rpg
**free

exec sql set option commit = *none, closqlcsr = *endactgrp;

dcl-f pokemonfm workstn sfile(SF1:rrn);

dcl-s rrn packed(4:0);

loadSFL();

dow not *inkc;
    write F1;
    exfmt FC1;
    if *inkc;
        leave;
    endif;

    if SELID <> 0;
        loadDetail();
    endif;
enddo;

*inlr = *on;

dcl-proc openPokeCursor export;
    dcl-pi *n ind;
    end-pi;

    exec sql declare cPoke cursor for
            select ID, POKEDEX_NUMBER, NAME from POKEMON.POKEMON1G order by POKEDEX_NUMBER;
    exec sql close cPoke;
    exec sql open cPoke;
    return sqlcode = 0;
end-proc;

dcl-proc closePokeCursor;
    exec sql close cPoke;
end-proc;

dcl-proc fetchNextPoke;
    dcl-pi *n ind;
    end-pi;

    exec sql fetch next from cPoke into :ID, :POKED00001, :NAME;

    return sqlcode = 0;
end-proc;

dcl-proc loadSFL;
    *in01 = *on;
    write FC1;
    *in01 = *off;
    rrn = 0;

    openPokeCursor();
    dow fetchNextPoke();
        rrn += 1;
        write SF1;
    enddo;
    closePokeCursor();
end-proc;


dcl-proc loadDetail;
    exec sql
        select POKEDEX_NUMBER, NAME,
               coalesce(HP, 0), coalesce(ATTACK, 0), coalesce(DEFENSE, 0),
               coalesce(SPECIAL_ATTACK, 0), coalesce(SPECIAL_DEFENSE, 0),
               coalesce(SPEED, 0), TYPE1, coalesce(TYPE2, '')
          into :POKED00001, :NAME,
               :HP, :ATTACK, :DEFENSE,
               :SPECI00001, :SPECI00002,
               :SPEED, :TYPE1, :TYPE2
          from POKEMON.POKEMON1G
         where ID = :SELID;

    if sqlcode = 0;
        IMGNUM = %char(POKED00001);
    endif;
end-proc;
```
