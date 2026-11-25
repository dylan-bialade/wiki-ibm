---
bibliotheque: BIB25
fichier_source: QMODSRC
membre: MODAPI
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 61
modifie: 2026-11-25
---

# BIB25/QMODSRC/MODAPI

```rpg
**free

CTL-OPT NOMAIN copyright('(C) ORGFORM 2025.') DATFMT(*ISO);
// Lien des API IBM i (ordre alpha)
// https://www.ibm.com/docs/en/i/7.3.0?topic=interfaces-alphabetic-list-apis
// API finder d'IBM
// https://www.ibm.com/docs/en/i/7.3.0?topic=interfaces-api-finder


// Prototypes QCMDEXEC
dcl-pr QCMDEXC extpgm('QCMDEXC');
  cmd   char(500) const;
  len   packed(15:5) const;
end-pr;

// Procédure QCMDEXEC
DCL-PROC DescriptionFile EXPORT;
    DCL-PI *N;
        file char(10);
        bib char(10);
        msg char(40);
    END-PI;

    DCL-S cmd char(500);
    DCL-S len packed(15:5);

    cmd = 'DSPFD FILE(' + %trim(bib) + '/' + %trim(file) + ')' +
           ' TYPE(*BASATR) OUTPUT(*OUTFILE) OUTFILE(QTEMP/DSPFD)';

    len = %len(%trim(cmd));

    monitor;
      CALLP QCMDEXC(cmd:len);
    on-error;
      msg = 'Erreur dans la commande';
    endmon;

    return;
END-PROC;


DCL-PROC DisplayPFM EXPORT;
  DCL-PI *N;
    file char(10);
    bib char(10);
    msg char(40);
  END-PI;
  DCL-S cmd char(500);
  DCL-S len packed(15:5);

  cmd = 'DSPPFM FILE(' + %trim(bib) + '/' + %trim(file) + ')';
  len = %len(%trim(cmd));

  monitor;
    CALLP QCMDEXC(cmd:len);
  on-error;
    msg = 'Erreur dans la commande';
  endmon;

  return;
END-PROC;
```
