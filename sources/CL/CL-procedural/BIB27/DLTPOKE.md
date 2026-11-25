---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: DLTPOKE
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 24
modifie: 2026-11-25
---

# BIB27/QCLSRC/DLTPOKE

```cl
             PGM
             DCL        VAR(&REQ) TYPE(*CHAR) LEN(1000)
             DCL        VAR(&VERIF) TYPE(*CHAR) LEN(100)
             DCL        VAR(&VALID) TYPE(*CHAR) LEN(10)
             DCLF       FILE(POKEMONSQL)
             DOWHILE    COND(&IN03 *EQ '0')
             SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN50) THEN(DO)
             CHGVAR     VAR(&VERIF) VALUE('call BIB27.verifpoke( +
                          '' *cat %char(&idpoke) *cat '','' *cat +
                          '''''''' )')
             RUNSQL     SQL(&VERIF) COMMIT(*NONE) NAMING(*SYS)
             IF         COND(&VALID = 'ok') THEN(DO)
             CHGVAR     VAR(&REQ) VALUE('delete from +
                          BIB27.monequipe1 where id =  ' *CAT +
                          %CHAR(&IDPOKE))
             RUNSQL     SQL(&REQ) COMMIT(*NONE) NAMING(*SYS)
             CHGVAR     VAR(&RESULT) VALUE('pokemon supprimé')
             ENDDO
             IF         COND(&VALID = 'ko') THEN(CHGVAR VAR(&RESULT) +
                          VALUE('pokemon deja supprimé'))
             ENDDO
             ENDDO
             ENDPGM
```
