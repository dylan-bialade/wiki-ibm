---
bibliotheque: BIB27
fichier_source: QPROCSRC
membre: PROC_T1
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 52
modifie: 2026-11-25
---

# BIB27/QPROCSRC/PROC_T1

```rpg
**free

//***********************************************************//
// Programme : PROC_T1                                       //
// Principe : Utilisation de procédure stockées              //
// Date :  24/05/2024                                        //
// Dev : Léo BIB27                                         //
// **********************************************************//

//***********************************************************//
// Procédure : TEST1                                         //
// Bobliothèque : BIB27                                    //
//***********************************************************//


//***********************************************************//
// Requête SQL pour retrouver nos procédures                 //
// SELECT * FROM QSYS2.SYSROUTINES                           //
// WHERE specific_schema = 'BIB27';                        //
//***********************************************************//


//***********************************************************//
// Déclaration Variables                                     //
//***********************************************************//
DCL-S TITLE VARCHAR(50);
DCL-S ID INT(3);

//***********************************************************//
// Déclaration de la procédure                               //
//***********************************************************//

dcl-pr TEST1 extpgm('BIB27/TEST1');
    id_book int(3);
    title_book varchar(100);
END-PR;

//***********************************************************//
// Traitement principal                                      //
//***********************************************************//

EXEC SQL
SET OPTION COMMIT = *NONE;

ID = 5;

EXEC SQL
CALL TEST1(:ID, :TITLE);

DSPLY TITLE;

*INLR = *ON;
```
