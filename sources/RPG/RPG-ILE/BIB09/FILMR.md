---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: FILMR
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 143
modifie: 2026-11-16
---

# BIB09/QSOURCES/FILMR

```rpg
**free

ctl-opt option(*srcstmt:*nodebugio) dftactgrp(*no) actgrp(*new);

// Fichier écran avec sous-fichier
dcl-f FILMD workstn sfile(SFL1:RRN1) indds(Ind);

// Fichier physique FILM
dcl-f FILM disk usage(*update:*delete:*input) keyed;

// Constantes
dcl-c SFL_PAGE 14;
dcl-c SFL_MAX  9999;

// Variables
dcl-s rrn1    packed(4:0) inz(0);
dcl-s lstRrn  packed(4:0) inz(0);
dcl-s i       packed(4:0) inz(0);

// Renommage des indicateurs
dcl-ds Ind;
    Sortie     ind pos(3);   // F3
    Actualiser ind pos(5);   // F5
    Creation   ind pos(6);   // F6
    Annuler    ind pos(12);  // F12
    SflClr     ind pos(31);  // Clear SFL
    SflDsp     ind pos(32);  // Display SFL (N32 dans DSPF)
    Roll       ind pos(39);  // Page Down
    SflEnd     ind pos(90);  // Fin SFL
end-ds;

//=================================================================
// Programme principal
//=================================================================
exsr ClearSfl;
setll *loval FILM;
BuildSfl();

dou Sortie;
    rrn1 = 1;
    write BAS1;
    exfmt CTL1;

    select;
        when Sortie or Annuler;
            leave;

        when Roll;
            BuildSfl();

        when Actualiser;
            setll *loval FILM;
            exsr ClearSfl;
            BuildSfl();

        when Creation;
            snd-msg 'Création non implémentée';

        other;
            TrtReadc();
            setll *loval FILM;
            exsr ClearSfl;
            BuildSfl();
    endsl;
enddo;

*inlr = *on;

//=================================================================
// Sous-routine : Vider le sous-fichier
//=================================================================
begsr ClearSfl;
    rrn1   = *zero;
    lstRrn = *zero;
    SflClr = *on;
    write CTL1;
    SflClr = *off;
    SflDsp = *on;      // *on = masquer (car N32 dans DSPF)
    SflEnd = *off;
endsr;

//=================================================================
// Procédure : Charger le sous-fichier
//=================================================================
dcl-proc BuildSfl;

    rrn1 = lstRrn;

    for i = 1 to SFL_PAGE;
        read(n) FILM;

        if %eof;
            SflEnd = *on;
            leave;
        else;
            rrn1 += 1;
            OPT = *blanks;
            EIDFILM = IDFILM;
            ETITREFILM = TITREFILM;
            write SFL1;
        endif;
    endfor;

    if rrn1 > 0;
        SflDsp = *off;    // *off = afficher (car N32 dans DSPF)
    endif;

    lstRrn = rrn1;

end-proc;

//=================================================================
// Procédure : Traitement des lignes modifiées (READC)
//=================================================================
dcl-proc TrtReadc;

    readc SFL1;

    dow not %eof(FILMD);
        select;
            when OPT = '1';
                snd-msg 'Film sélectionné : ' + %trim(ETITREFILM);

            when OPT = '2';
                snd-msg 'Modification de : ' + %trim(ETITREFILM);

            when OPT = '4';
                chain EIDFILM FILM;
                if %found(FILM);
                    delete FILM;
                    snd-msg 'Film supprimé : ' + %trim(ETITREFILM);
                endif;

            when OPT = '5';
                snd-msg 'Affichage de : ' + %trim(ETITREFILM);
        endsl;

        OPT = *blanks;
        update SFL1;
        readc SFL1;
    enddo;

end-proc;
```
