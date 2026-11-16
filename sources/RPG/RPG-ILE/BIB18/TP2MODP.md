---
bibliotheque: BIB18
fichier_source: QRPGLESRC
membre: TP2MODP
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 19
modifie: 2026-11-16
---

# BIB18/QRPGLESRC/TP2MODP

```rpg
**free
/if not defined(TP2MODP)
/define TP2MODP
//retour packed(7:0) : ARSTK, ou -1 si l'article est inconnu
dcl-pr stockArticle packed(7:0);
    code char(6) const;
end-pr;

// retour ARSTK x ARPXHT, ou 0 si inconnu
dcl-pr valeurStock packed(11:2);
    code char(6) const;
end-pr;

dcl-pr estDisponible ind;
    code char(6) const;
    qte packed(7:0) const;
end-pr;

/endif
```
