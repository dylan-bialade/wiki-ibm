---
bibliotheque: BIB17
fichier_source: QCLPSRC
membre: JUSTPRCLP
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 29
modifie: 2026-11-16
---

# BIB17/QCLPSRC/JUSTPRCLP

```cl
             PGM
             DCLF       FILE(JUSTPRDSP)
             DCL        VAR(&JUSTPRICE) TYPE(*DEC) LEN(4 0) VALUE(134)
             DCL        VAR(&MSG) TYPE(*CHAR) LEN(50) VALUE('TEST')
 START:      SNDRCVF    RCDFMT(JSTPRFMT)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(END))

      /* TROUVÉ  $$$$$$$$$$$$$$$$$$  */
             IF         COND(&PRICE *EQ &JUSTPRICE) THEN(DO)
             CHGVAR VAR(&MSG) VALUE('TROUVÉ!!!!')
             CHGVAR VAR(&IN40) VALUE('0')
             ENDDO

      /*TROP HAUT    */
             IF         COND(&PRICE *GT &JUSTPRICE) THEN(DO)
             CHGVAR     VAR(&MSG) VALUE('Le prix' *BCAT +
                          %CHAR(&PRICE) *BCAT 'est trop haut')
             CHGVAR VAR(&IN40) VALUE('1')
             ENDDO

      /* TROP BAS   */
             IF         COND(&PRICE *LT &JUSTPRICE) THEN(DO)
             CHGVAR VAR(&IN40) VALUE('1')
             CHGVAR     VAR(&MSG) VALUE('Le prix' *BCAT +
                          %CHAR(&PRICE) *BCAT 'est trop bas')
             ENDDO
             CHGVAR     VAR(&MSGOTP) VALUE(&MSG)
             GOTO CMDLBL(START)
 END:        ENDPGM
```
