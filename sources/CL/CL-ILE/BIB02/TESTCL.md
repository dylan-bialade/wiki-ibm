---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: TESTCL
type: CL/CL-ILE
longueur_enregistrement: 160
lignes: 12
modifie: 2026-11-16
---

# BIB02/QCLLESRC/TESTCL

```cl
/*----------------------------------------------------------------------------*//* Programme : TESTCL                                                   */
/* Libellé   : CLLE                                                           *//*----------------------------------------------------------------------------*/
/* Projet    : BIB02                                                         *//* Auteur    : Sylvain BIB02                                                 */
/* Date      : 09/04/2023                                                     *//*----------------------------------------------------------------------------*/
             PGM                                                                             COPYRIGHT  TEXT('(C) ORGFORM 2023.')
             DCL        VAR(&SAVF) TYPE(*CHAR) LEN(10) VALUE(SVENT)                          DCL        VAR(&BIB) TYPE(*CHAR) LEN(10) VALUE(BORG)
                                                                                             ADDLIBLE   LIB(&BIB) POSITION(*LAST)
             CPYF       FROMFILE(BIB02/ENTREPOT) TOFILE(BIB02/ENTREPOT2) +                              MBROPT(*ADD) CRTFILE(*YES)
             CRTSAVF    FILE(&BIB/&SAVF)                                                     SAVOBJ     OBJ(ENTREPOT2) LIB(BIB02) DEV(*SAVF) +
                          OBJTYPE(*FILE) SAVF(&BIB/&SAVF)                                    ADDLIBLE   LIB(&BIB) POSITION(*LAST)

             ENDPGM
```
