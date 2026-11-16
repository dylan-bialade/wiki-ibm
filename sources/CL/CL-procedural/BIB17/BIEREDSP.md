---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: BIEREDSP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 28
modifie: 2026-11-16
---

# BIB17/QCLPSRC/BIEREDSP

```cl
             PGM
             DCLF       FILE(BEERD2)
             DCLF       FILE(BIERE) OPNID(B)
             DCL        VAR(&COUNT) TYPE(*DEC) LEN(5 0) VALUE(0)
 /*VARIABLE ALPHA POUR AFFICHAGE */
             DCL        VAR(&CCOUNT) TYPE(*CHAR) LEN(5)

 LECT:       RCVF       OPNID(B)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FINLECT))
             CHGVAR     VAR(&COUNT)  VALUE(&COUNT + 1)
             CHGVAR     VAR(&PRNOPR) VALUE(&B_PRNOPR)
             CHGVAR     VAR(&PRIDPR) VALUE(&B_PRIDPR)
             CHGVAR     VAR(&PRREPR) VALUE(&B_PRREPR)
             SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FINLECT))
             IF         COND(&IN12 *EQ '1') THEN(DO)
             CLOSE      OPNID(B)
             CHGVAR     VAR(&COUNT) VALUE(0)
             ENDDO
             GOTO       CMDLBL(LECT)




 FINLECT:    CHGVAR     VAR(&CCOUNT) VALUE(&COUNT)
             SNDPGMMSG  MSG('Fin d affichage des' *BCAT &CCOUNT +
                          *BCAT 'résultats')
 END:        ENDPGM
```
