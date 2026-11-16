---
bibliotheque: BIB05
fichier_source: QCLPSRC
membre: EXPSRCIFS
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 64
modifie: 2026-11-16
---

# BIB05/QCLPSRC/EXPSRCIFS

```cl
PGM
                DCLF       FILE(BIB05/EXPSRCIFSD)
                DCLF       FILE(QAFDMBR) RCDFMT(QWHFDMBR) OPNID(W)
                DCL        VAR(&USER) TYPE(*CHAR) LEN(10)
                DCL        VAR(&FILE_PATH) TYPE(*CHAR) LEN(50)
                DCL        VAR(&MBR_PATH) TYPE(*CHAR) LEN(50)
                DCL        VAR(&MBR_ACS) TYPE(*CHAR) LEN(50)
                DCL        VAR(&TYPEFFD) TYPE(*CHAR) LEN(10)
                RTVJOBA    USER(&USER)
 FMT1:          SNDRCVF    RCDFMT(FMT1)
                CHGVAR     VAR(&IN91) VALUE('0')
                CHGVAR     VAR(&IN90) VALUE('0')
                CHGVAR     VAR(&IN92) VALUE('0')
                IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
                IF         COND((&PBIB *NE ' ') *AND (&PFIC *NE ' ')) +
                          THEN(GOTO CMDLBL(TESTE))
               CHKOBJ     OBJ(QSYS/&PBIB) OBJTYPE(*LIB)
               GOTO       CMDLBL(FMT1)

TESTE:        DSPFD      FILE(&PBIB/&PFIC) TYPE(*MBR) +
                    OUTPUT(*OUTFILE) OUTFILE(QTEMP/MBRF)


              MONMSG     MSGID(CPF9801 CPF3064) EXEC(DO)

              CHGVAR     VAR(&IN90) VALUE('1')
              GOTO       CMDLBL(FMT1)
              ENDDO
              MONMSG     MSGID(CPF3012) EXEC(DO)
              CHGVAR     VAR(&IN91) VALUE('1')
              GOTO       CMDLBL(FMT1)
              ENDDO

             QSYS/RTVMBRD FILE(QTEMP/MBRF) SRCTYPE(&TYPEFFD)
             IF         COND(&TYPEFFD *EQ ' ') THEN(DO)
             CHGVAR VAR(&IN92) VALUE('1')
             GOTO       CMDLBL(FMT1)
             ENDDO


              CHGVAR     VAR(&FILE_PATH) VALUE('/HOME/' *TCAT +
                           &USER *TCAT '/' *TCAT &PFIC)
  CRT:        CRTDIR     DIR(&FILE_PATH)
              MONMSG     MSGID(CPFA0A0 CPFA097) EXEC(DO)
              RMVDIR     DIR(&FILE_PATH)
              GOTO       CMDLBL(CRT)
              ENDDO

              OVRDBF     FILE(QAFDMBR) TOFILE(QTEMP/MBRF)
  BOUCLE:     RCVF       OPNID(W)
              MONMSG     MSGID(CPF0864 CPFA097) EXEC(GOTO CMDLBL(FMT2))
              CHGVAR     VAR(&COUNT) VALUE(&COUNT + 1)
              CHGVAR     VAR(&CHMIFS) VALUE(&FILE_PATH *TCAT +
                             &W_MBNAME *TCAT '.' *TCAT &W_MBSEU)
               CHGVAR     VAR(&MBR_ACS) VALUE('/QSYS.LIB/' *TCAT +
                            &PBIB *TCAT '.LIB/' *TCAT &PFIC *TCAT +
                            '.FILE/' *TCAT &W_MBNAME *TCAT '.MBR')
               CPYTOSTMF  FROMMBR(&MBR_ACS) TOSTMF(&CHMIFS) +
                            STMFOPT(*REPLACE)
               GOTO       CMDLBL(BOUCLE)
               DLTOVR     FILE(*ALL)
FMT2:       SNDRCVF    RCDFMT(FMT2)
 FIN:       DLTOVR     FILE(*ALL)
            ENDPGM
```
