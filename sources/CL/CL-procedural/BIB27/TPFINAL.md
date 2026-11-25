---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: TPFINAL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 22
modifie: 2026-11-25
---

# BIB27/QCLSRC/TPFINAL

```cl
             PGM
             DCLF       FILE(TPFINALSQL)
             DCLF       FILE(BIB27/POKEMONTP) OPNID(F) +
                          ALWVARLEN(*YES) ALWNULL(*YES)
             DOWHILE    COND(&IN03 *EQ '0')
 LIRE:       RCVF       OPNID(F)
             MONMSG     MSGID(CPF0864) EXEC(DO)
             CLOSE      OPNID(F)
             GOTO       CMDLBL(LIRE)
             ENDDO
             CHGVAR     VAR(&NAME) VALUE(&F_NAME)
             CHGVAR     VAR(&TYPE1) VALUE(%SST(&F_TYPE1 3 15))
             CHGVAR     VAR(&NUMBER) VALUE(&F_ID_POKE)
             CHGVAR     VAR(&TYPE2) VALUE(%SST(&F_TYPE2 3 15))
             SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN02 *EQ '1') THEN(DO)
             RUNSQL     SQL('delete from BIB27.equipeadverse +
                          where id_poke = ' *CAT %CHAR(&NUMBER)) +
                          COMMIT(*NONE)
             ENDDO
             ENDDO
             ENDPGM
```
