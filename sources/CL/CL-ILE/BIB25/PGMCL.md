---
bibliotheque: BIB25
fichier_source: QCLLESRC
membre: PGMCL
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 39
modifie: 2026-11-25
---

# BIB25/QCLLESRC/PGMCL

```cl
             PGM
             /* Déclaration écran */
             DCLF       FILE(BIB25/ECRAN)

             /* Déclaration fichier système pour sortie OUTFILE */
             DCLF       FILE(QSYS/QADSPUPB) OPNID(F)

             /* Initialisation variable écran */
             CHGVAR     VAR(&NB_PGMR) VALUE(0)
             CHGVAR     VAR(&NB_SECOFR) VALUE(0)
             CHGVAR     VAR(&NB_USER) VALUE(0)

             /* Récupération utilisateurs du système OUTFILE */
             DSPUSRPRF  USRPRF(*ALL) OUTPUT(*OUTFILE) +
                          OUTFILE(QTEMP/DSPUSRPRF)

             /* Boucle de lecture OUTFILE */
             OVRDBF     FILE(QADSPUPB) TOFILE(QTEMP/DSPUSRPRF)
 BOUCLE:     RCVF       OPNID(F)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(AFFICHAGE))
             /* Calcul nombre utilisateurs */
             IF         COND(&F_UPUSCL *EQ '*PGMR') THEN(DO)
             CHGVAR     VAR(&NB_PGMR) VALUE(&NB_PGMR + 1)
             ENDDO
             IF         COND(&F_UPUSCL *EQ '*SECOFR') THEN(DO)
             CHGVAR     VAR(&NB_SECOFR) VALUE(&NB_SECOFR + 1)
             ENDDO
             IF         COND(&F_UPUSCL *EQ '*USER') THEN(DO)
             CHGVAR     VAR(&NB_USER) VALUE(&NB_USER + 1)
             ENDDO
             GOTO       CMDLBL(BOUCLE)
             /* Affichage de l'écran */
 AFFICHAGE:  SNDRCVF    RCDFMT(FMT1)
             IF         COND(&IN03 *EQ '1') THEN(DO)
             GOTO       CMDLBL(FIN)
             ENDDO
             GOTO       CMDLBL(AFFICHAGE)
             /* Sortie du programme si appuie sur F3 */
 FIN:        ENDPGM
```
