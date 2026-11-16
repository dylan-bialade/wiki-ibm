---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: ANIMSFL2
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 248
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/ANIMSFL2

```rpg
**free
//================================================================
// Selection d'un univers, puis liste des personnages en sous-fichier
// - FMT1     : choix d'un univers (bouton radio), F10 = choix multiple
// - SFL1     : liste des personnages, chargee page par page
// - WDWSFLCH : fenetre de choix multiple des univers
//================================================================
ctl-opt dftactgrp(*no) actgrp(*new);

// Fichiers de donnees
dcl-f persolf  usage(*input) keyed;
dcl-f fUnivers usage(*input) keyed extdesc('UNIVERS') extfile(*extdesc);

// Ecran
dcl-f ANIMSFLD2 workstn sfile(sfl1 : rang) sfile(wdwsflch : wRang)
                indds(indEcran);

dcl-ds indEcran;
    f3           ind pos(3);
    f5           ind pos(5);
    f10          ind pos(10);
    f12          ind pos(12);
    // sous-fichier principal
    sflClr       ind pos(30);
    sflDspCtl    ind pos(31);
    sflDsp       ind pos(32);
    sflEnd       ind pos(33);
    pageSuiv     ind pos(39);
    // sous-fichier de la fenetre
    wdwSflClr    ind pos(40);
    wdwSflDspCtl ind pos(41);
    wdwSflDsp    ind pos(42);
    wdwSflEnd    ind pos(43);
end-ds;

// Rangs des sous-fichiers
dcl-s rang  packed(4:0);
dcl-s wRang packed(4:0);

// Filtre : univers choisis (nbUniv = 0 : tous)
dcl-s univTab like(univers) dim(99);
dcl-s nbUniv  int(10);

//================================================================
// Programme principal : ecran de selection
//================================================================
dow not f3;
    exfmt fmt1;
    if f3;
        leave;
    endif;

    select;
        when f10;                        // choix multiple dans la fenetre
            nbUniv = 0;
            afficherListe(*on);
        when choix = 99;                 // tous les univers
            nbUniv = 0;
            afficherListe(*off);
        when choix <> 0;                 // un univers
            nbUniv = 1;
            univTab(1) = choix;
            afficherListe(*off);
    endsl;
enddo;

*inlr = *on;

//================================================================
// Liste des personnages : boucle de l'ecran CTL1
// ouvrirFiltre = *on : ouvre d'abord la fenetre des univers
//================================================================
dcl-proc afficherListe;
    dcl-pi *n;
        ouvrirFiltre ind const;
    end-pi;

    f12 = *off;
    chargerListe();
    if ouvrirFiltre;
        choisirUnivers();
    endif;

    dow not f3 and not f12;
        write foot;
        exfmt ctl1;
        select;
            when f5;
                chargerListe();
            when f10;
                choisirUnivers();
            when pageSuiv;
                chargerPage();
        endsl;
    enddo;

    f12 = *off;                          // F12 : retour a l'ecran de selection
end-proc;

//================================================================
// Sous-fichier principal
//================================================================
dcl-proc initSFL1;
    sflDspCtl = *off;
    sflDsp    = *off;
    sflEnd    = *off;
    sflClr    = *on;
    write ctl1;
    sflClr    = *off;
    rang      = 0;
end-proc;

dcl-proc chargerListe;
    initSFL1();
    setll *loval persolf;
    chargerPage();
end-proc;

// Chargement d'une page (11 lignes, comme SFLPAG)
dcl-proc chargerPage;
    dcl-s compteur packed(4:0);
    compteur = 0;

    dow compteur < 11 and rang < 9999;
        read persolf;

        if %eof(persolf);
            sflEnd = *on;
            leave;
        endif;

        // on garde le personnage si aucun filtre, ou si son univers est choisi
        if nbUniv = 0 or %lookup(univers : univTab : 1 : nbUniv) > 0;
            rang += 1;
            compteur += 1;
            tmpappar = minToString(TEMPS);
            write sfl1;
        endif;
    enddo;

    sflDspCtl = *on;
    //sflDsp    = (rang > 0);
    if rang > 0;
        sflDsp    = *on;
        rcdnbr = rang; // affiche la page qui vient d'etre chargee
    endif;
end-proc;

//================================================================
// Fenetre de choix multiple des univers
//================================================================
dcl-proc choisirUnivers;
    initWdwSfl();
    chargerWdwSfl();
    exfmt wdwctlch;
    traiterChoixUnivers();
end-proc;

dcl-proc initWdwSfl;
    wdwSflDspCtl = *off;
    wdwSflDsp    = *off;
    wdwSflEnd    = *off;
    wdwSflClr    = *on;
    write wdwctlch;
    wdwSflClr    = *off;
    wRang        = 0;
end-proc;

dcl-proc chargerWdwSfl;
    setll *loval UNIVERSF;
    read UNIVERSF;
    dow not %eof(fUnivers) and wRang < 9999;
        wRang += 1;
        wdwopt = 0;
        write wdwsflch;
        read UNIVERSF;
    enddo;

    wdwSflDspCtl = *on;
    wdwSflDsp    = (wRang > 0);
    wdwSflEnd    = *on;
end-proc;

dcl-proc traiterChoixUnivers;
// annulation : le filtre ne change pas
    if f12;
        f12 = *off;
        return;
    endif;

    nbUniv = 0;
    readc wdwsflch;
    dow not %eof(ANIMSFLD2);
        if wdwopt = 1 and nbUniv < %elem(univTab);
            nbUniv += 1;
            univTab(nbUniv) = univer;
        endif;
        readc wdwsflch;
    enddo;

    chargerListe();
end-proc;

//================================================================
// Conversion de minutes en texte
//================================================================
dcl-proc minToString;
    dcl-pi *n varchar(30);
        minutes packed(7:0) const;
    end-pi;
    dcl-s jours    packed(5:0);
    dcl-s heures   packed(2:0);
    dcl-s mins     packed(2:0);
    dcl-s parts    varchar(10) dim(3);
    dcl-s nb       int(10);
    dcl-s i        int(10);
    dcl-s resultat varchar(30);

    jours  = %div(minutes : 1440);
    heures = %div(%rem(minutes : 1440) : 60);
    mins   = %rem(minutes : 60);

    if jours > 0;
        nb += 1;
        parts(nb) = %char(jours) + ' j';
    endif;
    if heures > 0;
        nb += 1;
        parts(nb) = %char(heures) + ' h';
    endif;
    if mins > 0;
        nb += 1;
        parts(nb) = %char(mins) + ' min';
    endif;

    for i = 1 to nb;
        if i > 1;
            if i = nb;
                resultat += ' et ';
            else;
                resultat += ', ';
            endif;
        endif;
        resultat += parts(i);
    endfor;

    return resultat;
end-proc;
```
