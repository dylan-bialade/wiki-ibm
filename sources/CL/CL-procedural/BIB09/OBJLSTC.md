---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: OBJLSTC
type: CL/CL-procedural
longueur_enregistrement: 120
lignes: 34
modifie: 2026-11-16
---

# BIB09/QSOURCES/OBJLSTC

```cl
             PGM        PARM(&BIBLIO &EXISTE)

             /* ============================================= */
             /* OBJLSTC - CL : Extraction objets via DSPOBJD  */
             /* Paramètres :                                   */
             /*   &BIBLIO : Nom de la bibliothèque à lister    */
             /*   &EXISTE : Retour '1' = OK, '0' = introuvable */
             /* ============================================= */

             DCL        VAR(&BIBLIO) TYPE(*CHAR) LEN(10)
             DCL        VAR(&EXISTE) TYPE(*CHAR) LEN(1)

             /* Par défaut, la bibliothèque existe */
             CHGVAR     VAR(&EXISTE) VALUE('1')

             /* Vérifier l'existence de la bibliothèque */
             CHKOBJ     OBJ(&BIBLIO) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9801) EXEC(DO)
                CHGVAR     VAR(&EXISTE) VALUE('0')
                GOTO       CMDLBL(FIN)
             ENDDO

             /* Supprimer l'ancien fichier si existant */
             DLTF       FILE(QTEMP/OBJLSTP)
             MONMSG     MSGID(CPF2105)

             /* Extraire les objets via DSPOBJD */
             DSPOBJD    OBJ(&BIBLIO/*ALL) +
                           OBJTYPE(*ALL) +
                           DETAIL(*BASIC) +
                           OUTPUT(*OUTFILE) +
                           OUTFILE(QTEMP/OBJLSTP)

 FIN:        ENDPGM
```
