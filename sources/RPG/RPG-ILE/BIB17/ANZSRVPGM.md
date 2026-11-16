---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: ANZSRVPGM
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 133
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/ANZSRVPGM

```rpg
**free
ctl-opt bnddir('BIB17/ANZBND') dftactgrp(*no) actgrp(*new);

/copy QCPYSRC,ANZSRVP

dcl-f ANZSRVPGMD workstn indds(indEcran) sfile(SFLPGM : rangPgm);

// Indicateurs de l'ecran
dcl-ds indEcran;
    f3           ind pos(3);
    f12          ind pos(12);
    err          ind pos(40);
    // sous-fichier pgmLie
    sflClr_PGM ind pos(50);
    sflDspCtl_PGM ind pos(51);
    sflDsp_PGM ind pos(52);
    sflEnd_PGM ind pos(53);
end-ds;

dcl-enum ecrans qualified;
    selection 'SELECTION';
    windowChoix 'WINDOWCHOIX';
end-enum;

dcl-s ecran char(15) inz(ecrans.selection);
dcl-s rangPgm packed(4:0);

dow not f3;
    select;
        when ecran = ecrans.selection;
            ecrSelection();
        when ecran = ecrans.windowChoix;
            openWindowChoix();
    endsl;
enddo;

*inlr = *on;

dcl-proc ecrSelection;
    ODLBNM = '*LIBL';
    exfmt fmt1;
    select;
        when f12;
            ODOBNM = *blanks;
            err = *off;
            ERMSG = *blanks;
            ecran = ecrans.selection;
        other;
            if checkExistance(ODOBNM:ODLBNM);
                err = *off;
                ERMSG = *blanks;
                ecran = ecrans.windowChoix;
            else;
                displayError('Objet non trouvé');
            endif;
    endsl;

end-proc;

dcl-proc openWindowChoix;
    exfmt WDW1;

    select;
        when f3;
        when f12;
            ecran = ecrans.selection;
        when WDWCHOICE = '1';
            ecrPgmLie();
        when WDWCHOICE = '2';
            // modules : écran à venir
        when WDWCHOICE = '3';
            // procédures exportées : écran à venir
        other;
            displayError('Aucune option valide sélectionnée');
    endsl;
end-proc;

dcl-proc displayError;
    dcl-pi *n ;
        msg varchar(70) const;
    end-pi;
    err = *on;
    ERMSG = msg;
    ecran = ecrans.selection;
end-proc;

dcl-proc ecrPgmLie;
    inzSflPgm();
    loadSflPgm();
    write FOOT;
    exfmt CTLPGM;

    select;
        when f3;
        when f12;
            ecran = ecrans.selection;
        other;
    endsl;
end-proc;

dcl-proc inzSflPgm;
    sflDspCtl_PGM = *off;
    sflDsp_PGM  = *off;
    sflEnd_PGM  = *off;
    sflClr_PGM  = *on;
    write CTLPGM;
    sflClr_PGM  = *off;
    rangPgm = 0;
end-proc;

dcl-proc loadSflPgm;
    dcl-ds ligne likeds(pgmLie_t);

    openPgmCursor(ODOBNM:ODLBNM);

    dow fetchPgm(ligne) and rangPgm < 9999;
        PGMNMLST = ligne.nom;
        LIBNMLST = ligne.biblio;
        SIGNLST = ligne.signature;

        rangPgm +=1;
        write SFLPGM;
    enddo;

    OBJNAM = ODOBNM;
    LIBNAM = ODLBNM;
    PGMNMB = rangPgm;

    sflDspCtl_PGM = *on;
    sflEnd_PGM = *on;
    sflDsp_PGM = rangPgm > 0;
    closePgmCursor();
end-proc;
```
