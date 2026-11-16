---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: CALCCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 39
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/CALCCL

```cl
             PGM
/* DECLARATION DE FICHIER                     */
             DCLF       FILE(CALCFM)
/* DECLARATION DE VARIABLE                    */
             DCL        VAR(&ERR) TYPE(*LGL) VALUE('0')
/* NETOYAGE DES VARIABLES                     */
 CLEAR:      CHGVAR     VAR(&FAC1) VALUE(0)
             CHGVAR     VAR(&FAC2) VALUE(0)
             CHGVAR     VAR(&COP) VALUE(' ')
             CHGVAR     VAR(&RESULT) VALUE(0)
             CHGVAR     VAR(&ERR) VALUE('0')
/* AFFICHAGE DE L'ECRAN                       */
 DEBUT:      SNDRCVF    RCDFMT(CALCFM1)
/* FUNCTION KEYS                              */
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             IF         COND(&IN06 *EQ '1') THEN(GOTO CMDLBL(CLEAR))
/* GESTION D'ERREURS                          */
             IF         COND(&FAC2 = 0) THEN(CHGVAR VAR(&ERR) VALUE('1'))
             IF         COND(&FAC2 *EQ 0) THEN(GOTO CMDLBL(DEBUT))
             IF         COND(&ERR = '1') THEN(DO)
             CHGVAR     VAR(&ERR) VALUE('0')
             GOTO       CMDLBL(DEBUT)
             ENDDO
/* TRAITEMENT PRINCIPAL                       */
             IF         COND(&COP *EQ '+') THEN(CHGVAR VAR(&RESULT) +
                          VALUE(&FAC1 + &FAC2))
             IF         COND(&COP *EQ '-') THEN(CHGVAR VAR(&RESULT) +
                          VALUE(&FAC1 - &FAC2))
             IF         COND(&COP *EQ '*') THEN(CHGVAR VAR(&RESULT) +
                          VALUE(&FAC1 * &FAC2))
             IF         COND(&COP *EQ '/') THEN(CHGVAR VAR(&RESULT) +
                          VALUE(&FAC1 / &FAC2))



             GOTO       CMDLBL(DEBUT)

/* FIN DE TRAITEMENT                          */
 FIN:        ENDPGM
```
