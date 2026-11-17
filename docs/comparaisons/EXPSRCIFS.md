# EXPSRCIFS : 3 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB01 | QCLLESRC | CL/CL-ILE | 87 | 100 % | gestion d erreur, CL : DCLF | [EXPSRCIFS.md](../../sources/CL/CL-ILE/BIB01/EXPSRCIFS.md) |
| BIB05 | QCLPSRC | CL/CL-procedural | 64 | 10 % | boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF | [EXPSRCIFS.md](../../sources/CL/CL-procedural/BIB05/EXPSRCIFS.md) |
| BIB17 | QCLPSRC | CL/CL-procedural | 68 | 6 % | boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF | [EXPSRCIFS.md](../../sources/CL/CL-procedural/BIB17/EXPSRCIFS.md) |

## Differences

- Techniques communes : gestion d erreur, CL : DCLF
- **BIB05** en propre : boucle DOW/DOU/FOR
- **BIB17** en propre : boucle DOW/DOU/FOR
- Langages / types differents : CL/CL-ILE, CL/CL-procedural

## Codes

### BIB01 (CL/CL-ILE, 87 lignes)

```text
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

### BIB05 (CL/CL-procedural, 64 lignes)

```text
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

### BIB17 (CL/CL-procedural, 68 lignes)

```text
             PGM
             DCLF       FILE(EXPSRCIFSD)
             DCLF       FILE(QSYS/QAFDMBR) RCDFMT(QWHFDMBR) OPNID(W)
             DCL        VAR(&PROFIL) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CHMIFS) TYPE(*CHAR) LEN(40)
             DCL        VAR(&FICIFS) TYPE(*CHAR) LEN(100)
             RTVJOBA    USER(&PROFIL)

 STRFMT1:    SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FINLECT))
             IF         COND((&PBIB *EQ '          ') *OR (&PFIC *EQ +
                          '          ')) THEN(GOTO CMDLBL(STRFMT1))

             CHGVAR     VAR(&IN90) VALUE('0')
             CHKOBJ     OBJ(&PBIB) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9810 CPF9801) EXEC(DO)
             CHGVAR     VAR(&IN90) VALUE('1')
             GOTO       CMDLBL(STRFMT1)
             ENDDO


             CHGVAR     VAR(&IN91) VALUE('0')
             CHKOBJ     OBJ(&PBIB/&PFIC) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF9812 CPF9801) EXEC(CHGVAR VAR(&IN91) +
                          VALUE('1'))


             IF         COND(&IN90 *EQ '1' *OR &IN91 *EQ '1') +
                          THEN(GOTO CMDLBL(STRFMT1))

 /**********  ETAPE 4 ************************/

             CHGVAR     VAR(&CHMIFS) VALUE('/home/' *TCAT &PROFIL +
                          *TCAT '/' *TCAT &PFIC)
             RMVDIR     DIR(&CHMIFS) SUBTREE(*ALL)
             MONMSG     MSGID(CPFA0A9 CPFA0B7)
             MKDIR      DIR(&CHMIFS)

             SNDPGMMSG  MSG(&CHMIFS)

 /******  ETAPE 5  *********/

             DSPFD      FILE(&PBIB/&PFIC) TYPE(*MBR) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/TEMPFILE)
             OVRDBF     FILE(QAFDMBR) TOFILE(QTEMP/TEMPFILE) MBR(*ALL)

/***************  ETAPE6     *****/

 LECTMBR:    RCVF       OPNID(W)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FINLECT))
             CHGVAR     VAR(&COUNT) VALUE(&COUNT +1)
             IF         COND(&W_MBSEU2 *EQ '          ') THEN(CHGVAR +
                          VAR(&W_MBSEU2) VALUE('txt'))
             CHGVAR     VAR(&FICIFS) VALUE(&chmifs *tcat '/' +
                          *TCAT &w_MBNAME *TCAT '.' *tcat &w_MBSEU2)

         /*COPIE  */
             CPYTOSTMF  FROMMBR('/QSYS.LIB/' *TCAT &PBIB *TCAT +
                          '.LIB/' *TCAT &PFIC *TCAT '.FILE/' *TCAT +
                          &W_MBNAME *TCAT '.MBR') TOSTMF(&FICIFS) +
                          STMFOPT(*REPLACE) STMFCCSID(1208)

             GOTO       CMDLBL(LECTMBR)
 FINLECT:    SNDRCVF    RCDFMT(FMT2)
             DLTOVR     FILE(QAFDMBR)
             MONMSG     MSGID(CPF9841)

 ENDPGM:     ENDPGM
```
