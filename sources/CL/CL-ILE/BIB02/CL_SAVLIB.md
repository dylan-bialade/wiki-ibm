---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: CL_SAVLIB
type: CL/CL-ILE
longueur_enregistrement: 160
lignes: 34
modifie: 2026-11-16
---

# BIB02/QCLLESRC/CL_SAVLIB

```cl
/*----------------------------------------------------------------------------*//* Programme : CL_SAVLIB                                                      */
/* Libellé   : CL                                                             *//*----------------------------------------------------------------------------*/
/* Projet    : BIB02                                                         *//* Auteur    : Sylvain BIB02                                                 */
/* Date      : 11/06/2024                                                     *//*----------------------------------------------------------------------------*/
             PGM                                                                             COPYRIGHT  TEXT('(C) ORGFORM 2024.')
             DCLPRCOPT  DFTACTGRP(*NO) ACTGRP(*NEW)
/* Déclaration du fichier SVBIBI2 */                                                         DCLF       FILE(SVBIBI) /* Déclaration du format du fichier */
                                                                                /* Déclaration des variables */
             DCL        VAR(&NOM_B00001) TYPE(*CHAR) LEN(10) /* Nom de la +                               bibliothèque */
             DCL        VAR(&SAVFNAME) TYPE(*CHAR) LEN(10) /* Nom du +                                    fichier de sauvegarde */
                                                                                /* Boucle pour parcourir le fichier SVBIBI2 */
 LOOP:       RCVF                                                                            MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(ENDPGM)) /* Fin de +
                          fichier */
/* Extraction du nom de la bibliothèque */                                                   CHGVAR     VAR(&NOM_B00001) VALUE(&NOM_B00001) /* Assigner la +
                          valeur du champ à la variable */
/* Vérification de l'existence de la bibliothèque */                                         CHKOBJ     OBJ(&NOM_B00001) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9801 CPF9810) EXEC(DO)                             /* Si la bibliothèque n'existe pas, continuer */
                SNDPGMMSG  MSG('La bibliothèque ' *CAT &NOM_B00001 *TCAT ' +                                 n''existe pas.')
                GOTO       CMDLBL(LOOP)                                                      ENDDO
                                                                                /* Construction du nom du fichier de sauvegarde */
             CHGVAR     VAR(&SAVFNAME) VALUE('SV_' *CAT %SST(&NOM_B00001 1 3))
/* Suppression de l'ancien fichier de sauvegarde */                                          DLTF       FILE(QGPL/&SAVFNAME)
             MONMSG     MSGID(CPF2105) /* Ignorer si le fichier n'existe pas */
/* Création du fichier de sauvegarde */                                                      CRTSAVF    FILE(QGPL/&SAVFNAME)
             MONMSG     MSGID(CPF0000) EXEC(DO)                                                 SNDPGMMSG  MSG('Erreur lors de la création du fichier de +
                             sauvegarde ' *CAT &SAVFNAME)                                       GOTO       CMDLBL(LOOP)
             ENDDO
/* Sauvegarder la bibliothèque */                                                            SAVLIB     LIB(&NOM_B00001) DEV(*SAVF) SAVF(QGPL/&SAVFNAME) +
                          SAVACT(*SYNCLIB)                                                   MONMSG     MSGID(CPF0000) EXEC(DO)
                SNDPGMMSG  MSG('Erreur lors de la sauvegarde de la +                                         bibliothèque ' *CAT &NOM_B00001)
             ENDDO
/* Passer à l'enregistrement suivant */                                                      GOTO       CMDLBL(LOOP)
                                                                                /* Fin du programme */
 ENDPGM:                                                                                     ENDPGM
```
