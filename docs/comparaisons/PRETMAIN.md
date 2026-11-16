# PRETMAIN : 3 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB03 | QRPGLESRC | RPG/RPG-ILE | 95 | 100 % | full free, sous-fichier, ecran (WORKSTN), boucle DOW/DOU/FOR, procedures (dcl-proc), structure de donnees | [PRETMAIN.md](../../sources/RPG/RPG-ILE/BIB03/PRETMAIN.md) |
| BIB13 | QRPGLESRC | RPG/RPG-ILE | 167 | 9 % | full free, sous-fichier, ecran (WORKSTN), boucle DOW/DOU/FOR, procedures (dcl-proc), structure de donnees | [PRETMAIN.md](../../sources/RPG/RPG-ILE/BIB13/PRETMAIN.md) |
| BIB17 | QRPGLESRC | RPG/RPG-ILE | 106 | 6 % | full free, sous-fichier, ecran (WORKSTN), boucle DOW/DOU/FOR, procedures (dcl-proc), structure de donnees, indicateurs *INxx | [PRETMAIN.md](../../sources/RPG/RPG-ILE/BIB17/PRETMAIN.md) |

## Differences

- Techniques communes : full free, sous-fichier, ecran (WORKSTN), boucle DOW/DOU/FOR, procedures (dcl-proc), structure de donnees
- **BIB17** en propre : indicateurs *INxx

## Codes

### BIB03 (RPG/RPG-ILE, 95 lignes)

```text
**free
ctl-opt decedit('0,') bnddir('BIB03/PRETBND') dftactgrp(*no);
/include QCPYSRC,PRETMODP

dcl-f PRETDSP workstn indds(ind) sfile(PRETSFL : rrn);

dcl-ds ind len(99);
  f3      ind pos(3);
  f12     ind pos(12);
  sfldsp  ind pos(41);
  sfldspc ind pos(42);
  sflclr  ind pos(43);
  sflend  ind pos(44);
end-ds;

dcl-s rrn zoned(4:0);

wcapital = 200000;
wtaux = 3.5;
wduree = 20;

dou f3;
  exfmt SAISIE;
  if f3;
    leave;
  endif;

  if wcapital <= 0 or wtaux < 0 or wduree < 1 or wduree > 30;
    errmsg = 'Capital > 0, taux >= 0, duree de 1 a 30 ans';
  else;
    errmsg = *blanks;
    afficherTableau();
  endif;
enddo;

*inlr = *on;

dcl-proc afficherTableau;
  dcl-s nbMois int(10);
  dcl-s i int(10);
  dcl-s restant packed(9:2);
  dcl-s mens packed(9:2);
  dcl-s interet packed(9:2);
  dcl-s remb packed(9:2);
  dcl-s totInt packed(11:2);
  dcl-s paiement packed(9:2);
  dcl-s coutTot packed(11:2);

  nbMois = wduree * 12;
  mens = mensualite(wcapital : wtaux : nbMois);   // appel au programme de service

  // vider le sous-fichier
  sfldsp = *off;
  sfldspc = *off;
  sflclr = *on;
  write PRETCTL;
  sflclr = *off;
  rrn = 0;

  restant = wcapital;
  totInt = 0;

  for i = 1 to nbMois;
    interet = interetMois(restant : wtaux);       // appel au programme de service
    if i = nbMois;                                // dernier mois : on solde le pret
      remb = restant;
      paiement = restant + interet;
    else;
      remb = mens - interet;
      paiement = mens;
    endif;

    smois = i;
    srestant = %editc(restant : '1');             // montants mis en forme dans des zones alpha
    sinteret = %editc(interet : '1');
    sremb = %editc(remb : '1');
    smens = %editc(paiement : '1');
    rrn += 1;
    write PRETSFL;

    totInt += interet;
    restant -= remb;
  endfor;

  coutTot = wcapital + totInt;
  wmens = %editc(mens : '1');
  wcoutint = %editc(totInt : '1');
  wcouttot = %editc(coutTot : '1');

  curpage = 1;
  sfldsp = (rrn > 0);
  sfldspc = *on;
  sflend = *on;
  exfmt PRETCTL;                                  // F12 ou F3 : retour a la saisie
end-proc;
```

### BIB13 (RPG/RPG-ILE, 167 lignes)

_Long : voir [PRETMAIN.md](../../sources/RPG/RPG-ILE/BIB13/PRETMAIN.md)._

### BIB17 (RPG/RPG-ILE, 106 lignes)

```text
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
