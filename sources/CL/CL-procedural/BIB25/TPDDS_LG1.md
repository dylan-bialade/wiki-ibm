---
bibliotheque: BIB25
fichier_source: QF_PFLF
membre: TPDDS_LG1
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 8
modifie: 2026-11-25
---

# BIB25/QF_PFLF/TPDDS_LG1

```cl
             PGM        PARM(&BIB)
             DCL        VAR(&BIB) TYPE(*CHAR) LEN(10)
             CRTSRCPF   FILE(&BIB/QDDSSRC)
             MONMSG     MSGID(CPF0000)
             ADDPFM     FILE(&BIB/QDDSSRC) MBR(EMPLOYES) TEXT('TP 1 +
                          - PF') SRCTYPE(PF)
             MONMSG     MSGID(CPF0000)
             ENDPGM
```
