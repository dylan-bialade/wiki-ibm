---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: ANIMSFL3
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 392
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/ANIMSFL3

```rpg
**free
//================================================================
// Selection d'un univers, puis liste des personnages en sous-fichier
// - FMT1     : choix d'un univers (bouton radio), F10 = choix multiple
// - SFL1     : liste des personnages, chargee page par page
// - WDWSFLCH : fenetre de choix multiple des univers
//================================================================
ctl-opt dftactgrp(*no) actgrp(*new);
//================================================================
// Declaration des fichiers
//================================================================
// Fichiers de donnees pour univers et perso v1
dcl-f persolf  usage(*input) keyed;
dcl-f fUnivers usage(*input) keyed extdesc('UNIVERS') extfile(*extdesc);

// Fichier de donnees V2 pour f22
dcl-f persolf2 usage(*input) keyed prefix(v2_) rename(persojr : persojr2);
dcl-f UNIVERSV2L usage(*input) keyed prefix(v2_);

// Ecran
dcl-f ANIMSFLD3 workstn sfile(sfl1 : rang) sfile(wdwsflch : wRang)
                indds(indEcran);

//================================================================
// Declaration des variables
//================================================================

// Indicateurs de l'ecran
dcl-ds indEcran;
    f3           ind pos(3);
    f5           ind pos(5);
    f10          ind pos(10);
    f12          ind pos(12);
    f22          ind pos(22);
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
    wdwPageSuiv  ind pos(49);
end-ds;

// Rangs des sous-fichiers
dcl-s rang  packed(4:0);
dcl-s wRang packed(4:0);

// Filtre : univers choisis (nbUniv = 0 : tous)
dcl-s univTab like(v2_univer) dim(99);
dcl-s nbUniv  int(10);
//  Indice de l'univers courant dans le tableau univTab
dcl-s idxUniv int(10) inz(1);
// '1' = V1, '2' = V2
dcl-s source  char(1) inz('1');

// Zones de travail avant transformation pour affichage
dcl-s nomComplet char(100);
dcl-s tempsPerso like(temps);


//================================================================
// Programme principal : ecran de selection
//================================================================
dow not f3;
    exfmt fmt1;

    select;
        // choix multiple dans la fenetre sur univers v1
        when f10;
            source = '1';
            nbUniv = 0;
            afficherListe(*on);

        // choix multiple dans la fenetre sur univers v2
        when f22;
            source = '2';
            nbUniv = 0;
            afficherListe(*on);

        // tous les univers
        when choix = 99;
            source = '1';
            nbUniv = 0;
            afficherListe(*off);

        //traiter le choix de l'input radio sur fmt1
        when choix <> 0;
            source = '1';
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
                source = '1';
                nbUniv = 0;
                choisirUnivers();
            when f22;
                source = '2';
                nbUniv = 0;
                choisirUnivers();
            when pageSuiv;
                chargerPage();
        endsl;
    enddo;
 // F12 : retour a l'ecran de selection
    f12 = *off;
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

// Charge la liste des personnages dans le sous-fichier
dcl-proc chargerListe;
    initSFL1();
    idxUniv = 1;

    if source = '1';
        if nbUniv = 0;
            setll *loval persolf;
        else;
            setll (univTab(1)) persolf;
        endif;
    else;
        if nbUniv = 0;
            setll *loval persolf2;
        else;
            setll (univTab(1)) persolf2;
        endif;
    endif;

    chargerPage();
end-proc;

// Lit le personnage suivant dans la source active.
// Renvoie *on si un personnage a ete lu, *off s'il n'y en a plus.
dcl-proc personnageSuivant;
    dcl-pi *n ind end-pi;
    //Source univers
    if source = '1';
        //si tableau vide = aucun univers selectionne, on lit tous les personnages
        if nbUniv = 0;
            read persolf;
        //Sinon on lit les personnages de l'univers courant, puis on passe au suivant si on a fini
        else;
            reade (univTab(idxUniv)) persolf;
            dow %eof(persolf) and idxUniv < nbUniv;
                idxUniv += 1;
                setll (univTab(idxUniv)) persolf;
                reade (univTab(idxUniv)) persolf;
            enddo;
        endif;

        if %eof(persolf);
            return *off;
        endif;


        nomComplet = uniname;
        tempsPerso = temps;

    //Source universv2
    else;
        if nbUniv = 0;
            read persolf2;
        else;
            reade (univTab(idxUniv)) persolf2;
            dow %eof(persolf2) and idxUniv < nbUniv;
                idxUniv += 1;
                setll (univTab(idxUniv)) persolf2;
                reade (univTab(idxUniv)) persolf2;
            enddo;
        endif;
        if %eof(persolf2);
            return *off;
        endif;

        // zones prefixees : recopie dans les zones de l'ecran
        nom        = v2_nom;
        prenom     = v2_prenom;
        nomComplet = v2_uniname;
        tempsPerso = v2_temps;
    endif;

    return *on;
end-proc;


//Charge la page de sfl de maniere semi dynamique
dcl-proc chargerPage;
    dcl-s compteur packed(4:0);

    dow compteur < 12 and rang < 9999;
        if not personnageSuivant();
            sflEnd = *on;
            leave;
        endif;

        uniapr   = %subst(nomComplet : 1 : 20);
        uninam1  = %subst(nomComplet : 1 : 50);
        uninam2  = %subst(nomComplet : 51 : 50);
        tmpappar = minToString(tempsPerso);
        rang += 1;
        compteur += 1;
        write sfl1;
    enddo;

    sflDspCtl = *on;
    if rang > 0;
        sflDsp = *on;
        rcdnbr = rang;
    endif;
end-proc;

//================================================================
// Fenetre de choix multiple des univers
//================================================================
dcl-proc choisirUnivers;
    initWdwSfl();
    if source = '1';
        setll *loval UNIVERSF;
    else;
        setll *loval UNIVV2F;       // nom du format de UNIVERSV2
    endif;
    chargerPageWdw();

    dow *on;
        exfmt wdwctlch;
        if wdwPageSuiv;
            chargerPageWdw();      // page suivante, puis on reaffiche
            iter;
        endif;
        leave;                     // Entree ou F12 : on sort de la boucle
    enddo;

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

dcl-proc chargerPageWdw;
    dcl-s compteur packed(4:0);
    dcl-s nomComplet char(100);

    dow compteur < 4 and wRang < 9999;
        if source = '1';
            read universf;
            if %eof(fUnivers);
                wdwSflEnd = *on;
                leave;
            endif;
            nomComplet = uniname;
            wunivid    = univer;
        else;
            read UNIVV2F;
            if %eof(UNIVERSV2L);
                wdwSflEnd = *on;
                leave;
            endif;
            nomComplet = v2_uniname;
            wunivid    = v2_univer;
        endif;

        uninam1 = %subst(nomComplet : 1 : 50);
        uninam2 = %subst(nomComplet : 51 : 50);
        wdwopt  = 0;
        wRang += 1;
        compteur += 1;
        write wdwsflch;


    enddo;

    wdwSflDspCtl = *on;
    if wrang > 0;
        wdwSflDsp = *on;
        WRCDNBR = wrang;
    endif;
end-proc;

dcl-proc traiterChoixUnivers;
// annulation : le filtre ne change pas
    if f12;
        f12 = *off;
        return;
    endif;

    nbUniv = 0;
    readc wdwsflch;
    dow not %eof(ANIMSFLD3);
        if wdwopt = 1 and nbUniv < %elem(univTab);
            nbUniv += 1;
            univTab(nbUniv) = wunivid;
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
