---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: ANIMSFLSQL
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 426
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/ANIMSFLSQL

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
    wdwFltChg   ind pos(44);
    wdwPageSuiv  ind pos(49);
end-ds;

// Rangs des sous-fichiers
dcl-s rang  packed(4:0);
dcl-s wRang packed(4:0);

// Filtre : univers choisis (nbUniv = 0 : tous)
dcl-s univTab packed(9:0) dim(99);
dcl-s nbUniv  int(10);

// booléen pour savoir si on affiche l'univers 1(on) ou l'univers 2(off)
dcl-s isv1 ind inz(*on);

dcl-ds persoDs qualified dim(12);
    nom     char(15);
    prenom  char(15);
    uniname char(100);
    temps   zoned(20:0);
end-ds;

dcl-ds universDs qualified dim(12);
    univer  zoned(9:0);
    uniname char(100);
end-ds;



exec sql set option commit = *none;
//================================================================
// Programme principal : ecran de selection
//================================================================
dow not f3;
    exfmt fmt1;

    select;
        // choix multiple dans la fenetre sur univers v1
        when f10;
            isv1 = *on;
            if afficherWindowUnivers();
                afficherPersos();
            endif;

        // choix multiple dans la fenetre sur univers v2
        when f22;
            isv1 = *off;
            nbUniv = 0;
            if afficherWindowUnivers();
                afficherPersos();
            endif;

        // tous les univers
        when choix = 99;
            isv1 = *on;
            nbUniv = 0;
            afficherPersos();

        //traiter le choix de l'input radio sur fmt1
        when choix <> 0;
            isv1 = *on;
            nbUniv = 1;
            univTab(1) = choix;
            afficherPersos();
    endsl;
enddo;

*inlr = *on;

//================================================================
// Procédures SQL pour personnages
//================================================================
dcl-proc openCursorPersos;
    dcl-s sqlTxt   varchar(1000);
    dcl-s tPerso   varchar(30);
    dcl-s tUnivers varchar(30);

    // Tables selon la source
    if isv1 = *on;
        tPerso   = 'BIB17.PERSO';
        tUnivers = 'BIB17.UNIVERS';
    else;
        tPerso   = 'ANIME.PERSOV2';
        tUnivers = 'ANIME.UNIVERSV2';
    endif;

    // Construction de la requete
    sqlTxt = 'select p.nom, p.prenom, u.uniname, p.temps '
           + 'from ' + tPerso + ' p '
           + 'join ' + tUnivers + ' u on u.univer = p.univers'
           + filtreUnivers()
           + ' order by p.univers, p.nom, p.prenom';

    exec sql prepare sPersos from :sqlTxt;
    exec sql declare cPersos cursor for sPersos;
    exec sql open cPersos;
end-proc;

// filtre sur les univers choisis ('' si aucun filtre)
dcl-proc filtreUnivers;
    dcl-pi *n varchar(1000) end-pi;
    dcl-s clause varchar(1000);
    dcl-s i      int(10);

    if nbUniv = 0;
        return '';
    endif;

    clause = ' where p.univers in (';
    for i = 1 to nbUniv;
        if i > 1;
            clause += ', ';
        endif;
        clause += %char(univTab(i));
    endfor;
    clause += ')';

    return clause;
end-proc;

dcl-proc closeCursorPersos;
    exec sql close cPersos;
end-proc;

//================================================================
// Procédures SQL pour univers
//================================================================
dcl-proc openCursorUnivers;
    dcl-s sqlTxt   varchar(1000);
    dcl-s tUnivers varchar(30);
    dcl-s motif    varchar(102);

    // Tables selon la source
    if isv1 = *on;
        tUnivers = 'BIB17.UNIVERS';
    else;
        tUnivers = 'ANIME.UNIVERSV2';
    endif;

    sqlTxt = 'select u.univer, u.uniname from ' + tUnivers + ' u';
    if fltuniv <> *blank;
        sqlTxt += ' where upper(u.uniname) like ?';
    endif;
    sqlTxt += ' order by u.uniname';

    exec sql prepare sUnivers from :sqlTxt;
    exec sql declare cUnivers cursor for sUnivers;
    if fltuniv <> *blank;
        motif = '%' + %trim(%upper(fltuniv)) + '%';   // "contient"
        exec sql open cUnivers using :motif;
    else;
        exec sql open cUnivers;
    endif;
end-proc;

dcl-proc closeCursorUnivers;
    exec sql close cUnivers;
end-proc;

