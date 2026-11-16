---
bibliotheque: BIB12
fichier_source: QRPGLESRC
membre: ANIMEV4
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 413
modifie: 2026-11-16
---

# BIB12/QRPGLESRC/ANIMEV4

```rpg
**free
ctl-opt dftactgrp(*no) actgrp(*new);

// declaration des fichiers
dcl-f animesd workstn sfile(sfl1:w_cursor) sfile(ANICHOIX:F_CURSOR);
dcl-f aniprt printer oflind(OVF)usropn;

// declaration variables
dcl-ds univers qualified;
    unicode packed(9:0);
    uniname char(100);
end-ds;

dcl-ds perso qualified;
    nom char(15);
    prenom char(15);
    uniname like(univers.uniname);
    temps packed(20:0);
end-ds;

dcl-S stop  packed(4:0);
dcl-S stop2  packed(4:0);
dcl-s uniid packed(9:0);
dcl-s unilst packed(9:0) dim(100);
dcl-s unilen packed(3:0) inz(0);

dcl-s PtrInd pointer inz(%addr(*in));
dcl-ds DS_Global based(PtrInd);
    EXIT ind pos(3);
    ANNULER ind pos(12);
    REFRESH ind pos(5);
    F10   ind pos(10);
    F22 ind pos(22);
    F8  ind pos(08);
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
// printer
    OVF    ind pos(99);
end-ds;



dcl-s unireq char(500);
dcl-s persoreq char(500);

exec sql set option commit = *none;


exec sql declare C1 cursor for unistm;
exec sql declare C2 cursor for persostm;


*inlr=*on;
dou EXIT;
// affichage ecran 1
    exfmt fmt1;
// sortie pgm
    if EXIT;
        leave;
    endif;
// gestion F10 F22
    if F10 or F22;
        f10select();
        iter;
    endif;
    if ANIMEC <> *zeros;
        uniid=ANIMEC;
        initsfl();
        ecran2();
    endif;
enddo;

// ecran2
dcl-proc ecran2;

    dou ANNULER or EXIT;

        exfmt ctl1;

        if ANNULER or EXIT;
            unilen = 0;
            unilst(*)=*zeros;
            return;

        elseif REFRESH;
            unilen = 0;
            reset unilst;
            initsfl();

        elseif ROLLUP;
            chargesfl();

        elseif F10 or F22;
            f10select();

        elseif F8;
            print();
        endif;

    enddo;
end-proc;


///==========================================
// processing
dcl-proc initsfl;
    SFLDSP = *off;
    CTLDSP = *off;
    SFLCLR = *on;
    write ctl1;
    SFLCLR = *off;
    stop = 15;
    w_cursor = 0;
    chargesfl();
end-proc;

dcl-proc chargesfl;
    dcl-s i packed(4:0)inz(0);

    if F22;  // chargement personnage universV2
        c2format('ANIME.PERSOV2':'ANIME.UNIVERSV2');
        exec sql open c2 using:W_CURSOR;

    else; // chargement personnage universV1
        if uniid = 99; // si wselectioné tout
            persoreq = 'SELECT nom, prenom, uniname, temps FROM BIB12.PERSO m JOIN ' +
            'BIB12.UNIVERS u ON m.univers = u.univer  offset ? rows';
            exec sql prepare persostm from :persoreq;
            exec sql open C2 using :W_CURSOR;
        else;
            if unilen=0; // si selection depuis ecran1;
                unilen=1;
                unilst(1)= uniid;
            endif;
            c2format('BIB12.PERSO':'BIB12.UNIVERS');
            exec sql open C2 using :W_CURSOR;
        endif;
    endif;

    // lecture du curseur et ecriture dans le sfl
    dow sqlcode = 0 and i<stop;
        exec sql fetch next from c2 into :perso;
        if sqlcode = 0;
            W_CURSOR+=1;
            i+=1;
            W_NOM=perso.nom;
            W_PRENOM=perso.prenom;
            W_UNIPREV=perso.uniname;
            W_UNI=perso.uniname;
            W_TEMPS = convTemps(perso.temps);
            write sfl1;
        endif;
        if sqlcode = 100;
            SFLEND=*on;
        else;
            SFLEND=*off;
        endif;
    enddo;

    exec sql close c2;
    // gestion affichage sfl
    if w_cursor > 0;
        SFLDSP=*on;
    else;
        SFLDSP = *off;
    endif;
    CTLDSP = *on;
    NBPRESO = w_cursor;
    write foot;

end-proc;

// format cursor for c2 affichage personnages
dcl-proc c2format;
    dcl-pi *n ;
        table varchar(21)value;
        joint varchar(21)value;
    end-pi;

    dcl-s i packed(4:0);
    dcl-s list varchar(100);

    list = '';
    if unilen=0;
        list += %char(unilst(unilen));
    else;
        for i = 1 to unilen-1;
            list += %char(unilst(i)) +', ';
        endfor;
        list += %char(unilst(unilen));
    endif;
    // création de la requete
    persoreq = 'SELECT nom, prenom, uniname, temps FROM '+table+' m JOIN ' +
                joint + ' u ON m.univers = u.univer WHERE univer in ('+list+
                ') offset ? rows';
    exec sql prepare persostm from :persoreq;
end-proc;

// proc fcts
dcl-proc F10select;
    initwdw();
    dou ANNULER or EXIT;
        unilen = 0;
        exfmt ctl2;

        if ANNULER or EXIT;
            leave;
        endif;

        if ROLLUP;
            chargewdw();
            iter;
        endif;
        if F_FILTRE <> *blank;
            initwdw();
            iter;
        endif;
        readc ANICHOIX;
        dow not %eof;
            unilen+=1;
            unilst(unilen)=F_UNICDE;
            F_OPT = *blank;
            update ANICHOIX;
            readc ANICHOIX;
        enddo;
        if %eof;
            initsfl();
            ecran2();
            leave;
        endif;
    enddo;
end-proc;

dcl-proc initwdw;
//init
    WDWCTLDSP = *off;
    WDWEND = *off;
    WDWDSP =*off;
    WDWCLR = *on;
    write ctl2;
    WDWCLR = *off;
    F_CURSOR = 0;
    stop2 = 13;
    chargewdw();
end-proc;

dcl-proc c1format;
    dcl-pi *n ;
        table varchar(21)value;
        where ind value;
    end-pi;
    if where;
        unireq = 'SELECT univer, uniname from '+table+
                ' where uniname like ?  OFFSET ? rows';
    else;
        unireq = 'SELECT univer, uniname from '+table+' OFFSET ? rows';
    endif;
    exec sql prepare unistm from :unireq;
end-proc;

dcl-proc chargewdw;
    dcl-s i packed(4:0) inz(1);
    dcl-s filtre varchar(25);
    if F22;
        if F_FILTRE = *blanks;
            c1format('ANIME.UNIVERSV2':*off);
            exec sql open C1 using :F_CURSOR;
        else;
            c1format('ANIME.UNIVERSV2':*on);
            filtre = %trim(F_FILTRE) +'%' ;
            exec sql open C1 using :filtre, :F_CURSOR;
        endif;
    else;
        if F_FILTRE = *blanks;
            c1format('ANIME.UNIVERS':*off);
            exec sql open C1 using :F_CURSOR;
        else;
            c1format('ANIME.UNIVERS':*on);
            filtre = %trim(F_FILTRE) +'%' ;
            exec sql open C1 using :filtre, :F_CURSOR;
        endif;
    endif;

    dow sqlcode = 0 and i < stop2;
        exec sql fetch next from C1 into :univers;
        if sqlcode=0;
            F_CURSOR+=1;
            i+=1;
            F_UNICDE =univers.unicode;
            F_uni1 =univers.uniname;
            write ANICHOIX;
        endif;
        if sqlcode = 100;
            WDWEND=*on;
        else;
            WDWEND=*off;
        endif;
    enddo;
    exec sql close c1;
// ctrl before dspl
    if F_CURSOR>0;
        WDWDSP=*on;
    else;
        WDWDSP = *off;
    endif;
    WDWCTLDSP = *on;
end-proc;

//==========================================================
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


dcl-proc print;
    dcl-pi *n ;
    end-pi;
    dcl-s start packed(4:0) inz(0);
    if not %open(aniprt);
        open aniprt;
    endif;
    write HDRREC;
    write HDRREC;
    write space2;
    write COLHDR;
    write COLHDR;
    write space1;
    write sep;
    write space1;
    exec sql open C2 using :start;
    dow sqlcode =0;
        exec sql fetch c2 into :perso;
        if sqlcode =0;
            P_NOM=perso.nom;
            P_PRENOM=perso.prenom;
            P_UNIVERS=perso.uniname;
            P_TEMPS=convTemps(perso.temps);
            if OVF;
                write HDRREC;
                write HDRREC;
                write space2;
                write COLHDR;
                write COLHDR;
                write space1;
                write sep;
                write space1;
                OVF=*off;
            endif;
            write DETAIL;
        endif;
    enddo;
    close aniprt;
end-proc;
```
