---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: PGM2C
type: DDS
longueur_enregistrement: 80
lignes: 22
modifie: 2026-11-16
---

# BIB20/QDDSSRC/PGM2C

```text
             PGM
/* Déclaration des fichier*/
             DCLF       FILE(MDA/RACEP) OPNID(BASEDD)
             DCLF       FILE(BORG/PGM2D) OPNID(ECR)

/*Lecture du fichier */
 BOUCLE:     RCVF       RCDFMT(*FILE) OPNID(BASEDD)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))

/* Affectation des données du physique vers l'écran */
/* move &basedd_zone to &ecr_zone */
             CHGVAR     VAR(&ECR_NORACE) VALUE(&BASEDD_NORACE)
             CHGVAR     VAR(&ECR_NMRACE) VALUE(&BASEDD_NMRACE)
             CHGVAR     VAR(&ECR_T1RACE) VALUE(&BASEDD_T1RACE)

/* Affichage écran avec données du fichier ... */
             SNDRCVF    RCDFMT(*FILE) OPNID(ECR)
             IF         COND(&ECR_IN03) THEN(GOTO CMDLBL(FIN))
             GOTO       CMDLBL(BOUCLE)

 /*Fin de programme*/
 FIN:        ENDPGM
```
