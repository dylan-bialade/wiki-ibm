---
bibliotheque: BIB25
fichier_source: QMODSRC
membre: CL2
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 9
modifie: 2026-11-25
---

# BIB25/QMODSRC/CL2

```cl
             PGM        PARM(&NUM1 &NUM2)
             DCL        VAR(&NUM1) TYPE(*DEC) LEN(5 2)
             DCL        VAR(&NUM2) TYPE(*DEC) LEN(5 2)
             DCL        VAR(&RESULT) TYPE(*DEC) LEN(7 2)
             CALLPRC    PRC(ADDITION) PARM((&NUM1 *BYREF *DFT) +
                          (&NUM2 *BYREF *DFT)) RTNVAL(&RESULT)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('''Résulat = '' *CAT &RESULT')
             ENDPGM
```
