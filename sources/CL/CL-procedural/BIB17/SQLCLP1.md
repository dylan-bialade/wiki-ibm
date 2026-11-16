---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: SQLCLP1
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 18
modifie: 2026-11-16
---

# BIB17/QCLPSRC/SQLCLP1

```cl
             PGM
             DCL        VAR(&FLAG) TYPE(*DEC) LEN(1 0) VALUE(0)

             CHKOBJ     OBJ(BIB17/CLIENTS) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF9801) EXEC(CHGVAR VAR(&FLAG) VALUE(1))

             IF         COND(&FLAG *EQ 0) THEN(DO)
             SNDPGMMSG  MSG('LA TABLE EXISTE DÉJÀ.')
             GOTO       CMDLBL(ENDPGM)
             ENDDO

   /* ******     CRÉER LA TABLE ****** */
             RUNSQL     SQL('CREATE TABLE CLIENTS (ID INT GENERATED +
                          ALWAYS AS IDENTITY PRIMARY KEY, NOM +
                          VARCHAR(50), PRENOM VARCHAR(50), AGE +
                          INT)') COMMIT(*NONE)

 ENDPGM:     ENDPGM
```
