# TPFINAL : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB25 | QCLLESRC | CL/CL-ILE | 22 | 100 % | boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF | [TPFINAL.md](../../sources/CL/CL-ILE/BIB25/TPFINAL.md) |
| BIB27 | QCLSRC | CL/CL-procedural | 22 | 100 % | boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF | [TPFINAL.md](../../sources/CL/CL-procedural/BIB27/TPFINAL.md) |
| BIB27 | QTPSRC | RPG/RPG-ILE | 268 | 0 % | full free, sous-fichier, ecran (WORKSTN), SQL embarque, curseur SQL, boucle DOW/DOU/FOR, procedures (dcl-proc), prototypes (dcl-pr), indicateurs *INxx | [TPFINAL.md](../../sources/RPG/RPG-ILE/BIB27/TPFINAL.md) |

## Differences

- Techniques communes : boucle DOW/DOU/FOR
- **BIB25** en propre : gestion d erreur, CL : DCLF
- **BIB27** en propre : gestion d erreur, CL : DCLF
- **BIB27** en propre : full free, sous-fichier, ecran (WORKSTN), SQL embarque, curseur SQL, procedures (dcl-proc), prototypes (dcl-pr), indicateurs *INxx
- Langages / types differents : CL/CL-ILE, CL/CL-procedural, RPG/RPG-ILE

## Codes

### BIB25 (CL/CL-ILE, 22 lignes)

```text
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

### BIB27 (CL/CL-procedural, 22 lignes)

```text
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

### BIB27 (RPG/RPG-ILE, 268 lignes)

_Long : voir [TPFINAL.md](../../sources/RPG/RPG-ILE/BIB27/TPFINAL.md)._
