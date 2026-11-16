---
bibliotheque: BIB02
fichier_source: QSRCRACE
membre: RACEC
type: CL/CL-procedural
longueur_enregistrement: 100
lignes: 18
modifie: 2026-11-16
---

# BIB02/QSRCRACE/RACEC

```cl
PGM
     /* Aujourd'hui il fait beau .... mais pas trop .... (en fait on s'en fout ...) */
             DCLPRCOPT  ALWRTVSRC(*NO) USRPRF(*USER)

             ADDLIBLE   LIB(RACES)
         /*  SNDrcvF écran */

             IF         COND(&REP *EQ '1') THEN(OVRDBF FILE(RACEL1) +
                          TOFILE(JOSHUA/RACEL1))

             IF         COND(&REP *EQ '2') THEN(OVRDBF FILE(RACEL1) +
                          TOFILE(LUCA/RACEL1))
             IF         COND(&REP *EQ '3') THEN(OVRDBF FILE(RACEL1) +
                          TOFILE(FETRA/RACEL1))

             CALL       PGM(RACER)
FIN:
ENDPGM
```
