---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: BONJOUR
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 27
modifie: 2026-11-16
---

# BIB02/QCLLESRC/BONJOUR

```cl
/********************************************************************/
/*                                                                  */
/* 5770SS1 V7R4M0 190621 Sortie RTVCLSRC         15/10/24 13:36:29  */
/*                                                                  */
/* Nom du programme . . . . . . . . . . . . :   BONJOUR           PN*/
/* Nom de la bibliothèque . . . . . . . . . :   SAGNAL            PL*/
/* Fichier source initial . . . . . . . . . :   QCLSRC            SN*/
/* Nom de la bibliothèque . . . . . . . . . :   SAGNAL            SL*/
/* Membre source initial  . . . . . . . . . :   BONJOUR           SM*/
/* Modification du fichier source                                   */
/*   date/heure . . . . . . . . . . . . . . :   09/09/24 14:05:37 SC*/
/* Option de modification . . . . . . . . . :   *NOPATCH          PO*/
/* Profil utilisateur . . . . . . . . . . . :   *USER             UP*/
/* Texte  . . : Premier CL                                        TX*/
/* Propriétaire . . . . . . . . . . . . . . :   LUDOVIC           OW*/
/* Marquage modification utilisateur  . . . :   *YES              UM*/
/* Extraire source inclus   . . . . . . . . :   *NO               RI*/
/*                                                                ED*/
/********************************************************************/
     PGM
     DCL VAR(&VARIABLE) TYPE(*CHAR) VALUE('sagnal')
     DCL VAR(&NUMERIQUE) TYPE(*DEC) LEN(3 0)
     CHGVAR VAR(&NUMERIQUE) VALUE(123)
     CHGCURLIB CURLIB(&VARIABLE)
     ADDLIBLE LIB(&VARIABLE)
     MONMSG MSGID(CPF2103)
     ENDPGM
```
