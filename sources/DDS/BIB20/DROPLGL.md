---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: DROPLGL
type: DDS
longueur_enregistrement: 80
lignes: 12
modifie: 2026-11-16
---

# BIB20/QDDSSRC/DROPLGL

```text
             PGM

             DCLF       FILE(BIB20/LGLF) OPNID(DL)
 BOUCLE:     RCVF       OPNID(DL)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))

             IF         COND(&DL_WHRTYP *EQ 'L') THEN(DLTF +
                          FILE(BIB20/&DL_WHRFI))

             GOTO       CMDLBL(BOUCLE)

 FIN:        ENDPGM
```
