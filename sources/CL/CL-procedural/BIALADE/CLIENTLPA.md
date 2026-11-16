---
bibliotheque: BIALADE
fichier_source: QCLPSRC
membre: CLIENTLPA
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 15
modifie: 2026-11-16
---

# BIALADE/QCLPSRC/CLIENTLPA

```cl
            PGM        PARM(&NOM &PRENOM &AGE)
            DCL        VAR(&NOM) TYPE(*CHAR) LEN(20)
            DCL        VAR(&PRENOM) TYPE(*CHAR) LEN(20)
            DCL        VAR(&AGE) TYPE(*DEC) LEN(3 0)
            DCL        VAR(&SQLSTM) TYPE(*CHAR) LEN(50)
            CHGVAR     VAR(&SQLSTM) VALUE('''INSERT INTO +
                         PHAN.CLIENTS( NOM, PRENOM, AGE) +
                         VALUES('''!!&NOM!!''','''!!&PRENOM!!'''+
                         ,'!!%CHAR(&AGE)!!')''')
             SNDPGMMSG  MSG('&NOM INSERÉ DANS LA TABLE CLIENTS')




 FIN:        ENDPGM
```
