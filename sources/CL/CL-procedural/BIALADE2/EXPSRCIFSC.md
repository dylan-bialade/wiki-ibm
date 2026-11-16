---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: EXPSRCIFSC
type: CL\CL-procedural
longueur_enregistrement: 80
lignes: 72
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/EXPSRCIFSC

```cl
             PGM
/*declaration de fichier */
             DCLF       FILE(EXPSRCIFSD)
             DCLF       FILE(QAFDMBR) RCDFMT(QWHFDMBR) OPNID(W)
/* DECLARATION VARIABLES */
             DCL        VAR(&USER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SRCTYP) TYPE(*CHAR) LEN(10)
             DCL        VAR(&FILE_PATH) TYPE(*CHAR) LEN(50)
             DCL        VAR(&MBR_ACS) TYPE(*CHAR) LEN(50)
/* TRAITEMENT */
             RTVJOBA    USER(&USER)

 ECRAN1:    SNDRCVF    RCDFMT(FMT1)
             CHGVAR     VAR(&IN90) VALUE('0')
             CHGVAR     VAR(&IN91) VALUE('0')
             CHGVAR     VAR(&IN92) VALUE('0')
/* FUNCTION KEYS                              */
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))

/* CHAMP USER NON VIDE                        */
             IF         COND((&PBIB *NE ' ') *AND (&PFIC *NE ' ')) +
                          THEN(GOTO CMDLBL(NEXT))
             GOTO       CMDLBL(ECRAN1)

/* RECHERCHE FICHIER  */
 NEXT:       DSPFD      FILE(&PBIB/&PFIC) TYPE(*MBR) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/MBRF)
             MONMSG     MSGID(CPF3012) EXEC(DO)
             CHGVAR     VAR(&IN91) VALUE('1')
             GOTO       CMDLBL(ECRAN1)
             ENDDO
             MONMSG     MSGID(CPF3064) EXEC(DO)
             CHGVAR     VAR(&IN90) VALUE('1')
             GOTO       CMDLBL(ECRAN1)
             ENDDO
             RTVMBRD    FILE(QTEMP/MBRF) SRCTYPE(&SRCTYP)
             IF         COND(&SRCTYP = ' ') THEN(DO)
             CHGVAR     VAR(&IN92) VALUE('1')
             GOTO       CMDLBL(ECRAN1)


             CHGVAR     VAR(&CHMIFS) VALUE('/home/' *TCAT +
                          &USER *TCAT '/' *TCAT &PFIC *TCAT +
                           '/')
 CRTDIR:     CRTDIR     DIR(&CHMIFS)
             MONMSG     MSGID(CPFA0A0) EXEC(DO)
             RMVDIR     DIR(&CHMIFS) SUBTREE(*ALL)
             GOTO       CMDLBL(CRTDIR)
             ENDDO
/* TRAITEMENT FICHIER */
             OVRDBF     FILE(QAFDMBR) TOFILE(QTEMP/MBRF)
 LOOP:       RCVF       OPNID(W)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(ECRAN2))
             CHGVAR     VAR(&COUNT) VALUE(&count + 1)
             IF         COND(W_MBSEU = ' ') THEN(CHGVAR +
                          VAR(&FILE_PATH) VALUE(&CHMIFS *TCAT +
                          &W_MBNAME *TCAT '.TXT'))
             ELSE       CMD(CHGVAR VAR(&FILE_PATH) VALUE(&CHMIFS +
                          *TCAT &W_MBNAME *TCAT '.' *TCAT &W_MBSEU))
             CHGVAR     VAR(&MBR_ACS) VALUE('/QSYS.LIB/' *TCAT +
                          &PBIB *TCAT '.LIB/' *TCAT &PFIC *TCAT +
                          '.FILE/' *TCAT &W_MBNAME *TCAT '.MBR')

             CPYTOSTMF  FROMMBR(&MBR_ACS) TOSTMF(&FILE_PATH) +
                          STMFOPT(*REPLACE) STMFCCSID(1208)
             ENDDO
             GOTO       CMDLBL(LOOP)
             DLTOVR     FILE(*ALL)

 ECRAN2:     SNDRCVF    RCDFMT(FMT2)
  FIN:       DLTOVR     FILE(*ALL)
             ENDPGM
```
