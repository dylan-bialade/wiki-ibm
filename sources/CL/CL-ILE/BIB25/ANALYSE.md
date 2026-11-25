---
bibliotheque: BIB25
fichier_source: QCLLESRC
membre: ANALYSE
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 23
modifie: 2026-11-25
---

# BIB25/QCLLESRC/ANALYSE

```cl
             PGM

             DCLF       FILE(BIB27/SALESFILE)

/* Création Bibliotèque                                              */
             CRTLIB     LIB(ANLYSISBIB) TYPE(*PROD) +
                          TEXT('bibliothèque d''analyse')
             MONMSG     MSGID(CPF2111)

/* Copie du fichier dans la bib d'analyse                           */
             CPYF       FROMFILE(BIB27/SALESFILE) +
                          TOFILE(ANLYSISBIB/SALESDATA) +
                          MBROPT(*REPLACE) CRTFILE(*YES)

/* Création fichier d'analyse                                       */
             CRTPF      FILE(ANLYSISBIB/SALESANA) +
                          SRCFILE(BIB27/QCLSRC) SRCMBR(PF_ANA)
             MONMSG     MSGID(CPF7302)
             CLRPFM     FILE(ANLYSISBIB/SALESANA)



             ENDPGM
```
