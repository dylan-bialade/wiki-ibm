---
bibliotheque: BIB25
fichier_source: QCLLESRC
membre: CRTTABLE
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 12
modifie: 2026-11-25
---

# BIB25/QCLLESRC/CRTTABLE

```cl
             PGM
             DCL        VAR(&REQ) TYPE(*CHAR) LEN(1000)
             CHGVAR     VAR(&REQ) VALUE('create table +
                          BIB27.employe ( idemp int primary key , +
                          nom varchar(20) not null) ')
             RUNSQL     SQL(&REQ) COMMIT(*NONE) NAMING(*SYS)
             MONMSG     MSGID(SQL9010) EXEC(DO)
             SNDPGMMSG  MSG('la table est deja créé')
             GOTO       CMDLBL(END)
             ENDDO
             SNDPGMMSG  MSG('la table a été créé')
 END:        ENDPGM
```
