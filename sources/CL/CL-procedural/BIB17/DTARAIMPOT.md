---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: DTARAIMPOT
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 21
modifie: 2026-11-16
---

# BIB17/QCLPSRC/DTARAIMPOT

```cl
             PGM
             DCL        VAR(&DTARANAM) TYPE(*CHAR) LEN(10) +
                          VALUE(REVDTARA)
             DCL        VAR(&MONTANT) TYPE(*DEC) LEN(8 2) VALUE(36000)

             DLTDTAARA  DTAARA(&DTARANAM)
             MONMSG     MSGID(CPF2105)
             CRTDTAARA  DTAARA(BIB17/&DTARANAM) TYPE(*DEC) +
                          LEN(8 2) VALUE(&MONTANT)

             CALL       PGM(IMPOTS) PARM(&DTARANAM)









             ENDPGM
```
