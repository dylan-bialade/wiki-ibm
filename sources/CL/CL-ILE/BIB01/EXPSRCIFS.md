---
bibliotheque: BIB01
fichier_source: QCLLESRC
membre: EXPSRCIFS
type: CL/CL-ILE
longueur_enregistrement: 100
lignes: 87
modifie: 2026-11-16
---

# BIB01/QCLLESRC/EXPSRCIFS

```cl
             PGM
  /*Déclaration de fichier _______________________________________*/
             DCLF       FILE(EXPSRCIFSD)
             DCLF       FILE(QAFDMBR) RCDFMT(QWHFDMBR) OPNID(W)
  /*Déclaration de variable ______________________________________*/
             DCL        VAR(&USER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&WIFS) TYPE(*CHAR) LEN(50)
             DCL        Var(&TXT) TYPE(*CHAR) LEN(150)
             DCL        VAR(&LEN) TYPE(*INT) LEN(4)
             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(7) VALUE(' ')
             DCL        VAR(&MSGFN) TYPE(*CHAR) LEN(20) VALUE(' ')
             DCL        VAR(&WQSYS) TYPE(*CHAR) LEN(100) VALUE(' ')

             RTVJOBA    USER(&USER)

  /*Affichage ecran 1 ____________________________________________*/
 AFF1:       SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
 /*Controle si blanc */
             IF         COND((&PBIB = ' ') *OR (&PFIC = ' ')) +
                          THEN(GOTO CMDLBL(AFF1))
 /*Controler la bibliotheque et le fichier */
             CHKOBJ     OBJ(QSYS/&PBIB) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9810) EXEC(CHGVAR VAR(&IN90) +
                          VALUE('1'))

             CHKOBJ     OBJ(&PBIB/&PFIC) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF9801) EXEC(CHGVAR VAR(&IN91) +
                          VALUE('1'))

             IF         COND((&IN90 = '1') *OR (&IN91 = '1')) +
                          THEN(GOTO CMDLBL(AFF1))
 /*Fin affichage ecran 1 __________________________________*/
 /*Creer le chemin IFS  exemple : '/home/<user>/<fichier>' */
             CHGVAR     VAR(&CHMIFS) VALUE('/home/' *TCAT &USER +
                          *TCAT '/' *TCAT &PFIC)
 /*Creer le dossier dans l'ifs ____________________________*/
             RMVDIR     DIR(&CHMIFS) SUBTREE(*ALL)
             MONMSG     MSGID(CPFA0A9 CPFA0B7)
             CRTDIR     DIR(&CHMIFS)

             CHGVAR     VAR(&CHMIFS) VALUE(&CHMIFS *TCAT '/')
 /*Lister les membres sources _____________________________*/
             DSPFD      FILE(&PBIB/&PFIC) TYPE(*MBR) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/DSPFD)

 /*Substitution de fichier */
             OVRDBF     FILE(QAFDMBR) TOFILE(QTEMP/DSPFD)

 /*Boucle de lecture sur le fichier de travail */
 BOUCLE:     RCVF       OPNID(W)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(EOF))
             CHGVAR     VAR(&COUNT) VALUE(&COUNT + 1)
             CHGVAR     VAR(&WIFS) VALUE(&CHMIFS *TCAT &W_MBNAME +
                          *TCAT '.' *TCAT &W_MBSEU2)

 /*Creer le chemin QSYS exemple :                                  */
 /*'/QSYS.LIB/<BIBLIOTHEQUE>.LIB/<FICHIER>.FILE/<MEMBRE>.MBR'      */
 /*'/QSYS.LIB/FADRIEN.LIB/QCLPSRC.FILE/MEMBRE.MBR'                 */
 /*'/QSYS.LIB/ + &PLIB + .LIB/ + &PFIC + .FILE/ + W_MBNAME + .MBR' */

             CHGVAR     VAR(&WQSYS) VALUE('/qsys.lib/' *TCAT &PBIB +
                          *TCAT '.lib/' *TCAT &PFIC *TCAT '.file/' +
                          *TCAT &W_MBNAME *TCAT '.mbr')

     /*Copier dans l'iFS */
             CPYTOSTMF  FROMMBR(&WQSYS) TOSTMF(&WIFS) STMFCCSID(1208)
             GOTO       CMDLBL(BOUCLE)

    /*Fin de fichier ____________________________________*/
 EOF:
    /*Affichage de la fenetre POP UP QUILNGTX ___________*/
             CHGVAR     VAR(&TXT) VALUE('Les sources ont été exporté +
                          dans le dossier : ' *CAT &CHMIFS *BCAT +
                          'et il y a ' *CAT %CHAR(&COUNT) *BCAT +
                          'membres sources')
             CHGVAR     VAR(&LEN) VALUE(%LEN(&TXT))

             CALL       PGM(QUILNGTX) PARM((&TXT) (&LEN) +
                          (&MSGID) (&MSGFN) (X'0000000000000000'))
 /*Afficher le resultat de l'extraction___________________________*/

             SNDRCVF    RCDFMT(FMT2)

 /*FIN DE PROGRAMME _____________________________________________*/
 FIN:        DLTOVR     FILE(*ALL)
             ENDPGM
```
