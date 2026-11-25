---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: POKETP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 24
modifie: 2026-11-25
---

# BIB27/QCLSRC/POKETP

```cl
             PGM
             DCLF       FILE(POKEMON1G) RCDFMT(*ALL) OPNID(F) +
                          ALWVARLEN(*YES)
             DCLF       FILE(POKEMON)
             DOWHILE    COND(&IN03 *EQ '0')
LIRE:        RCVF       RCDFMT(*FILE) OPNID(F)
             MONMSG     MSGID(CPF0864) EXEC(DO)
             CLOSE      OPNID(F)
             GOTO       CMDLBL(LIRE)
             ENDDO
             CHGVAR     VAR(&ID) VALUE(&F_ID)
             CHGVAR     VAR(&NAME) VALUE(&F_NAME)
             CHGVAR     VAR(&HP) VALUE(&F_HP)
             CHGVAR     VAR(&DEFENSE) VALUE(&F_DEFENSE)
             CHGVAR     VAR(&speci00001) VALUE(&F_SPECI00001)
             CHGVAR     VAR(&SPECI00002) VALUE(&F_SPECI00002)
             CHGVAR     VAR(&TYPE1) VALUE(&F_TYPE1)
             CHGVAR     VAR(&TYPE2) VALUE(&F_TYPE2)
             CHGVAR     VAR(&SPEED) VALUE(&F_SPEED)
             CHGVAR     VAR(&ATTACK) VALUE(&F_ATTACK)

             SNDRCVF    RCDFMT(FMT1)
             ENDDO
             ENDPGM
```
