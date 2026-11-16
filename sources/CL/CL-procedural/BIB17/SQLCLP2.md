---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: SQLCLP2
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 43
modifie: 2026-11-16
---

# BIB17/QCLPSRC/SQLCLP2

```cl
             PGM
             DCLF       FILE(BIB17/SQLINSDSP)
             DCL        VAR(&AGECHAR) TYPE(*CHAR) LEN(3)
             DCL        VAR(&QRY) TYPE(*CHAR) LEN(256)

 SAISIE:     SNDRCVF    RCDFMT(SQLINSFMT)
             IF         COND(&IN03) THEN(GOTO CMDLBL(ENDPGM))
             IF         COND(&D_NOM *EQ ' ' *OR &D_PRENOM *EQ ' ' +
                          *OR &D_AGE *EQ 0) THEN(DO)
             SNDPGMMSG  MSG('Veuillez remplir tous les champs.')

             GOTO       CMDLBL(SAISIE)
             ENDDO

             CHGVAR     VAR(&AGECHAR) VALUE(&D_AGE)

             CHGVAR     VAR(&QRY) VALUE('INSERT INTO +
                          BIB17/CLIENTS (NOM, PRENOM, AGE) +
                          VALUES(''' *TCAT &D_NOM *TCAT ''', ''' +
                          *TCAT &D_PRENOM *TCAT ''', ' *BCAT +
                          &AGECHAR *TCAT ')')

             RUNSQL     SQL(&QRY) COMMIT(*NONE)

             MONMSG     MSGID(SQL9010) EXEC(DO)
                SNDPGMMSG  MSG('ERREUR SQL LORS DE L''INSERTION.')
                GOTO       CMDLBL(SAISIE)
             ENDDO

             CHGVAR     VAR(&D_NOM) VALUE(' ')
             CHGVAR     VAR(&D_PRENOM) VALUE(' ')
             CHGVAR     VAR(&D_AGE) VALUE(0)


             SNDPGMMSG  MSG('CLIENT AJOUTÉ AVEC SUCCÈS.')
             GOTO       CMDLBL(SAISIE)






 ENDPGM:     ENDPGM
```
