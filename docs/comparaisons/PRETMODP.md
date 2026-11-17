# PRETMODP : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB03 | QCPYSRC | RPG/Copy | 16 | 100 % | full free, prototypes (dcl-pr) | [PRETMODP.md](../../sources/RPG/Copy/BIB03/PRETMODP.md) |
| BIB13 | QCPYSRC | RPG/Copy | 97 | 13 % | full free, prototypes (dcl-pr) | [PRETMODP.md](../../sources/RPG/Copy/BIB13/PRETMODP.md) |

## Differences

- Techniques communes : full free, prototypes (dcl-pr)

## Codes

### BIB03 (RPG/Copy, 16 lignes)

```text
**free
/if not defined(PRETMODP)
/define PRETMODP

dcl-pr mensualite packed(9:2);
  capital packed(9:2) const;
  tauxAnnuel packed(5:2) const;
  nbMois int(10) const;
end-pr;

dcl-pr interetMois packed(9:2);
  capitalRestant packed(9:2) const;
  tauxAnnuel packed(5:2) const;
end-pr;

/endif
```

### BIB13 (RPG/Copy, 97 lignes)

```text
**free

/if not defined(PRETMODP)

/define PRETMODP

dcl-pr nbmois packed(4:0);

  annee packed(3:0)const;

end-pr;

dcl-pr calcTotInteret packed(12:2);

  annee packed(3:0)const;

  taux  packed(4:2)const;

  montant packed(10:0)const;

end-pr;

dcl-pr calcMensualite packed(6:2);

  montant packed(10:2)const;

  taux packed(4:2)const;

  annee packed(3:0)const;

end-pr;

dcl-pr interetsMois packed(6:2);

  taux packed(4:2)const;

  capital packed(12:2)const;

end-pr;

dcl-pr ammotismois packed(6:2);

  interet packed(6:2) const;

  mens packed(6:2) const;

end-pr;

dcl-pr capitalRestant packed(12:2);

  capital packed(12:2) const;

  ammortis packed(6:2) const;

end-pr;

dcl-pr calcammorti packed(6:2);

  montant packed(12:2)const;

  annee packed(3:0)const;

end-pr;

dcl-pr mensualite packed(6:2);

  ammorti packed(6:2) const;

  interet packed(6:2)const;

end-pr;

/endif
```
