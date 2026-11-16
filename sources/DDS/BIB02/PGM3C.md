---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: PGM3C
type: DDS
longueur_enregistrement: 100
lignes: 44
modifie: 2026-11-16
---

# BIB02/QDDSRC/PGM3C

```text
             PGM
             DCLPRCOPT  ALWRTVSRC(*NO) USRPRF(*OWNER)

/* Déclaration des fichier*/
             DCLF       FILE(RACES/RACEP) OPNID(R)
             DCLF       FILE(BIB02/PGM3D)

/*Affichage, saisie du premier format */
 AFF1:       OPNDBF     FILE(RACES/RACEP) OPTION(*INP) OPNID(R)
             MONMSG     MSGID(CPF4174) /*Déjà ouvert! et on s'en +
                          fout */

             SNDRCVF    RCDFMT(ECR0)
             IF COND(&IN03) THEN(GOTO CMDLBL(FIN))

/*Lecture du fichier */
 LECT:       RCVF       RCDFMT(RACEFMT) OPNID(R)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))

             IF         COND(&CATRACE *NE &R_TPRACE) THEN(GOTO +
                          CMDLBL(LECT))

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

 /*Fin de programme*/
 FIN:        CLOSE OPNID(R)
             ENDPGM
```
