---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: ANIMAUXCLP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 30
modifie: 2026-11-16
---

# BIB17/QCLPSRC/ANIMAUXCLP

```cl
             PGM
             DCLF       FILE(BIB17/ANIMAUXDSP)
             DCLF       FILE(ANIMAUX) OPNID(A)
             DCLF       FILE(QSYS/QAFDMBRL)  OPNID(F)


             DSPFD      FILE(*LIBL/ANIMAUX) TYPE(*MBRLIST) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/TEMPMBR)
             OVRDBF     FILE(QAFDMBRL) TOFILE(QTEMP/TEMPMBR) MBR(*ALL)

 LECTMBR:    RCVF       OPNID(F)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(ENDPGM))
             OVRDBF     FILE(ANIMAUX) MBR(&F_MLNAME)

 LECTANM:    RCVF       OPNID(A)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FINLECT))
             CHGVAR     VAR(&MEMBRE) VALUE(&F_MLNAME)
             CHGVAR     VAR(&NOM) VALUE(&A_NOM)
             CHGVAR     VAR(&TAILLE) VALUE(&A_TAILLE)
             CHGVAR     VAR(&COULEUR) VALUE(&A_COULEUR)

             SNDRCVF    RCDFMT(ANIMAUXFMT)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(ENDPGM))
             GOTO       CMDLBL(LECTANM)

 FINLECT:    CLOSE      OPNID(A)
             DLTOVR     FILE(ANIMAUX)
             GOTO       CMDLBL(LECTMBR)

 ENDPGM:     ENDPGM
```
