---
bibliotheque: BIB05
fichier_source: QCLPSRC
membre: ANNUAIRE
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 14
modifie: 2026-11-16
---

# BIB05/QCLPSRC/ANNUAIRE

```cl
 PGM
              DCLF       FILE(BIB05/ANNUAIRE1)
 DEBUT:      SNDRCVF    RCDFMT(FMT1)
             CHGVAR VAR(&IN55) VALUE('0')
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             RTVUSRPRF  USRPRF(&USER) INLPGM(&INLPGM) OUTQ(&OUTQ) +
                          CURLIB(&CURLIB) CCSID(&CCSID)
             QSYS/MONMSG MSGID(CPF0000) EXEC(CHGVAR VAR(&IN55) +
                          VALUE('1'))
             IF         COND(&IN55 *EQ '1') THEN(GOTO CMDLBL(DEBUT))
             SNDRCVF    RCDFMT(FMT2)
             GOTO       CMDLBL(DEBUT)
             RCVF
FIN: ENDPGM
```
