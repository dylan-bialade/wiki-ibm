---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: ANIMSFL
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 127
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/ANIMSFL

```rpg
**free
ctl-opt dftactgrp(*no) actgrp(*new);
// Fichier de données
dcl-f persolf usage(*input) keyed;
dcl-f ANIMSFLDSP workstn sfile(sfl1 : rang);

// Interface : le parametre recu (numero univers)
dcl-pi *n;
    univChoisi zoned(2:0);
    quitter    ind;
end-pi;

dcl-s rang packed(4:0);


quitter = *off;
 //appel de la procedure d'initialisation du SFL1 et remplissage du SFL1
initSFL1();
fillSFL1();
dow *inkc = *off and not *inkl;
    write foot;
    exfmt ctl1;

enddo;

quitter = *inkc;

*inlr = *on;


//procedure d'init du sfl1
dcl-proc initSFL1;
    *in31 = *off;
    *in32 = *off;
    *in33 = *off;

    *in30 = *on;

    write ctl1;
    *in30 = *off;
    rang = 0;
end-proc;

//Procédure remplissage du SFL1
dcl-proc fillSFL1;
    if univChoisi = 99;
        setll *loval persolf;
        read persolf;
    else;
        setll (univChoisi) persolf;
        reade (univChoisi) persolf;
    endif;

    dow not %eof(persolf) and rang < 9999;
        rang += 1;
        tmpappar = minToString(TEMPS);
        //TODO: allonger tmpappar dans sfl1
        write sfl1;
        if univChoisi = 99;
            read persolf;
        else;
            reade (univChoisi) persolf;
        endif;
    enddo;

    *in31 = *on;
    *in32 = (rang > 0);
    *in33 = *on;
end-proc;

//Procedure convertion minutes en string  (format lisible : X j, Y h et Z min)
dcl-proc minToString;
    dcl-pi *n varchar(30);          // type de la valeur retournee
        minutes packed(7:0) const;
    end-pi;
    dcl-s jours packed(3:0);
    dcl-s heures packed(2:0);
    dcl-s mins packed(2:0);

//Variables pour stocker les parties de la chaine de resultat
    dcl-s parts  varchar(10) dim(3);
    dcl-s nb     int(10);
    dcl-s i      int(10);
    dcl-s resultat varchar(30);


    // jours = minutes / 1440;
    // minutes -= jours * 1440;

    // heures = minutes / 60;
    // minutes -= heures * 60;

    // mins = minutes;

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
