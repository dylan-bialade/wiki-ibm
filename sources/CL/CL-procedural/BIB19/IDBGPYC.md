---
bibliotheque: BIB19
fichier_source: QCLSRC
membre: IDBGPYC
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 43
modifie: 2026-11-16
---

# BIB19/QCLSRC/IDBGPYC

```cl
/* ----------------------------------------------------------------------- */
/* IDBGPYC - travail IDBGPY : lance le processus Python de BIB19         */
/* Licence MIT        */
/* ----------------------------------------------------------------------- */
             PGM        PARM(&KEY &JNAME &JUSER &NBR &LIB)
             DCL        VAR(&KEY)    TYPE(*CHAR) LEN(16)
             DCL        VAR(&JNAME)  TYPE(*CHAR) LEN(10)
             DCL        VAR(&JUSER)  TYPE(*CHAR) LEN(10)
             DCL        VAR(&NBR)    TYPE(*CHAR) LEN(6)
             DCL        VAR(&LIB)    TYPE(*CHAR) LEN(10)
             DCL        VAR(&CFG)    TYPE(*CHAR) LEN(512)
             DCL        VAR(&PYEXE)  TYPE(*CHAR) LEN(128)
             DCL        VAR(&APPDIR) TYPE(*CHAR) LEN(128)
             DCL        VAR(&NUL)    TYPE(*CHAR) LEN(1) VALUE(X'00')
             DCL        VAR(&A0)     TYPE(*CHAR) LEN(129)
             DCL        VAR(&A1)     TYPE(*CHAR) LEN(160)
             DCL        VAR(&A2)     TYPE(*CHAR) LEN(17)
             DCL        VAR(&A3)     TYPE(*CHAR) LEN(29)
             DCL        VAR(&A4)     TYPE(*CHAR) LEN(11)
             DCL        VAR(&A5)     TYPE(*CHAR) LEN(29)
             DCL        VAR(&MJOB)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&MUSR)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&MNBR)   TYPE(*CHAR) LEN(6)

             RTVDTAARA  DTAARA(&LIB/IDBGCFG) RTNVAR(&CFG)
             CHGVAR     VAR(&PYEXE)  VALUE(%SST(&CFG 1 128))
             CHGVAR     VAR(&APPDIR) VALUE(%SST(&CFG 129 128))
             CHGVAR     VAR(&A0) VALUE(&PYEXE *TCAT &NUL)
             CHGVAR     VAR(&A1) VALUE(&APPDIR *TCAT '/stridbg_main.py' +
                          *TCAT &NUL)
             CHGVAR     VAR(&A2) VALUE(&KEY *TCAT &NUL)
             CHGVAR     VAR(&A3) VALUE(&NBR *TCAT '/' *TCAT &JUSER *TCAT +
                          '/' *TCAT &JNAME *TCAT &NUL)
             CHGVAR     VAR(&A4) VALUE(&LIB *TCAT &NUL)
             RTVJOBA    JOB(&MJOB) USER(&MUSR) NBR(&MNBR)
             CHGVAR     VAR(&A5) VALUE(&MNBR *TCAT '/' *TCAT &MUSR *TCAT +
                          '/' *TCAT &MJOB *TCAT &NUL)
             ADDENVVAR  ENVVAR(PYTHONIOENCODING) VALUE('utf-8') +
                          REPLACE(*YES)
             ADDENVVAR  ENVVAR(PYTHONDONTWRITEBYTECODE) VALUE('1') +
                          REPLACE(*YES)
             CALL       PGM(QP2SHELL) PARM(&A0 &A1 &A2 &A3 &A4 &A5)
             ENDPGM
```
