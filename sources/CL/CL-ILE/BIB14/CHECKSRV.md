---
bibliotheque: BIB14
fichier_source: QCLLESRC
membre: CHECKSRV
type: CL/CL-ILE
longueur_enregistrement: 100
lignes: 12
modifie: 2026-11-16
---

# BIB14/QCLLESRC/CHECKSRV

```cl
             PGM        PARM(&LIB &PGM &EXIST)
             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PGM) TYPE(*CHAR) LEN(10)
             DCL        VAR(&EXIST) TYPE(*LGL)
             /* verrification de l'existance d'un srvpgm */
             CHGVAR     VAR(&EXIST) VALUE('1')
             CHKOBJ     OBJ(&LIB/&PGM) OBJTYPE(*SRVPGM)
             MONMSG     MSGID(CPF9801 CPF9810) EXEC(CHGVAR +
                          VAR(&EXIST) VALUE('0'))
             IF         COND(&EXIST = '1') THEN(RTVOBJD +
                          OBJ(&LIB/&PGM) OBJTYPE(*SRVPGM) RTNLIB(&LIB))
             ENDPGM
```
