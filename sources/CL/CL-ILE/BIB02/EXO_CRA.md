---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: EXO_CRA
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 34
modifie: 2026-11-16
---

# BIB02/QCLLESRC/EXO_CRA

```cl
             PGM        PARM(&LIB)
             COPYRIGHT  TEXT('(C) ORGFORM 2023.')
             DCLPRCOPT  USRPRF(*OWNER) DFTACTGRP(*NO) ACTGRP(*CALLER)


             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)

             CHGCURLIB  CURLIB(&LIB)
             MONMSG     MSGID(CPF2110)

             CRTSRCPF   FILE(*CURLIB/QRPGLESRC)
             MONMSG     MSGID(CPF0000)

             CPYSRCF    FROMFILE(WEBSRV/QRPGLESRC) +
                          TOFILE(*CURLIB/QRPGLESRC) FROMMBR(SCHTROUMWS) +
                          TOMBR(*FROMMBR)

             CPYSRCF    FROMFILE(WEBSRV/QRPGLESRC) +
                          TOFILE(*CURLIB/QRPGLESRC) FROMMBR(CHK_SCHTRO) +
                          TOMBR(*FROMMBR)

             CRTDUPOBJ  OBJ(CLIENT) FROMLIB(WEBSRV) OBJTYPE(*FILE) +
                          TOLIB(*CURLIB) DATA(*YES) CST(*NO) TRG(*NO)
             MONMSG     MSGID(CPF0000)

             CPYSRCF    FROMFILE(*CURLIB/QRPGLESRC) +
                          TOFILE(*CURLIB/QRPGLESRC) FROMMBR(SCHTROUMWS) +
                          TOMBR(CRAARMONWS)

             CPYSRCF    FROMFILE(*CURLIB/QRPGLESRC) +
                          TOFILE(*CURLIB/QRPGLESRC) FROMMBR(CHK_SCHTRO) +
                          TOMBR(CHK_CRAARM)

             ENDPGM
```
