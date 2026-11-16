---
bibliotheque: BIB17
fichier_source: QCPYSRC
membre: PRETIMMOP
type: RPG/Copy
longueur_enregistrement: 100
lignes: 56
modifie: 2026-11-16
---

# BIB17/QCPYSRC/PRETIMMOP

```rpg
**free
/if not defined(PRETIMMOP)
/define PRETIMMOP

dcl-ds totaux_t qualified template;
    totalInterets packed(11 : 2);
    coutTotal     packed(11 : 2);
end-ds;

dcl-pr calcTotaux likeds(totaux_t);
    duree packed(2:0);
    taux packed(5:2);
    montant packed(10:0);
end-pr;

dcl-pr calcMensualite packed(8 : 2);
    montant packed(10 : 0) const;
    taux    packed(5 : 2)  const;
    duree   packed(2 : 0)  const;
end-pr;

dcl-ds echeance_t qualified template;
    crdDebut   packed(12 : 2);
    interets   packed(8 : 2);
    capital    packed(8 : 2);
    mensualite packed(8 : 2);
    crdFin     packed(12 : 2);
end-ds;

dcl-pr calcEcheance likeds(echeance_t);
    crd     packed(12 : 2) const;
    taux    packed(5 : 2)  const;
    mens    packed(8 : 2)  const;
    dernier ind            const;
end-pr;

dcl-pr calcTotauxAmortConst likeds(totaux_t);
    duree packed(2:0);
    taux packed(5:2);
    montant packed(10:0);
end-pr;

dcl-pr calcEcheanceAmortConst likeds(echeance_t);
    crd     packed(12 : 2) const;
    taux    packed(5 : 2)  const;
    capRemb packed(12 : 2)  const;
    dernier ind            const;
end-pr;

dcl-pr calcCapitalConstant packed(12:2);
    duree packed(2:0);
    montant packed(10:0);
end-pr;


/endif
```
