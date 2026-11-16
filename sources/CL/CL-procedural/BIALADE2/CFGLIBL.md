---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: CFGLIBL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 8
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/CFGLIBL

```cl
             PGM
             ADDLIBLE   LIB(PHAN) /* add libl 'PHAN' to libl */
             MONMSG     MSGID(CPF2103) /* catch lib already in libl */
             ADDLIBLE   LIB(PHANSV) /* add libl 'PHANSV' to libl */
             MONMSG     MSGID(CPF2103) /* catch lib already in libl */
             ADDLIBLE   LIB(PHANSQL) /* add libl 'PHANSQL' to libl */
             MONMSG     MSGID(CPF2103) /* catch lib already in libl */
             ENDPGM
```
