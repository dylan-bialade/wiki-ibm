---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: ANIMSFSQL2
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 447
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/ANIMSFSQL2

```rpg
**free
//================================================================
// Selection d'un univers, puis liste des personnages en sous-fichier
// - FMT1     : choix d'un univers (bouton radio), F10 = choix multiple
// - SFL1     : liste des personnages, chargee page par page
// - WDWSFLCH : fenetre de choix multiple des univers
//================================================================
ctl-opt dftactgrp(*no) actgrp(*new);

dcl-f ANIMSFLD3 workstn sfile(sfl1 : rang) sfile(wdwsflch : wRang)
                indds(indEcran);

dcl-f persanim printer usropn usage(*output) oflind(sautPage);
dcl-s sautPage ind;

// Indicateurs de l'ecran
dcl-ds indEcran;
    f3           ind pos(3);
    f5           ind pos(5);
    f8           ind pos(8);
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
dcl-s isv1Avant ind;

dcl-ds perso qualified;
    nom     char(15);
    prenom  char(15);
    uniname char(100);
    temps   zoned(20:0);
end-ds;

dcl-ds univ qualified;
    univer  zoned(9:0);
    uniname char(100);
end-ds;

dcl-s ecran         char(10) inz('CHOIX');
dcl-s ecranRetour   char(10);
// la liste des persos doit être reconstruite
dcl-s rechargerPers ind;
// la liste des univers doit être reconstruite
dcl-s rechargerUniv ind;

exec sql set option commit = *none;
//================================================================
// Programme principal : ecran de selection
//================================================================
monitor;
    dow not f3;
        select;
            when ecran = 'CHOIX';
                ecranChoix();
            when ecran = 'LISTE';
                ecranListe();
            when ecran = 'UNIVERS';
                ecranUnivers();
        endsl;
    enddo;

on-error;
    openNotif('Erreur inattendue, statut ' + %char(%status));

endmon;
*inlr = *on;

dcl-proc ecranChoix;
    exfmt fmt1;
    select;
        when f3;
        when f10 or f22;
            ouvrirFenetreUnivers();
        other;
            isv1 = *on;
            if choix = 99 or choix = 0; // "Tous" ou rien coché
                nbUniv = 0;
            else;
                nbUniv = 1;
                univTab(1) = choix;
            endif;
            rechargerPers = *on;
            ecran = 'LISTE';
    endsl;
end-proc;

dcl-proc ecranListe;
    if rechargerPers;
        chargerPersos(); // vide le sfl, (ré)ouvre le curseur, 1re page
        rechargerPers = *off;
    endif;
    write foot;
    exfmt ctl1;
    select;
        when f3;
        when f12;
            ecran = 'CHOIX';
        when f5;
            rechargerPers = *on;
        when f8;
            printPersos();
        when pageSuiv;
            chargerPagePersos();
        when f10 or f22;
            ouvrirFenetreUnivers();
    endsl;
end-proc;

dcl-proc ecranUnivers;
    if rechargerUniv;
        chargerUnivers();
        rechargerUniv = *off;
    endif;
    exfmt wdwctlch;
    select;
        when f12;
            isv1  = isv1Avant;
            ecran = ecranRetour;
        when wdwPageSuiv;
            chargerPageUnivers();
        when wdwFltChg;
            rechargerUniv = *on;
        other;
            // boucle readc -> univTab
            lireChoixUnivers();
            rechargerPers = *on;
            ecran = 'LISTE';
    endsl;
end-proc;


//================================================================
// Vide le sous-fichier, (ré)ouvre le curseur, charge la 1re page
//================================================================
dcl-proc chargerPersos;
    dcl-s sqlTxt   varchar(1000);

    // vider le sous-fichier
    sflDspCtl = *off;
    sflDsp    = *off;
    sflEnd    = *off;
    sflClr    = *on;
    write ctl1;
    sflClr    = *off;
    rang      = 0;

    sqlTxt = requetePersos();

    exec sql declare cPersos cursor for sPersos;
    exec sql close cPersos;
    exec sql prepare sPersos from :sqlTxt;
    exec sql open cPersos;

    chargerPagePersos();
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


//================================================================
// Ajoute 12 personnages au sous-fichier
//================================================================
dcl-proc chargerPagePersos;
    dcl-s n int(5);

    for n = 1 to 12;
        exec sql fetch next from cPersos into :perso;
        if sqlcode <> 0;
            sflEnd = *on;
            leave;
        endif;
        nom      = perso.nom;
        prenom   = perso.prenom;
        uniapr   = %subst(perso.uniname : 1 : 20);
        uninam1  = %subst(perso.uniname : 1 : 50);
        uninam2  = %subst(perso.uniname : 51 : 50);
        tmpappar = minToString(perso.temps);
        rang += 1;
        write sfl1;
    endfor;

    sflDspCtl = *on;
    if rang > 0;
        sflDsp = *on;
        rcdnbr = rang;
    endif;
end-proc;


//================================================================
// Vide la windowsfl
//================================================================
dcl-proc chargerUnivers;
    dcl-s sqlTxt   varchar(1000);
    dcl-s tUnivers varchar(30);
    dcl-s motif    varchar(102);

    //reinitialiser le sous-fichier de la window
    wdwSflDspCtl = *off;
    wdwSflDsp    = *off;
    wdwSflEnd    = *off;
    wdwSflClr    = *on;
    write wdwctlch;
    wdwSflClr    = *off;
    wRang        = 0;

    // tables selon la source
    if isv1;
        tUnivers = 'BIB17.UNIVERS';
    else;
        tUnivers = 'ANIME.UNIVERSV2';
    endif;

    sqlTxt = 'select u.univer, u.uniname from ' + tUnivers + ' u';
    if fltuniv <> *blank;
        sqlTxt += ' where upper(u.uniname) like ?';
    endif;
    sqlTxt += ' order by u.uniname';

    exec sql declare cUnivers cursor for sUnivers;
    exec sql close cUnivers;
    exec sql prepare sUnivers from :sqlTxt;
    if fltuniv <> *blank;
        motif = '%' + %trim(%upper(fltuniv)) + '%';
        exec sql open cUnivers using :motif;
    else;
        exec sql open cUnivers;
    endif;

    chargerPageUnivers();
end-proc;

//================================================================
// Ajoute 12 univers au sous-fichier de la window
//================================================================
dcl-proc chargerPageUnivers;
    dcl-s n int(5);

    for n = 1 to 12;
        exec sql fetch next from cUnivers into :univ;
        if sqlcode <> 0;
            wdwsflEnd = *on;
            leave;
        endif;
        uninam1 = %subst(univ.uniname : 1 : 50);
        uninam2 = %subst(univ.uniname : 51 : 50);
        wunivid = univ.univer;

        wrang += 1;
        wdwopt = 0;
        write wdwsflch;
    endfor;

    wdwSflDspCtl = *on;
    if wrang > 0;
        wdwSflDsp = *on;
        WRCDNBR = wrang;
    endif;
end-proc;

dcl-proc lireChoixUnivers;
    nbUniv = 0;
    readc wdwsflch;
    dow not %eof(ANIMSFLD3);
        if wdwopt = 1 and nbUniv < %elem(univTab);
            nbUniv += 1;
            univTab(nbUniv) = wunivid;
        endif;
        readc wdwsflch;
    enddo;
end-proc;


dcl-proc ouvrirFenetreUnivers;
 // pour restaurer si F12
    isv1Avant     = isv1;
    isv1          = f10;
    fltuniv       = *blank;
    rechargerUniv = *on;
    ecranRetour   = ecran;
    ecran         = 'UNIVERS';
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

//================================================================
// Imprimer la liste des personnages
//================================================================
dcl-proc printPersos;
    dcl-s sqlTxt varchar(1000);

    sqlTxt = requetePersos();
    exec sql declare cPrint cursor for sPrint;
    exec sql prepare sPrint from :sqlTxt;
    exec sql open cPrint;

    open persanim;
    write titre;
    write entete;
    write tirets;

    exec sql fetch next from cPrint into :perso;
    dow sqlcode = 0;
     // page pleine : en-tete sur une nouvelle page
        if sautPage;
            write titre;
            write entete;
            write tirets;
            sautPage = *off;
        endif;
        pnom    = perso.nom;
        pprenom = perso.prenom;
        puniv   = %subst(perso.uniname : 1 : 90);
        write ligne;
        exec sql fetch next from cPrint into :perso;
    enddo;

    close persanim;
    exec sql close cPrint;

    openNotif('Impression terminee');
end-proc;


//================================================================
// Requete des personnages selon la source et le filtre
//================================================================
dcl-proc requetePersos;
    dcl-pi *n varchar(1000) end-pi;
    dcl-s tPerso   varchar(30);
    dcl-s tUnivers varchar(30);

    if isv1;
        tPerso   = 'BIB17.PERSO';
        tUnivers = 'BIB17.UNIVERS';
    else;
        tPerso   = 'ANIME.PERSOV2';
        tUnivers = 'ANIME.UNIVERSV2';
    endif;

    return 'select p.nom, p.prenom, u.uniname, p.temps '
         + 'from ' + tPerso + ' p '
         + 'join ' + tUnivers + ' u on u.univer = p.univers'
         + filtreUnivers()
         + ' order by p.univers, p.nom, p.prenom';
end-proc;



//================================================================
// Afficher une notification dans la window de notification, texte variable
//================================================================
dcl-proc openNotif;
    dcl-pi *n;
        textNotif varchar(1000) const;
    end-pi;
    notifmsg = textNotif;
    exfmt wdwnotif;
end-proc;
```
