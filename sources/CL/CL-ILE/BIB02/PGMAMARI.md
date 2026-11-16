---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: PGMAMARI
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 26
modifie: 2026-11-16
---

# BIB02/QCLLESRC/PGMAMARI

```cl
/*----------------------------------------------------------------------------*/
/* Programme : CL_SAVLIB                                                      */
/* Libellé   : CL                                                             */
/*----------------------------------------------------------------------------*/
/* Projet    : BIB02                                                         */
/* Auteur    : Sylvain BIB02                                                 */
/* Date      : 18/11/2022                                                     */
/*----------------------------------------------------------------------------*/
             PGM        PARM(&LIB)
             COPYRIGHT  TEXT('(C) ARMONIE 2023.')
             DCLPRCOPT  USRPRF(*OWNER) DFTACTGRP(*NO) ACTGRP(*CALLER)


             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)


               /* Change la curlib par celui passé en paramètre */
             CHGCURLIB  CURLIB(&LIB)

             /* Ajoute la lib par celui passé en paramètre */
             ADDLIBLE   LIB(&LIB) POSITION(*FIRST)
             MONMSG     MSGID(CPF2103)



             ENDPGM
```
