---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: GPT
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 48
modifie: 2026-11-16
---

# BIB02/QCLLESRC/GPT

```cl
             PGM        PARM(&USERNAME)

   /* Déclaration des variables */
             DCL        VAR(&USERNAME) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SRCFILE) TYPE(*CHAR) LEN(10)
             DCL        VAR(&FROMMBR) TYPE(*CHAR) LEN(10)
             DCL        VAR(&TOLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&TOMBR) TYPE(*CHAR) LEN(10)
             DCL        VAR(&LIBFOUND)  TYPE(*CHAR) LEN(10)
             DCL        VAR(&MBRFOUND) TYPE(*CHAR) LEN(10)

   /* Définir les noms de source et de bibliothèque source */
             CHGVAR     VAR(&SRCFILE) VALUE('QRPGLESRC')
             CHGVAR     VAR(&FROMMBR) VALUE('USERAPI')
             CHGVAR     VAR(&TOLIB) VALUE('QDDSLESRC')
             CHGVAR     VAR(&TOMBR) VALUE('SFUSERDSPF')

   /* Vérifier si les bibliothèques existent */
             CHKOBJ     OBJ(&SRCFILE) OBJTYPE(*FILE) MBR(&LIBFOUND)
             CHKOBJ     OBJ(&TOLIB) OBJTYPE(*LIB) MBR(&LIBFOUND)

   /* Si les bibliothèques existent, copier les membres source */
             IF         COND(CHKOBJ='0') THEN(DO)

      /* Vérifier si le membre source USERAPI existe */
                CHKOBJ     OBJ(&SRCFILE/&FROMMBR) OBJTYPE(*MBR) MBR(&MBRFOUND)

      /* Si le membre source USERAPI existe, copier */
                IF         COND(&MBRFOUND) THEN(DO)
                   CPYSRCF    FROMFILE(&SRCFILE) TOFILE(&TOLIB) +
                                FROMMBR(&FROMMBR) TOMBR(&TOMBR)
                ENDDO

      /* Sinon, afficher un message d'erreur */
                ELSE       CMD(SNDPGMMSG MSG('Le membre source ' +
                             &SRCFILE/&FROMMBR *TCAT ' n''existe pas.') +
                             MSGTYPE(*ERROR))
             ENDDO

   /* Sinon, afficher un message d'erreur */
             ELSE       CMD(SNDPGMMSG MSG('La bibliothèque ' &SRCFILE +
                          *BCAT ' ou ' *BCAT &TOLIB *BCAT ' n''existe +
                          pas.') MSGTYPE(*ERROR))

   ENDDO

   /* Fin du programme CLLE */
   ENDPGM
```
