---
bibliotheque: BIALADE
fichier_source: QCLPSRC
membre: CALCU
type: CL\CL-procedural
longueur_enregistrement: 80
lignes: 25
modifie: 2026-11-16
---

# BIALADE/QCLPSRC/CALCU

```cl
 PGM
              DCLF       FILE(BIALADE/CALCULATRI)



  DEBUT:      SNDRCVF    RCDFMT(CALCU)
             IF         COND(&IN06 *EQ '1') THEN(DO)
             QSYS/CHGVAR VAR(&FACT1) VALUE( 0 )
             QSYS/CHGVAR VAR(&FACT3) VALUE( 0 )
             QSYS/CHGVAR VAR(&RESULT) VALUE( 0 )
             ENDDO
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))

             IF         COND(&OPT1 *EQ '+') THEN(CHGVAR VAR(&RESULT) +
                          VALUE( &FACT1 + &FACT3 ))

              IF         COND(&OPT1 *EQ '*') THEN(CHGVAR VAR(&RESULT) +
                           VALUE( &FACT1 * &FACT3 ))
              IF         COND(&OPT1 *EQ '/') THEN(CHGVAR VAR(&RESULT) +
                           VALUE( &FACT1 / &FACT3 ))
              IF         COND(&OPT1 *EQ '-') THEN(CHGVAR VAR(&RESULT) +
                           VALUE( &FACT1 - &FACT3 ))

              GOTO       CMDLBL(DEBUT)
  FIN:        ENDPGM
```
