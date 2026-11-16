---
bibliotheque: BIB01
fichier_source: QCLSRC
membre: BONBONCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 19
modifie: 2026-11-16
---

# BIB01/QCLSRC/BONBONCL

```cl
             PGM
             DCLF       FILE(BONBON) OPNID(F)
             DCLF       FILE(BONBONFM)



 BOUCLE:     RCVF       OPNID(F)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))
             CHGVAR     VAR(&MARQUE) VALUE(&F_MARQUE)
             CHGVAR     VAR(&NOM) VALUE(&F_NOM)
             CHGVAR     VAR(&COULEUR) VALUE(&F_COULEUR)
             CHGVAR     VAR(&PRIX) VALUE(&F_PRIX)
             CHGVAR     VAR(&NUMBER) VALUE(&F_NUMBER)


             SNDRCVF    RCDFMT(FMT1)
             GOTO       CMDLBL(BOUCLE)

 FIN:        ENDPGM
```
