---
bibliotheque: BIB25
fichier_source: QCLLESRC
membre: ALERT
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 28
modifie: 2026-11-25
---

# BIB25/QCLLESRC/ALERT

```cl
             PGM
             DCL        VAR(&TIME) TYPE(*CHAR) LEN(10)
             DCL        VAR(&HH) TYPE(*CHAR) LEN(10)

             /* Récupération de l'heure du système */
             RTVSYSVAL  SYSVAL(QTIME) RTNVAR(&TIME)

             /* Extraction de l'heure  */
             CHGVAR     VAR(&HH) VALUE(%SST(&TIME 1 2))

             /* Contrôle horraire     */
             IF         COND(&HH *GE '13') THEN(GOTO CMDLBL(END))
             IF         COND(&HH *LT '11') THEN(GOTO CMDLBL(END))

             /* Appel du check des logs   */
             /* CALL PGM --> Vérification des logs */

             /* Envoie Email d'alerte    */
             SNDSMTPEMM RCP(('adresse@exemple.invalid')) +
                          SUBJECT('Alerte Traitement RAPPROADD / +
                          RAPPSVADD') NOTE('Une anomalie a été +
                          détectée sur l''interface de +
                          rapprochement entre ANAEL et KYRIBA')

             /* Replanification du JOB */
             /* SBMJOB     CMD(CALL PGM(BIB25/ALERT)) */

 END:        ENDPGM
```
