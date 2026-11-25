---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: TESTCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 11
modifie: 2026-11-25
---

# BIB27/QCLSRC/TESTCL

```cl
             PGM
             DCLF       FILE(TEST_01)
             DOWHILE    COND(&IN03 *EQ '0')
 BOUCLE:     SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN50) THEN(DO)
             CHGVAR     VAR(&USRNAME) VALUE('léo')
             SNDRCVF    RCDFMT(FMT1)
             GOTO       CMDLBL(BOUCLE)
             ENDDO
             ENDDO
             ENDPGM
```
