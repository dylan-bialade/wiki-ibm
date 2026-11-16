---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: USERCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 38
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/USERCL

```cl
             PGM
/* DECLARATION DE FICHIER                     */
             DCLF       FILE(USERFM)

/* DECLARATION DE VARIABLE                    */
             DCL        VAR(&ERR) TYPE(*LGL) VALUE('0')
             CHGVAR     VAR(&INLPGM) VALUE(' ')

/* AFFICHAGE DE L'ECRAN                       */
 ECRAN1:    SNDRCVF    RCDFMT(FMT1)
             CHGVAR     VAR(&IN99) VALUE('0')

/* FUNCTION KEYS                              */
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))

/* CHAMP USER NON VIDE                        */
             IF         COND(&USER *NE ' ') THEN(GOTO CMDLBL(RTV))
             GOTO       CMDLBL(ECRAN1)

/* TRAITEMENT PRINCIPAL                       */
 RTV:        RTVUSRPRF  USRPRF(&USER) RTNUSRPRF(&PROFIL) +
                          INLPGM(&INLPGM) OUTQ(&OUTQ) +
                          CURLIB(&CURLIB) CCSID(&CCSID)

/* GESTION ERREUR                             */
             MONMSG     MSGID(CPF0000) EXEC(DO)
             CHGVAR     VAR(&IN99) VALUE('1')
             GOTO       CMDLBL(ECRAN1)
             ENDDO
             GOTO       CMDLBL(ECRAN2)

/* AFFICHAGE ECRAN 2                          */
 ECRAN2:     SNDRCVF    RCDFMT(FMT2)
             IF         COND(&IN12) THEN(GOTO CMDLBL(ECRAN1))
             GOTO       CMDLBL(FIN)

/* FIN DE TRAITEMENT                          */
 FIN:        ENDPGM
```
