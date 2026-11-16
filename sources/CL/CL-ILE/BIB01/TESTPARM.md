---
bibliotheque: BIB01
fichier_source: QCLLESRC
membre: TESTPARM
type: CL/CL-ILE
longueur_enregistrement: 100
lignes: 9
modifie: 2026-11-16
---

# BIB01/QCLLESRC/TESTPARM

```cl
             PGM        PARM(&PARM1)
             DCL        VAR(&PARM1) TYPE(*CHAR) LEN(10)
             DCL        VAR(&VALEUR) TYPE(*CHAR) LEN(10)
             CHGVAR     VAR(&VALEUR) VALUE(&PARM1)
             MONMSG     MSGID(MCH3601) EXEC(CHGVAR VAR(&VALEUR) +
                          VALUE('*AUCUN'))

             SNDPGMMSG  MSG(&VALEUR)
             ENDPGM
```
