---
bibliotheque: BIB12
fichier_source: QRPGLESRC
membre: ANIMERPG
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 196
modifie: 2026-11-16
---

# BIB12/QRPGLESRC/ANIMERPG

```rpg
**free
ctl-opt dftactgrp(*no);
// declaration des fichiers
dcl-f anime workstn sfile(sfl1:rank);
dcl-f UNIlff usage(*input) keyed;
dcl-f PRSOlf usage(*input)keyed;

//declaration de variables globales
dcl-s chx    packed(4:0);
dcl-s rank  packed(4:0);

// traitement principal
dow not *in03;
    ecran1();
    chx = univchoice(animec);
    if chx = *zeros;
        chargeall();
    else;
        chargesfl(chx);
    endif;

    dow 1=1;
        exfmt ctl1;
        if *in12 or *in03;
            leave;
        endif;
    enddo;
enddo;
*INLR =*on;

// procedure d'affichage de l'écran 1
dcl-proc ecran1;
    Dow not *in03;
        exfmt fmt1;
        if *in03;
        endif;
        if animec <> *zeros;
            leave;
        endif;
    enddo;
end-proc;

// procedure de selection de l'univers
dcl-proc univchoice;
    dcl-pi *n packed(4:0);
        num  packed(2:0);
    end-pi;
    dcl-s nmunv packed(4:0);
    if num = 1;
        nmunv = 1;
    elseif num = 2;
        nmunv = 2;
    elseif num = 3;
        nmunv = 3;
    else;
        nmunv = *zeros;
    endif;
    return nmunv;
end-proc;

// initialisation du sfl
dcl-proc initsfl;
    dcl-pi *n ;
        ptr packed(4:0);
    end-pi;

    *in80 = *on;
    write ctl1;
    *in80 = *off;
    if ptr = 0;
        setll *loval PERSOFM;
    else;
        setll ptr PERSOFM;
    endif;
    rank = 0;
end-proc;

// chargement de la totalité des personnages
dcl-proc chargeall;
    dcl-s ssp packed(4:0) inz(0);
    initsfl(ssp);
    read PERSOFM;
    dow  not %EOF and rank<9998;
        rank+=1;
        w_uni = getuni(univers);
        w_temps = convTemps(TEMPS);
        write sfl1;
        read PERSOFM;
    enddo;

    if rank>0;
        *in83=*on;
    endif;
    *in81 = *on;
    *in82 = *on;
    NBPRESO = rank;
    write foot;

end-proc;

// chargement des personnages d'1 univer
dcl-proc chargesfl;

    dcl-pi *n ;
        filtre packed(4:0);
    end-pi;

    initsfl(filtre);

    reade filtre PERSOFM;
    dow   not %eof and rank <9998;
        rank+=1;
        w_uni=getuni(univers);
        w_temps = convTemps(TEMPS);
        write sfl1;
        reade filtre PERSOFM;
    enddo;

    if rank>0;
        *in83=*on;
    endif;
    *in81 = *on;
    *in82 = *on;
    NBPRESO=rank;
    write foot;
    WRITE CTL1;

end-proc;

// jointure du nom de l'univer avec son code
dcl-proc getuni;
    dcl-pi *n char(20);
        unicode packed(4:0);
    end-pi;

    chain unicode UNIFMT;
    if %found;
        return UNINAME;
    else;
        return *blank;
    endif;

end-proc;

dcl-proc convTemps;
    dcl-pi *n char(20);
        pmin packed(20:0);
    end-pi;

    dcl-s totalHours packed(15:0);
    dcl-s days       packed(10:0);
    dcl-s hours      packed(5:0);
    dcl-s mins       packed(5:0);
    dcl-s result     char(50) inz(*blanks);

    // Gestion du cas 0 ou négatif
    if pmin <= 0;
        return '0 min';
    endif;

    // Calculs des jours, heures et minutes
    totalHours = pmin / 60;
    mins       = %rem(pmin: 60);
    days       = totalHours / 24;
    hours      = %rem(totalHours: 24);

    // 1. Gestion des Jours
    if days > 0;
        result = %trim(%char(days)) + 'J';
    endif;

    // 2. Gestion des Heures
    if hours > 0;
        if result <> *blanks;
            // S'il reste des minutes, on met une virgule, sinon un "et"
            if mins > 0;
                result = %trim(result) + ',' + %trim(%char(hours)) + 'h';
            else;
                result = %trim(result) + ' et ' + %trim(%char(hours)) + 'h';
            endif;
        else;
            result = %trim(%char(hours)) + 'h';
        endif;
    endif;

    // 3. Gestion des Minutes
    if mins > 0;
        if result <> *blanks;
            result = %trim(result) + ' et ' + %trim(%char(mins)) + ' min';
        else;
            result = %trim(%char(mins)) + ' min';
        endif;
    endif;

    return result;
end-proc;
```
