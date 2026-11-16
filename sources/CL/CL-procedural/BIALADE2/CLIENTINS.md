---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: CLIENTINS
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 18
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/CLIENTINS

```cl
             PGM        PARM(&NOM &PRENOM &AGE)
             /* Déclaration variables */
             DCL        VAR(&NOM) TYPE(*CHAR) LEN(35)
             DCL        VAR(&PRENOM) TYPE(*CHAR) LEN(35)
             DCL        VAR(&AGE) TYPE(*DEC) LEN(3 0)
             DCL        VAR(&REQ) TYPE(*CHAR) LEN(256)
             /* changement current lib */
             CHGCURLIB  CURLIB(PHAN)
             MONMSG     MSGID(CPF0000)
             /* Création de la requête */
             CHGVAR     VAR(&REQ) VALUE('insert into clients ( nom +
                          , prenom , age) values (''' *tcat &nom +
                          *cat ''',''' *cat &prenom *tcat +
                          ''', ' *cat %char(&age) *cat ')')
             /* exécution */
             RUNSQL     SQL(&REQ) COMMIT(*NONE)
             MONMSG     MSGID(CPF0000)
             ENDPGM
```
