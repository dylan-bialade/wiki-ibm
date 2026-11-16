---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: EXOCLLE
type: DDS
longueur_enregistrement: 80
lignes: 18
modifie: 2026-11-16
---

# BIB20/QDDSSRC/EXOCLLE

```text
             PGM

             DCLF       FILE(BIB20/ECRANTAB) OPNID(ECRAN)
             DCLF       FILE(BIB20/RACEP) OPNID(RACEPF)



remonter:    RCVF       OPNID(RACEPF)

             CHGVAR     VAR(&ECRAN_NMRACE) VALUE(&RACEPF_NMRACE)
             CHGVAR     VAR(&ECRAN_NoRACE) VALUE(&RACEPF_NoRACE)

             IF         COND(&ECRAN_IN01) THEN(GOTO CMDLBL(REMONTER))
             if         COND(&ECRAN_IN03) THEN(GOTO CMDLBL(fin))
             SNDRCVF    RCDFMT(EXO) OPNID(ECRAN)
             goto       cmdlbl(remonter)

fin:         ENDPGM
```
