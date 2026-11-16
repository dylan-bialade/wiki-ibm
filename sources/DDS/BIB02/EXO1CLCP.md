---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: EXO1CLCP
type: DDS
longueur_enregistrement: 100
lignes: 16
modifie: 2026-11-16
---

# BIB02/QDDSRC/EXO1CLCP

```text
             PGM
             DCLF       FILE(RACES/RACEP) OPNID(R)
             DCLF       FILE(BORG/PGM2D)

  BOUCLE:    RCVF       RCDFMT(RACEFMT) OPNID(R)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))

             CHGVAR     VAR(&NORACE) VALUE(&R_NORACE)
             CHGVAR     VAR(&NMRACE) VALUE(&R_NMRACE)
             CHGVAR     VAR(&T1RACE) VALUE(&R_T1RACE)

             SNDRCVF    RCDFMT(ECR1)
             IF         COND(&IN03) THEN(GOTO CMDLBL(FIN))
             GOTO       CMDLBL(BOUCLE)

FIN:         ENDPGM
```
