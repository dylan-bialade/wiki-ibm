---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: CALCCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 29
modifie: 2026-11-16
---

# BIB17/QCLPSRC/CALCCL

```cl
             PGM
             DCLF       FILE(CALCDSP)
 START:      SNDRCVF    RCDFMT(CALCFMT)
             IF COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(END))

             /*VOIR F6 */

             IF COND(&COP *EQ '+') THEN(DO)
               CHGVAR VAR(&RESULT) VALUE(&FAC01 + &FAC02)
             ENDDO

             IF COND(&COP *EQ '-') THEN(DO)
               CHGVAR VAR(&RESULT) VALUE(&FAC01 - &FAC02)
             ENDDO

             IF COND(&COP *EQ '*') THEN(DO)
               CHGVAR VAR(&RESULT) VALUE(&FAC01 * &FAC02)
             ENDDO

             IF COND(&COP *EQ '/') THEN(DO)
               IF COND(&FAC02 *EQ 0) THEN(CHGVAR VAR(&RESULT) +
                          VALUE(0))
             ELSE       CMD(DO)
             CHGVAR VAR(&RESULT) VALUE(&FAC01 / &FAC02)
             ENDDO
             ENDDO
             GOTO CMDLBL(START)

 END:        ENDPGM
```
