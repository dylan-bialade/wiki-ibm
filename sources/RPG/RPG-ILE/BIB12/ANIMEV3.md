---
bibliotheque: BIB12
fichier_source: QRPGLESRC
membre: ANIMEV3
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 496
modifie: 2026-11-16
---

# BIB12/QRPGLESRC/ANIMEV3

```rpg
**free
ctl-opt dftactgrp(*no)actgrp(*new);


// declaration des fichiers
dcl-f animesd workstn sfile(sfl1:w_cursor) sfile(ANICHOIX:F_CURSOR);
dcl-f mangas usage(*input) keyed prefix('V1_');
dcl-f unilf usage(*input) keyed prefix('V1_');
dcl-f mangas2 usage(*input) keyed prefix('V2_');
dcl-f unilf2 usage(*input) keyed prefix('V2_') rename(UNIVERSF:unifmt2);

//declaration de variables globales
dcl-s uniid packed(9:0);

dcl-S stop  packed(4:0);
dcl-S stop2  packed(4:0);

dcl-s PtrInd pointer inz(%addr(*in));

dcl-ds DS_Global based(PtrInd);
    EXIT ind pos(3);
    ANNULER ind pos(12);
    REFRESH ind pos(5);
    F10   ind pos(10);
    F22 ind pos(22);
    // sfl
    SFLCLR ind pos(80);
    SFLEND ind pos(81);
    CTLDSP ind pos(82);
    SFLDSP ind pos(83);
    ROLLUP ind pos(84);
    // anichoix
    WDWCLR ind pos(60);
    WDWEND ind pos(61);
    WDWCTLDSP ind pos(62);
    WDWDSP ind pos(63);
end-ds;

// process

*inlr = *on;

dou EXIT;
// affichage ecran 1
    exfmt fmt1;
    // sortie pgm
    if EXIT;
        leave;
    endif;
    // gestion F10
    if F10;
        f10select();
        iter;
    endif;
    //gestion F22
    if F22;
        F22select();
        iter;
    endif;
    if ANIMEC <> *zeros;
        uniid=ANIMEC;
        initsflv1();
        dou ANNULER or EXIT;
            ecran2();
        enddo;
    endif;
enddo;
///==========================================================
// Gestion Fichier Mangas

dcl-proc initsflv1;
    dcl-s cle packed(4:0) inz(0);
    cle=uniid;
    SFLDSP = *off;
    CTLDSP = *off;
    SFLCLR = *on;
    write ctl1;
    SFLCLR = *off;
    stop = 15;
    w_cursor = 0;
    if cle = -1;
        return;
    endif;
    if cle = 99;
        setll *loval mangas;
    else;
        setll cle mangas;
    endif;
    chargesfl();
end-proc;

dcl-proc chargesfl;
    dcl-s cle packed(4:0) inz(0);
    cle=uniid;
    if cle = 99;
        read mangas;
        dow  not %EOF and w_cursor < stop and w_cursor < 9998;
            w_cursor+=1;
            W_NOM = V1_NOM;
            W_PRENOM = V1_PRENOM;
            W_UNIPREV = V1_UNINAME;
            w_temps = convTemps(V1_TEMPS);
            write sfl1;
            if %rem(w_cursor:stop) = 0;
                leave;
            endif;
            read mangas;
        enddo;
    else;
        reade cle mangas;
        dow  not %eof and w_cursor < 9998;
            w_cursor+=1;
            W_NOM = V1_NOM;
            W_PRENOM = V1_PRENOM;

            W_UNIPREV = V1_UNINAME;
            w_temps = convTemps(V1_TEMPS);
            write sfl1;
            if %rem(w_cursor:stop) = 0;
                leave;
            endif;
            reade cle mangas;
        enddo;
    endif;
    if w_cursor > 0;
        SFLDSP=*on;
    else;
        SFLDSP = *off;
    endif;
    if %eof(mangas);
        SFLEND = *on;
    else;
        SFLEND = *off;
    endif;
    CTLDSP = *on;
    NBPRESO = w_cursor;
    write foot;

end-proc;


dcl-proc ecran2;
    dcl-pi *n ;
    end-pi;
    exfmt ctl1;
    if ANNULER or EXIT;
        return;
    elseif REFRESH;
        initsflv1();
    elseif ROLLUP and not %eof(mangas);
        stop+=15;
        chargesfl();
    // elseif F10;
        // F10select();
    endif;
end-proc;


// proc fcts
dcl-proc F10select;
    dcl-s cle packed(4:0);
    initwv1();
    dou ANNULER or EXIT;
        exfmt ctl2;

        if ANNULER or EXIT;
            leave;
        endif;

        if ROLLUP and not %eof(unilf);
            stop2+=10;
            chargewv1();
            iter;
        endif;
        if F_FILTRE <> *blank;
            initwv1();
            iter;
        endif;

        readc ANICHOIX;
        if %eof;
            iter;
        else;
            uniid = -1;
            initsflv1();

            dow not %eof;
                cle = F_UNICDE;
                uniid = F_UNICDE;
                setll cle mangas;
                chargesfl();
                dou ANNULER or EXIT;
                    ecran2();
                    if %eof(mangas);
                        leave;
                    endif;
                enddo;
                F_OPT = *blank;
                update ANICHOIX;
                readc ANICHOIX;
            enddo;
            ecran2();
            leave;
        endif;
    enddo;
end-proc;

dcl-proc initwv1;
    dcl-s filtre char(20) inz(*loval);
    //init
    WDWCTLDSP = *off;
    WDWEND = *off;
    WDWDSP =*off;
    WDWCLR = *on;
    write ctl2;
    WDWCLR = *off;
    if f_filtre <>*blank;
        filtre = f_filtre;
    endif;
    setll filtre unilf;
    F_CURSOR = 0;
    stop2 = 10;
    chargewv1();
end-proc;

dcl-proc chargewv1;
    read unilf;
    dow not %eof(unilf) and F_CURSOR<stop2 and F_CURSOR<9998;
        F_CURSOR+=1;
        F_UNICDE =V1_UNIVER;
        f_uni1 = V1_UNINAME;
        write ANICHOIX;
        if %rem(F_CURSOR:stop2) = 0;
            leave;
        endif;
        read unilf;
    enddo;

     // ctrl before dspl
    if F_CURSOR>0;
        WDWDSP=*on;
    else;
        WDWDSP = *off;
    endif;
    if %eof(unilf);
        WDWEND = *on;
    else;
        WDWEND = *off;
    endif;
    WDWCTLDSP = *on;
    write ctl2;
end-proc;




///==========================================================
// Gestion fichier Mangas2


dcl-proc initsflv2;
    dcl-s cle packed(9:0) inz(0);
    cle=uniid;
    SFLDSP = *off;
    CTLDSP = *off;
    SFLCLR = *on;
    write ctl1;
    SFLCLR = *off;
    stop = 15;
    w_cursor = 0;
    if cle = -1;
        return;
    endif;
    if cle = 99;
        setll *loval mangas2;
    else;
        setll cle mangas2;
    endif;
    chargesflv2();
end-proc;

dcl-proc chargesflv2;
    dcl-s cle packed(9:0) inz(0);
    cle=uniid;
    if cle = 99;
        read mangas2;
        dow  not %EOF and w_cursor < stop and w_cursor < 9998;
            w_cursor+=1;
            W_NOM = V2_NOM;
            W_PRENOM = V2_PRENOM;
            W_UNIPREV =%subst(V2_UNINAME:1:20);
            W_UNI = V2_UNINAME;
            w_temps = convTemps(V2_TEMPS);
            write sfl1;
            if %rem(w_cursor:stop) = 0;
                leave;
            endif;
            read mangas2;
        enddo;
    else;
        reade cle mangas2;
        dow  not %eof and w_cursor < 9998;
            w_cursor+=1;
            W_NOM = V2_NOM;
            W_PRENOM = V2_PRENOM;
            W_UNIPREV =%subst(V2_UNINAME:1:20);
            W_UNI = V2_UNINAME;
            w_temps = convTemps(V2_TEMPS);
            write sfl1;
            if %rem(w_cursor:stop) = 0;
                leave;
            endif;
            reade cle mangas2;
        enddo;
    endif;
    if w_cursor > 0;
        SFLDSP=*on;
    else;
        SFLDSP = *off;
    endif;
    if %eof(mangas2);
        SFLEND = *on;
    else;
        SFLEND = *off;
    endif;
    CTLDSP = *on;
    NBPRESO = w_cursor;
    write foot;

end-proc;


dcl-proc ecran22;
    exfmt ctl1;
    if ANNULER or EXIT;
        return;
    elseif REFRESH;
        initsflv2();
    elseif ROLLUP and not %eof(mangas2);
        stop+=15;
        chargesflv2();
    // elseif F10;
        // F10select();
    endif;
end-proc;


// proc fcts
dcl-proc F22select;
    initwv2();
    dou ANNULER or EXIT;
        exfmt ctl2;

        if ANNULER or EXIT;
            leave;
        endif;

        if ROLLUP and not %eof(unilf);
            stop2+=12;
            chargewv2();
            iter;
        endif;
        if F_FILTRE <> *blank;
            initwv2();
            iter;
        endif;

        readc ANICHOIX;
        if %eof;
            iter;
        else;
            uniid = -1;
            initsflv2();

            dow not %eof;
                uniid = F_UNICDE;
                setll uniid mangas2;
                chargesflv2();
                dou ANNULER or EXIT;
                    ecran22();
                    if %eof(mangas2);
                        leave;
                    endif;
                enddo;
                F_OPT = *blank;
                update ANICHOIX;
                readc ANICHOIX;
            enddo;
            ecran2();
            leave;
        endif;
    enddo;
end-proc;

dcl-proc initwv2;
    dcl-s filtre char(100)inz(*loval);
    //init
    WDWCTLDSP = *off;
    WDWEND = *off;
    WDWDSP =*off;
    WDWCLR = *on;
    write ctl2;
    WDWCLR = *off;
    if f_filtre <>*blank;
        filtre = f_filtre;
    endif;
    setll filtre unilf2;
    F_CURSOR = 0;
    stop2 = 12;
    chargewv2();
end-proc;

dcl-proc chargewv2;
    read unilf2;
    dow not %eof(unilf2) and F_CURSOR<stop2 and F_CURSOR<9998;
        F_CURSOR+=1;
        F_UNICDE = V2_UNIVER;
        f_uni1 = %subst(V2_UNINAME:1:37);
        f_uni2 = %subst(V2_UNINAME:37:37);
        f_uni3 = %subst(V2_UNINAME:74:26);
        write ANICHOIX;
        if %rem(F_CURSOR:stop2) = 0;
            leave;
        endif;
        read unilf2;
    enddo;

     // ctrl before dspl
    if F_CURSOR>0;
        WDWDSP=*on;
    else;
        WDWDSP = *off;
    endif;
    if %eof(unilf2);
        WDWEND = *on;
    else;
        WDWEND = *off;
    endif;
    WDWCTLDSP = *on;
end-proc;

///==========================================================
// proc commun

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
