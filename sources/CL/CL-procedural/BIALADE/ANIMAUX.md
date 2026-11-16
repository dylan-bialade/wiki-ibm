---
bibliotheque: BIALADE
fichier_source: QCLPSRC
membre: ANIMAUX
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 14
modifie: 2026-11-16
---

# BIALADE/QCLPSRC/ANIMAUX

```cl
            PGM        PARM(&PARAM)
             DCL        VAR(&PARAM) TYPE(*CHAR) LEN(10)
            DCLF       FILE(BIALADE/ANIMAU1)
            DCLF       FILE(BIALADE/ANIMAUX) OPNID(D)
            OVRDBF     FILE(ANIMAUX) MBR(&PARAM)
DEBUT:      RCVF       OPNID(D)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))
            QSYS/CHGVAR VAR(&VAR2) VALUE(&D_NOM)
            QSYS/CHGVAR VAR(&VAR3) VALUE(&D_TAILLE)
            QSYS/CHGVAR VAR(&VAR4) VALUE(&D_COULEUR)
            SNDRCVF    RCDFMT(FMT1)
IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             GOTO       CMDLBL(DEBUT)
 FIN: ENDPGM
```
