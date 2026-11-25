---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: EXO_PERSO
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 9
modifie: 2026-11-25
---

# BIB27/QCLSRC/EXO_PERSO

```cl
             PGM        PARM(&LIB)

             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)

             CHKOBJ     OBJ(QSYS/&LIB) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9801) EXEC(DO)
             CRTLIB     LIB(&LIB) TEXT(TEST)
             ENDDO
             ENDPGM
```
