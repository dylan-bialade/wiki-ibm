---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: PGM3C1
type: DDS
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-16
---

# BIB02/QDDSRC/PGM3C1

```text
             PGM
             DCLPRCOPT  ALWRTVSRC(*NO) USRPRF(*OWNER)

/* Déclaration des fichier*/
             DCLF       FILE(RACES/RACEP) OPNID(R)
             DCLF       FILE(BIB02/PGM3D)

             SNDRCVF    RCDFMT(ECR0)

             IF         COND(&IN03) THEN(GOTO CMDLBL(FIN))
             call       BIB02/PGM3C2 parm(&CATRACE)
 FIN:
             ENDPGM
```
