---
bibliotheque: BIB11
fichier_source: QRPGLESRC
membre: XP1PK
type: RPG/RPG-ILE
longueur_enregistrement: 114
lignes: 69
modifie: 2026-11-16
---

# BIB11/QRPGLESRC/XP1PK

```rpg
**free

ctl-opt dftactgrp(*no) actgrp(*new) alwnull(*usrctl);

dcl-f pokemon1g usage(*input) keyed;

dcl-f xp1pkm workstn sfile(sf1:rrn);



dcl-s rrn packed(4:0) inz(0);



*in30 = *on;

write CT1;

*in30 = *off;



read pokemon1g;



dow (not %eof);

  rrn+=1;

  write SF1;

  read pokemon1g;

enddo;



dow (not *inKC);

  exfmt ct1;

  select;

    when (*InKC);

      leave;

    other;

      // handle other conditions

      readc sf1;

      dow (not %eof);

        chain id pokemon1g;

        exfmt detail;

        readc sf1;

      enddo;

  endsl;

enddo;

*inlr = *on;
```
