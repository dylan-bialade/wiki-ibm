---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: PRETMAIN
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 106
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/PRETMAIN

```rpg
**free
ctl-opt bnddir('BIB17/PRETBND') dftactgrp(*no);

/copy QCPYSRC,PRETIMMOP

dcl-f PRETIMMO workstn sfile(sfl1 : rang);

// Rangs des sous-fichiers
dcl-s rang  packed(4:0);
dcl-s ecran         char(10) inz('CHOIX');

dcl-ds totaux likeds(totaux_t) inz;

//================================================================
// Programme principal : ecran de selection
//================================================================
dow not *in03;
    select;
        when ecran = 'CHOIX';
            ecranChoix();
        when ecran = 'LISTE';
            ecranListe();
    endsl;
enddo;

*inlr = *on;

dcl-proc ecranChoix;
    METHODE = 1;
    exfmt fmt1;
    if DUREE <> *zero and MONTANT <> *zero;
        ecran = 'LISTE';
    endif;
end-proc;

dcl-proc ecranListe;
    initSFL();

    if METHODE =1;
        totaux = calcTotaux(DUREE:taux:MONTANT);
    else;
        totaux = calcTotauxAmortConst(duree:taux:montant);
    endif;

    TOTPRET = totaux.coutTotal;
    TOTINT = totaux.totalInterets;

    loadSfl1();

    write foot;
    exfmt ctl1;

    select;
        when *in03;
        when *in12;
            ecran = 'CHOIX';
    endsl;

end-proc;

dcl-proc initSFL;
    *in31 = *off;
    *in32    = *off;
    *in33    = *off;
    *in30    = *on;
    write ctl1;
    *in30    = *off;
    rang = 0;

end-proc;

dcl-proc loadSfl1;
    dcl-ds ech likeds(echeance_t) inz;
    dcl-s crd     packed(12 : 2);
    dcl-s montantMois packed(12 : 2);
    dcl-s nbMois  int(10);
    dcl-s i       int(10);

    nbMois = DUREE * 12;
    crd    = MONTANT;
    if METHODE = 1;
        montantMois = calcMensualite(MONTANT : TAUX : DUREE);
    else;
        montantMois = calcCapitalConstant(DUREE: MONTANT);
    endif;

    for i = 1 to nbMois;
        if METHODE = 1;
            ech = calcEcheance(crd : TAUX : montantMois : i = nbMois);
        else;
            ech = calcEcheanceAmortConst(crd : TAUX : montantMois : i = nbMois);
        endif;
        MOIS       = i;
        CAPRESTDU  = ech.crdDebut;
        INTERET    = ech.interets;
        REMBCAP    = ech.capital;
        MENSUALITE = ech.mensualite;
        rang = i;
        write sfl1;
        crd = ech.crdFin;
    endfor;

    *in31 = *on;
    *in32 = rang > 0;
    *in33 = *on;
end-proc;
```
