---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: COMPILEPF
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 18
modifie: 2026-11-16
---

# BIB02/QCLLESRC/COMPILEPF

```cl
             PGM        PARM(&LIB &PF)
             COPYRIGHT  TEXT('(C) ORGFORM 2023.')
             DCLPRCOPT  USRPRF(*OWNER) DFTACTGRP(*NO) ACTGRP(*CALLER)

             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PF)  TYPE(*CHAR) LEN(10)

             CLRPFM     FILE(QTEMP/REFPFPFM)
             MONMSG     MSGID(CPF3142)
             DSPPGMREF  PGM(*ALLUSR/*ALL) OUTPUT(*OUTFILE) OBJTYPE(*ALL) +
                          OUTFILE(QTEMP/REFPFPFM)
             RUNSQL     SQL('select WHLIB, WHPNAM, WHRFNM, WHOTYP from  +
                          tools.outfileref where WHFNAM = ''ENTREPOT'' and +
                          WHLNAM = ''BIB02'';')
             DOUNTIL    COND(&MSGID *EQ ' ')

             ENDDO
             ENDPGM
```
