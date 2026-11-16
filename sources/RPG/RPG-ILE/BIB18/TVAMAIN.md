---
bibliotheque: BIB18
fichier_source: QRPGLESRC
membre: TVAMAIN
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 55
modifie: 2026-11-16
---

# BIB18/QRPGLESRC/TVAMAIN

```rpg
**free
ctl-opt option(*srcstmt : *nodebugio);

/copy QRPGLESRC,TVAPROTO

dcl-s nbCalculs int(10) import;
dcl-s rep       char(1);

exec sql set option commit = *none;

nbCalculs = 0;
totaliser('BIB18.ARTICLE'  : 'Articles');
totaliser('BIB18.ARTPROMO' : 'Articles promo');

dsply 'Pile : Maj+Echap, option 3 puis 11' '' rep;

*inlr = *on;


//================================================================
// Totalise HT et TTC d'une table d'articles
//================================================================
dcl-proc totaliser;
    dcl-pi *n;
        table   varchar(30) const;
        libelle varchar(30) const;
    end-pi;

    dcl-ds art qualified;
        pxHt  packed(11 : 2);
        cdTva char(1);
    end-ds;
    dcl-s sqlTxt   varchar(200);
    dcl-s totalHt  packed(11 : 2);
    dcl-s totalTtc packed(11 : 2);

    sqlTxt = 'select ARPXHT, ARCTVA from ' + table;
    exec sql declare cArt cursor for sArt;
    exec sql prepare sArt from :sqlTxt;

    exec sql open cArt;

    exec sql fetch next from cArt into :art;
    dow sqlcode = 0;
        totalHt  += art.pxHt;
        totalTtc += calcTtc(art.pxHt : art.cdTva);
        exec sql fetch next from cArt into :art;
    enddo;

    exec sql close cArt;

    snd-msg libelle + ' : HT ' + %char(totalHt)
          + ' / TTC ' + %char(totalTtc)
          + ' / calculs ' + %char(nbCalculs);
end-proc;
```
