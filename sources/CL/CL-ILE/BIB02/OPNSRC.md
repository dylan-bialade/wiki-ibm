---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: OPNSRC
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 83
modifie: 2026-11-16
---

# BIB02/QCLLESRC/OPNSRC

```cl
/*----------------------------------------------------------------------------*/
/* Programme : OPNSRC                                                         */
/* Libellé   : OUVRIR SOURCE                                                  */
/*----------------------------------------------------------------------------*/
/* Projet    : TOOLS                                                         */
/* Auteur    : Sylvain BIB02                                                 */
/* Date      : 25/06/2023                                                     */
/*----------------------------------------------------------------------------*/
             PGM        PARM(&SOURCE)
             COPYRIGHT  TEXT('(C) ARMONIE 2023.')
             DCLPRCOPT  USRPRF(*OWNER) DFTACTGRP(*NO) ACTGRP(*CALLER)

/******************************************************************************/
/* DECLARATION DES VARIABLES                                                  */
/******************************************************************************/

             DCL        VAR(&SOURCE) TYPE(*CHAR) LEN(10)
/*----------------------------------------------------------------------------*/
/* TRAITEMENT                                                                 */
/*----------------------------------------------------------------------------*/
             DCL        VAR(&CONDITION) TYPE(*LGL) VALUE('1') /* La +
                          condition initiale */

   /* Boucle DO WHILE */
             DO         WHILE COND(&CONDITION)

      /* Votre action à exécuter (STRSEU dans ce cas) */
                STRSEU

      /* Vérification de la condition pour décider si la boucle doit continuer *
      /* Par exemple, vérifiez si une certaine condition est vraie ou non */
      /* Si la condition est vraie, la boucle continue, sinon elle se termine */
      /* Ici, nous définissons &CONDITION à '0' pour arrêter la boucle */
      /* Vous devez personnaliser cette partie en fonction de votre condition */
                IF         /* Votre condition pour continuer la boucle */
                CHGVAR     VAR(&CONDITION) VALUE('0')
                ENDIF

             ENDDO

             DO
             ENDDO

             STRSEU     SRCFILE(BIB02/QRPGLESRC) SRCMBR(&SOURCE) OPTION(5)
             MONMSG     MSGID(EDT0223 EDT9007 CPF0001)

             STRSEU     SRCFILE(BIB02/QDDSLESRC) SRCMBR(&SOURCE) OPTION(5)
             MONMSG     MSGID(EDT0223 EDT9007 CPF0001)

             STRSEU     SRCFILE(BIB02/QCLLESRC) SRCMBR(&SOURCE) OPTION(5)
             MONMSG     MSGID(EDT0223 EDT9007 CPF0001)

             STRSEU     SRCFILE(BIB02/QDDSSRC) SRCMBR(&SOURCE) OPTION(5)
             MONMSG     MSGID(EDT0223 EDT9007 CPF0001)

             STRSEU     SRCFILE(BIB02/QDDSRC) SRCMBR(&SOURCE) OPTION(5)
             MONMSG     MSGID(EDT0223 EDT9007 CPF0001)

             STRSEU     SRCFILE(BIB02/QRPGSRC) SRCMBR(&SOURCE) OPTION(5)
             MONMSG     MSGID(EDT0223 EDT9007 CPF0001)

             STRSEU     SRCFILE(BIB02/QSQLSRC) SRCMBR(&SOURCE) OPTION(5)
             MONMSG     MSGID(EDT0223 EDT9007 CPF0001)

             STRSEU     SRCFILE(*LIBL/QCMDSRC) SRCMBR(&SOURCE) OPTION(5)
             MONMSG     MSGID(EDT0223 EDT9007 CPF0001)

             STRSEU     SRCFILE(*LIBL/QSRC) SRCMBR(&SOURCE) OPTION(5)
             MONMSG     MSGID(EDT0223 EDT9007 CPF0001)

             STRSEU     SRCFILE(*LIBL/QSOURCE) SRCMBR(&SOURCE) OPTION(5)
             MONMSG     MSGID(EDT0223 EDT9007 CPF0001)

             STRSEU     SRCFILE(*LIBL/QSOURCES) SRCMBR(&SOURCE) OPTION(5)
             MONMSG     MSGID(EDT0223 EDT9007 CPF0001)

             STRSEU     SRCFILE(*LIBL/QAPISRC) SRCMBR(&SOURCE) OPTION(5)
             MONMSG     MSGID(EDT0223 EDT9007 CPF0001) EXEC(DO)
      /* La bibliothèque existe déjà, afficher un message d'erreur */
                SNDPGMMSG  MSG('La source existe pas.') MSGTYPE(*INFO)
                RETURN
             ENDDO
             ENDPGM
```
