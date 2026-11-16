---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: EXO1CL3
type: DDS
longueur_enregistrement: 100
lignes: 21
modifie: 2026-11-16
---

# BIB02/QDDSRC/EXO1CL3

```text
             PGM
             DCLF       FILE(BIB02/RACEP) OPNID(R)
             DCLF       FILE(BIB02/PG3M3)

             SNDRCVF    RCDFMT(FMT5)

  BOUCLE:    RCVF       RCDFMT(RACEFMT)    OPNID(R)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))
             IF         COND(&TPRACE *NE &R_TPRACE)
             SNDRCVF    RCDFMT(FMT5)

             IF         COND(&TPRACE *EQ &R_TPRACE) THEN(DO)
             CHGVAR     VAR(&NORACE) VALUE(&R_NORACE)
             CHGVAR     VAR(&NMRACE) VALUE(&R_NMRACE)
             CHGVAR     VAR(&T1RACE) VALUE(&R_T1RACE)
             SNDRCVF    RCDFMT(FMT6)
             ENDDO
             IF         COND(&IN03) THEN(GOTO CMDLBL(FIN))
             GOTO       CMDLBL(BOUCLE)

FIN:         ENDPGM
```
