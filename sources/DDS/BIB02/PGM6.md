---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: PGM6
type: DDS
longueur_enregistrement: 100
lignes: 24
modifie: 2026-11-16
---

# BIB02/QDDSRC/PGM6

```text
             PGM        parm(&BIB)

             DCL        VAR(&BIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&DATA) TYPE(*CHAR) LEN(1)
             DCL        VAR(&DATAVRF) TYPE(*CHAR) LEN(10)

             RTVDTAARA  DTAARA(BIB02/AUTOR (1 1)) RTNVAR(&DATA)
             IF         COND(&DATA *EQ 'N') THEN(GOTO CMDLBL(FIN))

             RTVDTAARA  DTAARA(BIB02/VRFDTA (1 3 )) RTNVAR(&DATAVRF)
             IF         COND(&DATAVRF *NE %SST(&BIB 1 3)) THEN(GOTO CMDLBL(FIN))


            /* Substitué la bib d'origine RACEL1 */
             OVRDBF     FILE(RACEL1) tofile(&BIB/RACEL1)

             /*appelez le programme */

             call       RACES/RACER



 FIN:
             ENDPGM
```
