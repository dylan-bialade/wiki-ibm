---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: EXOCL3
type: DDS
longueur_enregistrement: 100
lignes: 70
modifie: 2026-11-16
---

# BIB02/QDDSRC/EXOCL3

```text
             PGM
             DCLF       FILE(BIB02/RACEP) OPNID(R)
             DCLF       FILE(BIB02/PG3M3)

DEBUT:
             SNDRCVF    RCDFMT(FMT5)
             IF COND(&IN03) THEN(GOTO CMDLBL(FIN))

 BOUCLE:     RCVF       PGM
             DCLPRCOPT  ALWRTVSRC(*NO) USRPRF(*OWNER)

/* Déclaration des fichier*/
             DCLF       FILE(RACES/RACEP) OPNID(R)
             DCLF       FILE(MDA/PGM3D)
 /*            DCL        VAR(&IN50) TYPE(*DEC) VALUE(0)    */


/*Affichage, saisie du premier format */
 AFF1:       OPNDBF     FILE(RACES/RACEP) OPTION(*INP) OPNID(R)
             MONMSG     MSGID(CPF4174) /*Déjà ouvert! et on s'en fout */

             SNDRCVF    RCDFMT(ECR0)
             IF         COND(&IN03) THEN(GOTO CMDLBL(FIN))
             CHGVAR     VAR(&IN50) VALUE('1') /* pas encore trouvé */
/*Lecture du fichier */
 LECT:       RCVF       RCDFMT(RACEFMT) OPNID(R)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(RETSCR1))

             IF         COND(&CATRACE *NE &R_TPRACE) THEN(GOTO CMDLBL(LECT))
             CHGVAR     VAR(&IN50) VALUE('0') /* trouvé */

/* Affectation des données du physique vers l'écran */
             CHGVAR     VAR(&NORACE) VALUE(&R_NORACE)
             CHGVAR     VAR(&NMRACE) VALUE(&R_NMRACE)
             CHGVAR     VAR(&T1RACE) VALUE(&R_T1RACE)

/**********************************************************/
 DOMP:       DMPCLPGM   /* DOMP !!! */
/**********************************************************/

/* Affichage écran avec données du fichier ... */
             SNDRCVF    RCDFMT(ECR1)
             IF         COND(&IN03) THEN(GOTO CMDLBL(FIN))
             IF         COND(&IN12) THEN(DO)
                CLOSE      OPNID(R)
                GOTO       CMDLBL(AFF1)
             ENDDO

             GOTO       CMDLBL(LECT)
 RETSCR1:
             CLOSE      OPNID(R)
             GOTO       CMDLBL(AFF1)

 /*Fin de programme*/
 FIN:        CLOSE      OPNID(R)
             ENDPGM     RCDFMT(RACEFMT) OPNID(R)

             CHGVAR     VAR(&NORACE) VALUE(&R_NORACE)
             CHGVAR     VAR(&NMRACE) VALUE(&R_NMRACE)
             CHGVAR     VAR(&T1RACE) VALUE(&R_T1RACE)
             CHGVAR     VAR(&TPRACE) VALUE(&R_TPRACE)

             SNDRCVF    RCDFMT(FMT5)
             IF         COND(&IN03) THEN(GOTO CMDLBL(FIN))
             IF         COND(&IN12) THEN(GOTO CMDLBL(DEBUT))

             GOTO       CMDLBL(BOUCLE)

 FIN:
             ENDPGM
```
