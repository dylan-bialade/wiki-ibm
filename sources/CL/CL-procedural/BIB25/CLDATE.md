---
bibliotheque: BIB25
fichier_source: QILE_DG
membre: CLDATE
type: CL/CL-procedural
longueur_enregistrement: 100
lignes: 18
modifie: 2026-11-25
---

# BIB25/QILE_DG/CLDATE

```cl
             PGM

             DCLF       FILE(ECRANDATE)

             DOWHILE    COND( *NOT &IN03)

                SNDRCVF    RCDFMT(FMT1)

                IF         COND(&IN03) THEN(LEAVE)

                CALLPRC    PRC(CEEDATERPG) PARM(&JOUR  &JOURTXT)
                SNDMSG     MSG(&JOURTXT) TOUSR(LEO2)
                SNDRCVF    RCDFMT(FMT2)


             ENDDO

             ENDPGM
```
