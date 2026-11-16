---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: JEU1
type: CL/CL-ILE
longueur_enregistrement: 120
lignes: 11
modifie: 2026-11-16
---

# BIB02/QCLLESRC/JEU1

```cl
/*----------------------------------------------------------------------------*//* Programme : TESTCL
                                */      /* Libellé   : CLLE                                                           */
/*----------------------------------------------------------------------------*//* Projet    : BIB02
                                      *//* Auteur    : Sylvain BIB02                                                 */
/* Date      : 09/04/2023                                                     *//*--------------------------------------
--------------------------------------*/             PGM
             COPYRIGHT  TEXT('(C) ARMONIE 2023.')                                            DCL        VAR(&SAVF) TYPE(
*CHAR) LEN(10) VALUE(SVENT)                          DCL        VAR(&BIB) TYPE(*CHAR) LEN(10) VALUE(BIB02)
                                                                                             CRTLIB     LIB(&BIB)
                                                     ADDLIBLE   LIB(&BIB) POSITION(*LAST)
                                                                                             ENDPGM
```
