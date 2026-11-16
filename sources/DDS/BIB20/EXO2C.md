---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: EXO2C
type: DDS
longueur_enregistrement: 80
lignes: 50
modifie: 2026-11-16
---

# BIB20/QDDSSRC/EXO2C

```text
             PGM
/* Déclaration des fichier*/
             DCLF       FILE(BIB20/RACEP) OPNID(BASEDD)
             DCLF       FILE(BIB20/PGM2D) OPNID(ECR)

             DCL        VAR(&ECR_IN30) TYPE(*LGL) VALUE('0')

 START:      OVRDBF     FILE(EXO2D) TOFILE(BIB20/EXO2D) MBR(ECRMAIN)

             IF         COND(&ECR_IN03) THEN(GOTO CMDLBL(FIN))
             IF         COND(&ECR_IN12) THEN(GOTO CMDLBL(FIN))
             SNDRCVF    RCDFMT(ECRMAIN) OPNID(ECR)


/*Lecture du fichier */


 main:       RCVF       RCDFMT(*FILE) OPNID(BASEDD)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(ERROR))

             IF         COND(&ECR_TYPECOURSE *NE &BASEDD_TPRACE) +
                          THEN(GOTO CMDLBL(MAIN))
             ELSE       CMD(GOTO CMDLBL(SUITE))

 ERROR:      CHGVAR     VAR(&ECR_TEST) VALUE('erreur ici')
             CLOSE      OPNID(BASEDD)
             CHGVAR     VAR(&ECR_IN30) VALUE('1')
             GOTO       CMDLBL(START)

 SUITE:      CHGVAR     VAR(&ECR_IN30) VALUE('0')

             OVRDBF     FILE(EXO2D) TOFILE(BIB20/EXO2D) MBR(ECR1)


/* Affectation des données du physique vers l'écran */
/* move &basedd_zone to &ecr_zone */
             CHGVAR     VAR(&ECR_NORACE) VALUE(&BASEDD_NORACE)
             CHGVAR     VAR(&ECR_NMRACE) VALUE(&BASEDD_NMRACE)
             CHGVAR     VAR(&ECR_T1RACE) VALUE(&BASEDD_T1RACE)

/* Affichage écran avec données du fichier ... */
             IF         COND(&ECR_IN03) THEN(GOTO CMDLBL(FIN))
             IF         COND(&ECR_IN12) THEN(GOTO CMDLBL(START))
             SNDRCVF    RCDFMT(ECR1) OPNID(ECR)


             GOTO       CMDLBL(main)

 /*Fin de programme*/
 FIN:        ENDPGM
```
