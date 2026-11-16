---
bibliotheque: BIB20
fichier_source: QTESTSRC
membre: TESTCO
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 102
modifie: 2026-11-16
---

# BIB20/QTESTSRC/TESTCO

```cl
             PGM

             DCLF       FILE(BIB20/TESTCOECR)

             DCL        VAR(&HOTE) TYPE(*CHAR)
             DCL        VAR(&NULL) TYPE(*CHAR)
             DCL        VAR(&NBJOUEUR) TYPE(*DEC)
             DCL        VAR(&USRCUR) TYPE(*CHAR)
             DCL        VAR(&PLJOUEUR) TYPE(*DEC)
             DCL        VAR(&CHAR) TYPE(*CHAR)
             DCL        VAR(&NBJPGM) TYPE(*DEC) VALUE(1)
             DCL        VAR(&NBPPGM) TYPE(*DEC) VALUE(30)
             DCL        VAR(&CONNECT) TYPE(*LGL) VALUE('0')
             DCL        VAR(&LAUNCH) TYPE(*LGL) VALUE('0')

             RTVJOBA    USER(&USRCUR)


 DEBUT:      CHKOBJ     OBJ(BIB20/PLAYGAME) OBJTYPE(*DTAARA)
             MONMSG     MSGID(CPF9801) EXEC(CRTDTAARA +
                          DTAARA(BIB20/PLAYGAME) TYPE(*CHAR))

             RTVDTAARA  DTAARA(BIB20/PLAYGAME (1 10)) RTNVAR(&HOTE)

      /* 20 pour 2 characteres est pour le nb joueurs */
             IF         COND(&HOTE *EQ &NULL) THEN(DO)
                CHGDTAARA  DTAARA(BIB20/PLAYGAME (1 10)) VALUE(&USRCUR)
                CHGDTAARA  DTAARA(BIB20/PLAYGAME (20 2)) VALUE(1)
             CHGDTAARA  DTAARA(BIB20/PLAYGAME (25 1)) VALUE(0)
                CHGVAR     VAR(&HOTE) VALUE(&CURUSR)
             ENDDO

             IF         COND(&CONNECT) THEN(GOTO CMDLBL(NOCONNECT))
             ELSE       CMD(GOTO CMDLBL(CONNEXION))


     /* On se connect */
 CONNEXION:  RTVDTAARA  DTAARA(BIB20/PLAYGAME (20 2)) +
                          RTNVAR(&NBJOUEUR)

     /* a partir de 30 pour les joueurs*/

             CHGVAR     VAR(&PLJOUEUR) VALUE(30 + &NBJOUEUR * 10)
             CHGDTAARA  DTAARA(BIB20/PLAYGAME (&PLJOUEUR 10)) +
                          VALUE(&USRCUR)
             CHGVAR     VAR(&CONNECT) VALUE('1')

 NOCONNECT:  RTVDTAARA  DTAARA(BIB20/PLAYGAME (20 2)) +
                          RTNVAR(&NBJOUEUR)

             RTVDTAARA  DTAARA(BIB20/PLAYGAME (1 10)) RTNVAR(&HOTE)


             DOWHILE    COND(&NBJPGM *LE &NBJOUEUR *OR &NBPPGM *LT 80)

             SELECT
               WHEN       COND(&NBJPGM *EQ '1') THEN(RTVDTAARA +
                          DTAARA(BIB20/PLAYGAME (&NBPPGM 10)) +
                          RTNVAR(&JOUEUR1))
               WHEN       COND(&NBJPGM *EQ '2') THEN(RTVDTAARA +
                          DTAARA(BIB20/PLAYGAME (&NBPPGM 10)) +
                          RTNVAR(&JOUEUR2))
               WHEN       COND(&NBJPGM *EQ '3') THEN(RTVDTAARA +
                          DTAARA(BIB20/PLAYGAME (&NBPPGM 10)) +
                          RTNVAR(&JOUEUR3))
                WHEN       COND(&NBJPGM *EQ '4') THEN(RTVDTAARA +
                           DTAARA(BIB20/PLAYGAME (&NBPPGM 10)) +
                           RTNVAR(&JOUEUR4))
                WHEN       COND(&NBJPGM *EQ '5') THEN(RTVDTAARA +
                           DTAARA(BIB20/PLAYGAME (&NBPPGM 10)) +
                           RTNVAR(&JOUEUR5))
             ENDSELECT

             ENDDO

             IF         COND(&HOTE *EQ &CURUSR) THEN(CHGVAR +
                          VAR(&COMMANDE) VALUE('Appuyez sur F10 +
                          pour lancer'))
             ELSE       CMD(CHGVAR VAR(&COMMANDE) VALUE('Veuillez +
                          patienter'))

             RTVDTAARA  DTAARA(BIB20/PLAYGAME (25 1)) RTNVAR(&LAUNCH)

             IF         COND(&LAUNCH) THEN(DO)
                OVRDBF     FILE(PLAYGAME) TOFILE(BIB20/PLAYGAME) +
                          MBR(LANCER)
                SNDRCVF
                ENDDO
             ELSE       CMD(DO)
                 SNDRCVF    WAIT(*NO)
                 DLYJOB     DLY(2)
             ENDDO









             ENDPGM
```
