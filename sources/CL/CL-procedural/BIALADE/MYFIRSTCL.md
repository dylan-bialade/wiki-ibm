---
bibliotheque: BIALADE
fichier_source: QCLPSRC
membre: MYFIRSTCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 15
modifie: 2026-11-16
---

# BIALADE/QCLPSRC/MYFIRSTCL

```cl
             PGM
/* EXECUTER LA COMMANDE :                                        */
/*   DSPOBJD OBJ(*CURLIB/*ALL) OBJTYPE(*ALL) OUTPUT(*OUTFILE)    */
/*               OUTFILE(*CURLIB/DSPOBJD)                        */
             DCLF       FILE(DSPOBJD)
             DCL        VAR(&COUNT) TYPE(*DEC) LEN(3 0) VALUE(0)

 LECTURE:    RCVF       RCDFMT(QLIDOBJD)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))
             CHGVAR     VAR(&COUNT) VALUE(&COUNT + 1)
             GOTO       CMDLBL(LECTURE)

 FIN:        SNDPGMMSG  MSG(%CHAR(&COUNT))

             ENDPGM
```
