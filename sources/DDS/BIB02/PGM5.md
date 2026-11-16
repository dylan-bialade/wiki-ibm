---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: PGM5
type: DDS
longueur_enregistrement: 100
lignes: 18
modifie: 2026-11-16
---

# BIB02/QDDSRC/PGM5

```text
             PGM        parm(&BIB)
             DCL        VAR(&BIB) TYPE(*CHAR) LEN(10)


            /* Verifier l'existence de la bib */
             CHKOBJ     OBJ(QSYS/RACES) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9801) EXEC(GOTO FIN)

            /* Substitué la bib d'origine RACEL1 */
             OVRDBF     FILE(RACEL1) tofile(&BIB/RACEL1)

             /*appelez le programme */

             call       RACES/RACER



 FIN:        ENDPGM
```
