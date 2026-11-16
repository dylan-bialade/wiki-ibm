---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: ANIMALCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 31
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/ANIMALCL

```cl
PGM
             DCLF       FILE(ANIMAUX) OPNID(DBF)
             DCLF       FILE(ANIMALFM)
             DCLF       FILE(QAFDMBRL) OPNID(MBR)

             DSPFD      FILE(ANIMAUX) TYPE(*MBRLIST) +
                              OUTPUT(*OUTFILE) OUTFILE(QTEMP/LISTMBR)

             OVRDBF     FILE(QAFDMBRL) TOFILE(LISTMBR)

 CHGMBR:     RCVF OPNID(MBR)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(END))
             CHGVAR     VAR(&VAR1) VALUE(&MBR_MLNAME)

             OVRDBF     FILE(ANIMAUX) TOFILE(PHAN/ANIMAUX) +
                          MBR(&VAR1)


 LOOP:       RCVF       OPNID(DBF)
             MONMSG     MSGID(CPF0864) EXEC(DO)
             DLTOVR     FILE(ANIMAUX)
             CLOSE      OPNID(DBF)
             GOTO       CMDLBL(CHGMBR)
             ENDDO
             CHGVAR     VAR(&NOM) VALUE(&DBF_NOM)
             CHGVAR     VAR(&TAILLE) VALUE(&DBF_TAILLE)
             CHGVAR     VAR(&COULEUR) VALUE(&DBF_COULEUR)
             SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(END))
             GOTO       CMDLBL(LOOP)
  END:       ENDPGM
```
