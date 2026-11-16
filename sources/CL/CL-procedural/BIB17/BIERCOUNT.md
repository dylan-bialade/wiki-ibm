---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: BIERCOUNT
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 17
modifie: 2026-11-16
---

# BIB17/QCLPSRC/BIERCOUNT

```cl
             PGM
             DCLF       FILE(BIERE) OPNID(B)
             DCL        VAR(&COUNT) TYPE(*DEC) LEN(7 0) VALUE(0)
 /*VARIABLE ALPHA POUR AFFICHAGE */
             DCL        VAR(&CCOUNT) TYPE(*CHAR) LEN(7)

 LECT:       RCVF       OPNID(B)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FINLECT))
             CHGVAR     VAR(&COUNT)  VALUE(&COUNT + 1)
             GOTO       CMDLBL(LECT)


 FINLECT:    CHGVAR     VAR(&CCOUNT) VALUE(&COUNT)
             DSPFFD FILE(BIERE) OUTPUT(*PRINT)
             SNDPGMMSG  MSG('Fin d affichage des' *BCAT &CCOUNT +
                          *BCAT 'BIERES')
 END:        ENDPGM
```
