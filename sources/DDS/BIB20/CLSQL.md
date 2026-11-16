---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: CLSQL
type: DDS
longueur_enregistrement: 80
lignes: 44
modifie: 2026-11-16
---

# BIB20/QDDSSRC/CLSQL

```text
             PGM        PARM(&IDE &NOME &PRENOME)

             DCL        VAR(&IDE) TYPE(*DEC) LEN(2)
             DCL        VAR(&IDECHAR) TYPE(*CHAR)
             DCL        VAR(&NOME) TYPE(*CHAR) LEN(10)
             DCL        VAR(&NOMCHAR) TYPE(*CHAR)
             DCL        VAR(&PRENOMCHAR) TYPE(*CHAR)
             DCL        VAR(&PRENOME) TYPE(*CHAR) LEN(10)
             DCL        VAR(&REQUETE) TYPE(*CHAR) LEN(1000)
             DCL        VAR(&REQBASE) TYPE(*CHAR) LEN(1000) +
                          VALUE('INSERT INTO BIB20.COMMEVOULE +
                          VALUES (')
             DCL        VAR(&VALUES) TYPE(*CHAR)

             CHGVAR     VAR(&IDECHAR) VALUE(%CHAR(&IDE))
             CHGVAR     VAR(&NOMCHAR) VALUE(',''' *TCAT &NOME +
                          *TCAT '''')
             CHGVAR     VAR(&PRENOMCHAR) VALUE(',''' *TCAT +
                        &PRENOME *TCAT '''')

             CHGVAR     VAR(&VALUES) VALUE(&IDECHAR *TCAT &NOMCHAR +
                        *TCAT &PRENOMCHAR *TCAT ')')

             CHGVAR     VAR(&REQUETE) VALUE(&REQBASE)


             CHGVAR     VAR(&REQUETE) VALUE(&REQUETE *TCAT &VALUES)

             CHGVAR     VAR(&REQUETE) VALUE(&REQUETE)



             RUNSQL     SQL(&REQUETE)










             ENDPGM
```
