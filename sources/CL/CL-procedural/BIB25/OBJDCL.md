---
bibliotheque: BIB25
fichier_source: QILETP
membre: OBJDCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 43
modifie: 2026-11-25
---

# BIB25/QILETP/OBJDCL

```cl
             PGM        PARM(&LIB)

             DCLF       FILE(QSYS/QADSPOBJ) OPNID(F)
             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&FIC) TYPE(*CHAR) LEN(10)
             DCL        VAR(&ANN) TYPE(*CHAR) LEN(4)
             DCL        VAR(&MON) TYPE(*CHAR) LEN(2)
             DCL        VAR(&SEQ) TYPE(*CHAR) LEN(2)
/* DSPOBJD outfile dans qtemp *file avec bib récup de l'écran  */
             CLRLIB     LIB(QTEMP)
             CRTDUPOBJ  OBJ(QADSPOBJ) FROMLIB(QSYS) OBJTYPE(*FILE) +
                          TOLIB(QTEMP) NEWOBJ(DSPOBJD) CST(*NO) +
                          TRG(*NO)
             DSPOBJD    OBJ(&LIB/*ALL) OBJTYPE(*FILE) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/DSPOBJD)

             DSPPGMREF  PGM(&LIB/*ALL) OUTPUT(*OUTFILE) OBJTYPE(*ALL) +
                          OUTFILE(QTEMP/DSPPGMREF)
/* crtlib RAPPORT */
             CRTLIB     LIB(RAPPORT) TEXT('RAPPORT FICHIER IBM I')
             MONMSG     MSGID(CPF2111)
             ADDLIBLE   LIB(RAPPORT)
             MONMSG     MSGID(CPF0000)
/* creation fichier en sortie convention : RPdate+num   */
             CALLPRC    PRC(CURDATE) PARM(&ANN &MON &SEQ)
             CHGVAR     VAR(%SST(&FIC 1 2)) VALUE('RP')
             CHGVAR     VAR(%SST(&FIC 3 4)) VALUE(&ANN)
             CHGVAR     VAR(%SST(&FIC 7 2)) VALUE(&MON)
             CHGVAR     VAR(%SST(&FIC 9 2)) VALUE(&SEQ)
             CRTDUPOBJ  OBJ(RAPPORT) FROMLIB(BIB25) OBJTYPE(*FILE) +
                          TOLIB(RAPPORT) NEWOBJ(&FIC) CST(*NO) TRG(*NO)
/* boucle de lecture sur dspobjd   */
             OVRDBF     FILE(QADSPOBJ) TOFILE(QTEMP/DSPOBJD)
 LOOP:       RCVF       OPNID(F)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(END))
/* appel de procédure MODULE RPGLE   */
             CALLPRC    PRC(TRAIT) PARM(&F_ODOBNM &F_ODOBAT &F_ODLBNM +
                          &F_ODSRCF &F_ODSRCL &F_ODSRCM)
             GOTO       CMDLBL(LOOP)
/* INSERTION dans le fichier en sortie   */
/* fin du programme   */
             SNDPGMMSG  MSG('FICHIER DISPONIBLE')
 END:        ENDPGM
```