//================================================================
// Ouvrir le sous fichier de personnages
//================================================================
dcl-proc initSFL1;
    sflDspCtl = *off;
    sflDsp    = *off;
    sflEnd    = *off;
    sflClr    = *on;
    write ctl1;
    sflClr    = *off;
    rang      = 0;
    closeCursorPersos();
    openCursorPersos();
end-proc;

dcl-proc loadSfl1;
    dcl-s i         int(10);
    dcl-s nbLus     int(10);

    exec sql fetch next from cPersos for 12 rows into :persoDs;
    if sqlcode < 0;
        // erreur SQL
        return;
    endif;

    // nombre de lignes reellement lues
    nbLus = sqlerrd(3);

    for i = 1 to nbLus;
        nom      = persoDs(i).nom;
        prenom   = persoDs(i).prenom;
        uniapr   = %subst(persoDs(i).uniname : 1 : 20);
        uninam1  = %subst(persoDs(i).uniname : 1 : 50);
        uninam2  = %subst(persoDs(i).uniname : 51 : 50);
        tmpappar = minToString(persoDs(i).temps);
        rang += 1;
        write sfl1;
    endfor;
    // moins de 12 lignes : fin des donnees
    if nbLus < 12;
        sflEnd = *on;
    endif;

    sflDspCtl = *on;
    if rang > 0;
        sflDsp = *on;
        rcdnbr = rang;
    endif;
end-proc;


dcl-proc afficherPersos;
//remettre f12 à off pour ne pas sortir de l'écran
    f12 = *off;
    initSFL1();
    loadSfl1();

    dow not f3 and not f12;
        write foot;
        exfmt ctl1;

        select;
            when f5;
                initSFL1();
                loadSfl1();

            when f10;
                isv1 = *on;
                if afficherWindowUnivers();
                    initSFL1();
                    loadSfl1();
                endif;
            when f22;
                isv1 = *off;
                if afficherWindowUnivers();
                    initSFL1();
                    loadSfl1();
                endif;
            when pageSuiv;
                loadSfl1();
        endsl;
    enddo;

    closeCursorPersos();
    f12 = *off;
end-proc;

//================================================================
// Ouvrir la window sfl de choix multiple d'univers
//================================================================

//init du sous fichier
dcl-proc initWdwsfl;
    wdwSflDspCtl = *off;
    wdwSflDsp    = *off;
    wdwSflEnd    = *off;
    wdwSflClr    = *on;
    write wdwctlch;
    wdwSflClr    = *off;
    wRang        = 0;
    closeCursorUnivers();
    openCursorUnivers();
end-proc;


dcl-proc loadWdwSfl;
    dcl-s i         int(10);
    dcl-s nbLus     int(10);

    exec sql fetch next from cUnivers for 12 rows into :universDs;
    if sqlcode < 0;
        // erreur SQL
        return;
    endif;

    // nombre de lignes reellement lues
    nbLus = sqlerrd(3);

    for i = 1 to nbLus;
        uninam1 = %subst(universDs(i).uniname : 1 : 50);
        uninam2 = %subst(universDs(i).uniname : 51 : 50);
        wunivid = universDs(i).univer;
        wRang +=1;
        wdwopt  = 0;
        write wdwsflch;
    endfor;
    // moins de 12 lignes : fin des donnees
    if nbLus < 12;
        wdwSflEnd = *on;
    endif;

    wdwSflDspCtl = *on;
    if wrang > 0;
        wdwSflDsp = *on;
        WRCDNBR = wrang;
    endif;
end-proc;


// Renvoie *on si l'utilisateur a valide un choix, *off s'il a annule
dcl-proc afficherWindowUnivers;
    dcl-pi *n ind end-pi;

    initWdwsfl();
    loadWdwSfl();
    dow *on;
        exfmt wdwctlch;
        select;
            when f12;
                leave;
            when wdwPageSuiv;
                loadWdwSfl();
            when wdwFltChg;                 // filtre modifié : on recharge
                closeCursorUnivers();
                initWdwsfl();               // efface le sous-fichier + rouvre le curseur
                loadWdwSfl();
            other;                          // Entrée sans changement de filtre
                leave;                      // -> traiterChoixUnivers
        endsl;
    enddo;
    closeCursorUnivers();

    return traiterChoixUnivers();
end-proc;

dcl-proc traiterChoixUnivers;
    dcl-pi *n ind end-pi;
// annulation : le filtre ne change pas
    if f12;
        f12 = *off;
        return *off;
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
    return *on;
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
