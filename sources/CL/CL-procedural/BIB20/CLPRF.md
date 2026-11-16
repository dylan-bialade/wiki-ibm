---
bibliotheque: BIB20
fichier_source: QEXOSRC
membre: CLPRF
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 30
modifie: 2026-11-16
---

# BIB20/QEXOSRC/CLPRF

```cl
             PGM

             DCLF       FILE(BIB20/ECRANPRF) OPNID(P)

             MONMSG     MSGID(CPF0001)
             MONMSG     MSGID(CEE0000)
 DEBUT:
             SNDRCVF    OPNID(P)

             IF         COND(&P_IN03) THEN(GOTO CMDLBL(FIN))

             RTVUSRPRF  USRPRF(&P_PROFIL)
             MONMSG     MSGID(CPF2204) EXEC(GOTO CMDLBL(ERREUR))

             CHGDTAARA  DTAARA(*LDA (120 10)) VALUE(&P_PROFIL)
             CHGDTAARA  DTAARA(*LDA (130 1)) VALUE(&P_IN03)

             CALL       PGM(BIB20/CLDESCPRF)

             RTVDTAARA  DTAARA(*LDA (130 1)) RTNVAR(&P_IN03)
             IF         COND(&P_IN03) THEN(GOTO CMDLBL(FIN))

             GOTO       CMDLBL(DEBUT)

 ERREUR:     CHGVAR     VAR(&P_IN90) VALUE('1')
             GOTO       CMDLBL(DEBUT)


 FIN:
             ENDPGM
```
