---
bibliotheque: BIB10
fichier_source: QCLPSRC
membre: CFGLIBL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 8
modifie: 2026-11-16
---

# BIB10/QCLPSRC/CFGLIBL

```cl
             PGM
             ADDLIBLE   LIB(BIB15) /* add libl 'BIB15' to libl */
             MONMSG     MSGID(CPF2103) /* catch lib already in libl */
             ADDLIBLE   LIB(BIB13) /* add libl 'BIB13' to libl */
             MONMSG     MSGID(CPF2103) /* catch lib already in libl */
             ADDLIBLE   LIB(BIB10) /* add libl 'BIB10' to libl */
             MONMSG     MSGID(CPF2103) /* catch lib already in libl */
             ENDPGM
```
