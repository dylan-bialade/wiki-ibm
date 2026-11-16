---
bibliotheque: BIB18
fichier_source: QRPGLESRC
membre: TP2MOD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 66
modifie: 2026-11-16
---

# BIB18/QRPGLESRC/TP2MOD

```rpg
**free
ctl-opt nomain option(*srcstmt);

/include QRPGLESRC,TP2MODP

exec sql set option commit = *none;

dcl-c STOCK_SECU const(0);

dcl-s nbLectures int(10) inz(0) export;

dcl-ds articleDs qualified;
    arstk packed(7:0);
    arpxht packed(9:2);
end-ds;

dcl-proc lireArticle;
    dcl-pi *n ind;
        code char(6) const;
    end-pi;

    clear articleDs;
    nbLectures += 1;

    exec sql select ARSTK, ARPXHT into :articleDs from BIB18.ARTICLE where ARCODE = :code;

    return sqlcode = 0;
end-proc;

dcl-proc stockArticle export;
    dcl-pi *n packed(7:0);
        code char(6) const;
    end-pi;

    if not lireArticle(code);
        return -1;
    endif;

    return articleDs.arstk;

end-proc;

dcl-proc valeurStock export;
    dcl-pi *n packed(11:2);
        code char(6) const;
    end-pi;

    if not lireArticle(code);
        return 0;
    endif;
    return articleDs.arstk * articleDs.arpxht;

end-proc;

dcl-proc estDisponible export;
    dcl-pi *n ind;
        code char(6) const;
        qte packed(7:0) const;
    end-pi;

    if not lireArticle(code);
        return *off;
    endif;
    return articleDs.arstk - STOCK_SECU >= qte;

end-proc;
```
