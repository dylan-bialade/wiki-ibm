---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: CL_SF
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 31
modifie: 2026-11-25
---

# BIB27/QCLSRC/CL_SF

```cl
             PGM

             DCLF       FILE(BIB27/CTL_PLANET)
             DCL        VAR(&MOON) TYPE(*CHAR) LEN(10) VALUE('LUNES')
             DCL        VAR(&PLANETE) TYPE(*CHAR) LEN(10) +
                          VALUE('PLANETS')
             DCL        VAR(&STATUT) TYPE(*CHAR) LEN(1) VALUE(' ')

             ADDLIBLE   LIB(BIB27)
             MONMSG     MSGID(CPF0000)


 BOUCLE:     CHGVAR     VAR(&OPT_P) VALUE(' ')
             CHGVAR     VAR(&OPT_L) VALUE(' ')
             SNDRCVF    RCDFMT(W1)
             CHGVAR     VAR(&STATUT) VALUE(' ')
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))

             IF         COND(&OPT_P *EQ '1') THEN(DO)
             CALL       PGM(PLANETE) PARM((&PLANETE) (&STATUT))
             ENDDO

             IF         COND(&OPT_L *EQ '1') THEN(DO)
             CALL       PGM(PLANETE) PARM((&MOON) (&STATUT))
             ENDDO

             IF         COND(&STATUT *EQ '1') THEN(DO)
             GOTO       CMDLBL(BOUCLE)
             ENDDO

 FIN:        ENDPGM
```
